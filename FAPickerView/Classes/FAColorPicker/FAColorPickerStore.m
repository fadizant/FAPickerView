//
//  FAColorPickerStore.m
//
//  Created by Fadi Abuzant on 3/4/18.
//  Copyright © 2018 fadizant. All rights reserved.

#import <CommonCrypto/CommonDigest.h>
#import "FAColorPickerStore.h"
#import "FAColorPicker.h"
#import <MobileCoreServices/MobileCoreServices.h>

#define FAColorPICKER_FOLDER_NAME @"FAColorPicker"

@import ImageIO;

#define FA_COLOR_PICKER_FIND_AND_REPLACE_OPTION_GET_ONLY 0
#define FA_COLOR_PICKER_FIND_AND_REPLACE_OPTION_MOVE_TO_FRONT 1
#define FA_COLOR_PICKER_FIND_AND_REPLACE_OPTION_KEEP_IN_PLACE 2
#define FA_COLOR_PICKER_FIND_AND_REPLACE_OPTION_DELETE 3

static FAColorPickerStore* s_instance;
static CGFloat s_thumbnailSizePixels;
static CGFloat s_thumbnailSizePoints;

@interface FAColorPickerStore ()

// for fast thumbnail retrieval
@property (nonatomic, strong, readonly) NSCache* cache;

// turn off saving if bulk creating colors, must manually call save when done
@property (nonatomic, assign) BOOL disableSave;

@end

@implementation FAColorPickerStore

+ (void) initialize
{
    if (self == FAColorPickerStore.class)
    {
        s_instance = [[FAColorPickerStore alloc] initAsSingleton];

        s_thumbnailSizePixels = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? (UIScreen.mainScreen.scale * FAColorPickerThumbnailSizeInPointsPad) : (UIScreen.mainScreen.scale * FAColorPickerThumbnailSizeInPointsPhone));
        s_thumbnailSizePoints = s_thumbnailSizePixels / UIScreen.mainScreen.scale;
    }
}

+ (instancetype) sharedInstance
{
    return s_instance;
}

+ (CGFloat) thumbnailSizePixels
{
    return s_thumbnailSizePixels;
}

+ (CGFloat) thumbnailSizePoints
{
    return s_thumbnailSizePoints;
}

+ (NSString*) md5Data:(NSData*)input
{
    unsigned char digest[16];
    CC_MD5(input.bytes, (CC_LONG)input.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    return  output;
}

+ (NSString*) md5Image:(UIImage*)image
{
    CFDataRef rawData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    NSData* bytes = (__bridge_transfer NSData*)rawData;

    return [self md5Data:bytes];
}

+ (NSData*) convertToJPEG2000:(UIImage*)image withQuality:(CGFloat)quality
{
    NSMutableData* d = [NSMutableData data];
    CGImageDestinationRef destinationRef = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)d, kUTTypeJPEG2000, 1, NULL);
    CGImageDestinationAddImage(destinationRef, image.CGImage, (__bridge CFDictionaryRef)@
    {
        (__bridge NSString*)kCGImageDestinationLossyCompressionQuality: @(quality)
    });

    if (!CGImageDestinationFinalize(destinationRef))
    {
        d = nil;
    }
    CFRelease(destinationRef);

    return d;
}

- (NSString*) documentsDirectory
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* dir = ([paths count] > 0 ? [paths objectAtIndex:0] : nil);

    return [dir stringByAppendingPathComponent:FAColorPICKER_FOLDER_NAME];
}

- (NSString*) sharedDirectory
{
    // if we have specified an app group and are on iOS 8 and have a container directory, return a shared url
    // technically this call could work on iOS 7, but the user defaults initWithSuitName seems to be flaky, so
    // I've blocked this from running on iOS 7 so if your app has other migration code, it will not migrate here
    // until iOS 8 either
    if (FAColorPickerSharedAppGroup.length != 0 && [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f && [NSFileManager instancesRespondToSelector:@selector(containerURLForSecurityApplicationGroupIdentifier:)])
    {
        return [[[[NSFileManager alloc] init] containerURLForSecurityApplicationGroupIdentifier:FAColorPickerSharedAppGroup].path stringByAppendingPathComponent:FAColorPICKER_FOLDER_NAME];
    }
    return nil;
}

- (NSString*) rootDirectory
{
    static NSString* rootDirectory = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        rootDirectory = [self sharedDirectory];
        if (rootDirectory.length == 0)
        {
            rootDirectory = [self documentsDirectory];
        }
        NSFileManager* f = [[NSFileManager alloc] init];
        if (![f fileExistsAtPath:rootDirectory])
        {
            NSError* error;
            [f createDirectoryAtPath:rootDirectory withIntermediateDirectories:YES attributes:nil error:&error];
        }

        NSAssert(rootDirectory.length != 0 && [f fileExistsAtPath:rootDirectory], @"Failed to create root directory");
    });

    return rootDirectory;
}

- (id) init
{
    NSAssert(NO, @"Use sharedInstance");

    return nil;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id) initAsSingleton
{
    if ((self = [super init]) == nil) { return nil; }

    _cache = [[NSCache alloc] init];
    [self migrateAndLoadColors];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDeactivated:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appActivated:) name:UIApplicationDidBecomeActiveNotification object:nil];

    return self;
}

- (void) appDeactivated:(NSNotification*)n
{
    [self saveColorSettings];
}

- (void) appActivated:(NSNotification*)n
{
    [self loadColorSettings];
}

- (void) migrateColorsFromDocumentsDirectoryToSharedFolder
{

#if !TARGET_IS_EXTENSION

    if (FAColorPickerSharedAppGroup.length != 0)
    {
        NSString* sharedDir = [self sharedDirectory];
        NSString* documentsDir = [self documentsDirectory];
        NSFileManager* fileManager = [[NSFileManager alloc] init];

        // if we have both folders possible and the old directory does exist and the shared directory does not yet exist, perform the migration
        if (sharedDir.length != 0 && documentsDir.length != 0 && [fileManager fileExistsAtPath:documentsDir] && ![fileManager fileExistsAtPath:sharedDir])
        {
            // move all files from old documents directory to the new shared directory
            NSError* error = nil;
            [fileManager moveItemAtPath:documentsDir toPath:sharedDir error:&error];
            NSAssert(error == nil, @"Error moving FAColorPicker data from %@ to %@", documentsDir, sharedDir);
        }
    }

#endif

}

- (void) migrateColorsFromNeoColorPicker
{
    NSString* fileName = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"neoFavoriteColors.data"];
    NSFileManager* fileManager = [[NSFileManager alloc] init];
    if ([fileManager isReadableFileAtPath:fileName])
    {
        NSMutableOrderedSet* set = [[NSMutableOrderedSet alloc] initWithOrderedSet:[NSKeyedUnarchiver unarchiveObjectWithFile:fileName]];
        [fileManager removeItemAtPath:fileName error:nil];
        self.disableSave = YES;
        [self loadColorSettings];
        for (UIColor* color in set)
        {
            [self createColorWithColor:color list:FAColorPickerStoreListFavorites moveToFront:NO];
        }
        self.disableSave = NO;
        [self saveColorSettings];
    }
}

- (void) migrateAndLoadColors
{
    [self migrateColorsFromDocumentsDirectoryToSharedFolder];
    [self migrateColorsFromNeoColorPicker];
    [self loadColorSettings];
}

- (NSString*) fullPathForColor:(FAColorPickerColor*)color
{
    return [self fullPathForHash:color.fullImageHash];
}

- (NSString*) fullPathForHash:(NSString*)hash
{
    if (hash.length != 0)
    {
        NSString* path = [[[self rootDirectory] stringByAppendingPathComponent:hash] stringByAppendingString:@"_full.img"];
        return path;
    }
    return nil;
}

- (NSString*) thumbnailPathForHash:(NSString*)hash
{
    if (hash.length != 0)
    {
        NSString* path = [[[self rootDirectory] stringByAppendingPathComponent:hash] stringByAppendingString:@"_thumb.img"];
        return path;
    }
    return nil;
}

- (NSString*) thumbnailPathForColor:(FAColorPickerColor*)color
{
    return [self thumbnailPathForHash:color.fullImageHash];
}

- (void) loadColorSettings
{
    NSString* settingsFilePath = [[self rootDirectory] stringByAppendingPathComponent:FA_COLOR_PICKER_SETTINGS_FILE_NAME];
    NSData* settings = [NSData dataWithContentsOfFile:settingsFilePath];
    _recentColors = [NSMutableArray array];
    _favoriteColors = [NSMutableArray array];

    if (settings.length == 0)
    {
        return;
    }

    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:settings options:0 error:&error];
    if (error != nil)
    {
        NSLog(@"Error reading FAColorPickerStore settings: %@", error);
        return;
    }

    NSArray* recentColors = (NSArray*)json[@"Recent"];

    for (NSDictionary* d in recentColors)
    {
        [(NSMutableArray*)self.recentColors addObject:[[FAColorPickerColor alloc] initWithDictionary:d]];
    }

    NSArray* favoriteColors = (NSArray*)json[@"Favorites"];
    for (NSDictionary* d in favoriteColors)
    {
        [(NSMutableArray*)self.favoriteColors addObject:[[FAColorPickerColor alloc] initWithDictionary:d]];
    }
}

- (void) saveColorSettings
{
    if (self.disableSave)
    {
        return;
    }

    NSMutableDictionary* json = [NSMutableDictionary dictionary];
    NSString* settingsFilePath = [[self rootDirectory] stringByAppendingPathComponent:FA_COLOR_PICKER_SETTINGS_FILE_NAME];

    NSMutableArray* recents = [NSMutableArray array];
    json[@"Recent"] = recents;
    for (FAColorPickerColor* c in self.recentColors)
    {
        [recents addObject:[c dictionary]];
    }

    NSMutableArray* favorites = [NSMutableArray array];
    json[@"Favorites"] = favorites;
    for (FAColorPickerColor* c in self.favoriteColors)
    {
        [favorites addObject:[c dictionary]];
    }

#if DEBUG

    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];

#else

    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];

#endif

    [jsonData writeToFile:settingsFilePath atomically:NO];
}

- (NSInteger) findColor:(FAColorPickerColor*)color inArray:(NSArray*)array alphaMatch:(BOOL*)alphaMatch
{
    NSAssert(alphaMatch != NULL, @"Bool pointer must be allocated");
    *alphaMatch = NO;

    NSInteger lastNonAlphaMatch = NSNotFound;

    for (NSInteger i = 0; i < array.count; i++)
    {
        FAColorPickerColor* c = (FAColorPickerColor*)array[i];
        if ((color.rgbColor != nil && c.rgbColor != nil && color.rgbColor.rgbHex == c.rgbColor.rgbHex) ||
            (color.fullImageHash.length != 0 && c.fullImageHash.length != 0 && [color.fullImageHash isEqualToString:c.fullImageHash]))
        {
            if (c.alpha == color.alpha)
            {
                *alphaMatch = YES;
                return i;
            }
            else if (lastNonAlphaMatch == NSNotFound)
            {
                lastNonAlphaMatch = i;
            }
        }
    }

    return lastNonAlphaMatch;
}

- (FAColorPickerColor*) findAndReplaceColor:(FAColorPickerColor*)color array:(NSMutableArray*)array option:(NSInteger)option
{
    BOOL alphaMatch;
    NSInteger i = [self findColor:color inArray:array alphaMatch:&alphaMatch];
    if (i != NSNotFound)
    {
        FAColorPickerColor* found = (FAColorPickerColor*)array[i];
        [found clearImages];
        [color clearImages];

        // create a copy so that changes to the color do not modify the color already in the list
        FAColorPickerColor* clone = [[FAColorPickerColor alloc] initWithClone:color];

        if (alphaMatch)
        {
            // we matched on alpha, this is an exact match. we will either leave the color where it is or move it to the front
            if (option == FA_COLOR_PICKER_FIND_AND_REPLACE_OPTION_MOVE_TO_FRONT)
            {
                // move color to the front of the array
                [array removeObjectAtIndex:i];
                [array insertObject:clone atIndex:0];
            }
            else if (option == FA_COLOR_PICKER_FIND_AND_REPLACE_OPTION_DELETE)
            {
                [array removeObjectAtIndex:i];
            }
        }
        else
        {
            // we matched, but not on alpha so we have to add a new color either at the front or at the end
            if (option == FA_COLOR_PICKER_FIND_AND_REPLACE_OPTION_MOVE_TO_FRONT)
            {
                [array insertObject:clone atIndex:0];
            }
            else if (option == FA_COLOR_PICKER_FIND_AND_REPLACE_OPTION_KEEP_IN_PLACE)
            {
                [array addObject:clone];
            }
        }

        return color;
    }

    return nil;
}

- (FAColorPickerColor*) findAndReplaceColor:(FAColorPickerColor*)color array:(NSMutableArray*)array moveToFront:(BOOL)moveToFront
{
    // see if this color is in the desired array
    NSInteger option = (moveToFront ? FA_COLOR_PICKER_FIND_AND_REPLACE_OPTION_MOVE_TO_FRONT : FA_COLOR_PICKER_FIND_AND_REPLACE_OPTION_KEEP_IN_PLACE);
    FAColorPickerColor* foundColor = [self findAndReplaceColor:color array:array option:option];

    // if the colors is in the array, we are done
    if (foundColor != nil)
    {
        return foundColor;
    }

    // check other arrays to see if we can re-use the color in the desired list
    for (NSMutableArray* otherArray in @[ self.favoriteColors, self.recentColors ])
    {
        if (otherArray != array)
        {
            // try and re-use color from this array
            foundColor = [self findAndReplaceColor:color array:otherArray option:FA_COLOR_PICKER_FIND_AND_REPLACE_OPTION_GET_ONLY];
            if (foundColor != nil)
            {
                break;
            }
        }
    }

    // if we didn't find the color in any array, assign the passed in color
    if (foundColor == nil)
    {
        foundColor = [[FAColorPickerColor alloc] initWithClone:color];
    }

    // add the color to the requested array
    if (moveToFront)
    {
        [array insertObject:foundColor atIndex:0];
    }
    else
    {
        [array addObject:foundColor];
    }

    return color;
}

- (NSArray*) colorsForList:(FAColorPickerStoreList)list
{
    if (list == FAColorPickerStoreListRecent)
    {
        return self.recentColors;
    }
    else if (list == FAColorPickerStoreListFavorites)
    {
        return self.favoriteColors;
    }
    return nil;
}

- (void) removeFiles:(FAColorPickerColor*)c
{
    if (c.fullImageHash.length != 0)
    {
        NSFileManager* fileManager = [[NSFileManager alloc] init];
        NSString* path = [self thumbnailPathForColor:c];
        [fileManager removeItemAtPath:path error:nil];
        path = [self fullPathForColor:c];
        [fileManager removeItemAtPath:path error:nil];
    }
}

- (FAColorPickerColor*) createColorWithColor:(UIColor*)color list:(FAColorPickerStoreList)list moveToFront:(BOOL)moveToFront
{
    NSAssert(color != nil, @"Color is required");

    // get the first array to check
    NSMutableArray* array = (NSMutableArray*)[self colorsForList:list];
    FAColorPickerColor* FAColor = [[FAColorPickerColor alloc] initWithColor:color];

    // find or create the color
    FAColorPickerColor* existing = [self findAndReplaceColor:FAColor array:array moveToFront:moveToFront];

    while (array.count > FAColorPickerStoreMaxColors)
    {
        FAColorPickerColor* c = (FAColorPickerColor*)[array lastObject];
        [self deleteColor:c fromList:list];
    }

    return existing;
}

- (FAColorPickerColor*) createColorWithImage:(FAColorPickerColor*)color list:(FAColorPickerStoreList)list moveToFront:(BOOL)moveToFront
{
    if (color.image == nil)
    {
        return nil;
    }

    // get the first array to check
    NSMutableArray* array = (NSMutableArray*)[self colorsForList:list];

    // if we don't have a full image yet, make one so we can check if we already exist
    if (color.fullImageHash.length == 0)
    {
        color.fullImageHash = [FAColorPickerStore md5Image:color.image];
        NSString* fullPath = [self fullPathForHash:color.fullImageHash];
        if (![[[NSFileManager alloc] init] fileExistsAtPath:fullPath])
        {
            if (FAColorPickerUsePNG)
            {
                NSData* compressedData = UIImagePNGRepresentation(color.image);
                [compressedData writeToFile:fullPath atomically:NO];
            }
            else
            {
                // since we have lossy compression, we have to re-compute the hash
                NSData* compressedData = [FAColorPickerStore convertToJPEG2000:color.image withQuality:FAColorPickerJPEG2000Quality];
                UIImage* recomputeHashImage = [UIImage imageWithData:compressedData];
                FAColorPickerColor* normalizedColor = [[FAColorPickerColor alloc] initWithImage:recomputeHashImage];
                color.fullImageHash = [FAColorPickerStore md5Image:normalizedColor.image];
                fullPath = [self fullPathForHash:color.fullImageHash];
                if (![[[NSFileManager alloc] init] fileExistsAtPath:fullPath])
                {
                    [compressedData writeToFile:fullPath atomically:NO];
                }
            }

            // generate the thumbnail as well
            NSString* thumbPath = [self thumbnailPathForHash:color.fullImageHash];
            if (![[[NSFileManager alloc] init] fileExistsAtPath:thumbPath])
            {
                NSData* pngData = UIImagePNGRepresentation(color.thumbnailImage);
                [pngData writeToFile:thumbPath atomically:NO];
            }
        }
    }

    color = [self findAndReplaceColor:color array:array moveToFront:moveToFront];
    while (array.count > FAColorPickerStoreMaxColors)
    {
        FAColorPickerColor* c = (FAColorPickerColor*)[array lastObject];
        [self deleteColor:c fromList:list];
    }

    return color;
}

- (void) upsertColor:(FAColorPickerColor*)color list:(FAColorPickerStoreList)list moveToFront:(BOOL)moveToFront
{
    if (color.rgbColor == nil)
    {
        [self createColorWithImage:color list:list moveToFront:YES];
    }
    else
    {
        [self createColorWithColor:color.rgbColor list:list moveToFront:YES];
    }
}

- (void) deleteColor:(FAColorPickerColor*)color fromList:(FAColorPickerStoreList)list
{
    NSArray* array = [self colorsForList:list];
    [self findAndReplaceColor:color array:(NSMutableArray*)array option:FA_COLOR_PICKER_FIND_AND_REPLACE_OPTION_DELETE];

    // if this was an image, we need to check if anyone else is referencing the image - if not we nuke it
    if (color.rgbColor == nil)
    {
        BOOL foundMatchingImage = NO;
        for (FAColorPickerColor* c in [self.favoriteColors arrayByAddingObjectsFromArray:self.recentColors])
        {
            if ([c.fullImageHash isEqualToString:color.fullImageHash])
            {
                foundMatchingImage = YES;
                break;
            }
        }

        if (!foundMatchingImage)
        {
            [self removeFiles:color];
        }
    }
}

- (UIImage*) thumbnailImageForHash:(NSString*)hash
{
    NSString* thumbnailPath = [self thumbnailPathForHash:hash];
    UIImage* fileThumbnail = [UIImage imageWithContentsOfFile:thumbnailPath];

    NSAssert(fileThumbnail != nil, @"Must call createColor first");

    if (fileThumbnail != nil)
    {
        [self.cache setObject:fileThumbnail forKey:hash];
    }

    return fileThumbnail;
}

- (UIImage*) thumbnailImageForColor:(FAColorPickerColor*)color completion:(FAColorPickerStoreThumbnailCompletionBlock)completion
{
    if (color.rgbColor != nil)
    {
        return nil;
    }
    else if (color.thumbnailImage != nil)
    {
        if (completion == nil)
        {
            return color.thumbnailImage;
        }
        completion(color.thumbnailImage);
        return nil;
    }

    NSString* hash = color.fullImageHash;
    UIImage* cachedThumbnail = (UIImage*)[self.cache objectForKey:hash];
    if (cachedThumbnail != nil)
    {
        if (completion == nil)
        {
            return cachedThumbnail;
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^
            {
                completion(cachedThumbnail);
            });
        }
        return nil;
    }

    dispatch_async(dispatch_get_global_queue(0, 0), ^
    {
        UIImage* fileThumbnail = [self thumbnailImageForHash:hash];
        dispatch_async(dispatch_get_main_queue(), ^
        {
            completion(fileThumbnail);
        });
    });

    return nil;
}

// Fadi get image from pod assists
+(UIImage*)imageNamedFromPodResources:(NSString *)name
{
    NSString *bundleName = [[NSBundle bundleForClass:self.class].bundleIdentifier stringByReplacingOccurrencesOfString:@"org.cocoapods." withString:@""] ;
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle bundleForClass:self.class] URLForResource:bundleName withExtension:@"bundle"]];
    return [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
}
@end
