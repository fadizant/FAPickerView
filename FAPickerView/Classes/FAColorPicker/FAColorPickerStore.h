//
//  FAColorPickerStore.h
//
//  Created by Fadi Abuzant on 3/4/18.
//  Copyright © 2018 fadizant. All rights reserved.

#import <Foundation/Foundation.h>
#import "FAColorPicker+UIColor.h"
#import "FAColorPickerColor.h"

#define FA_COLOR_PICKER_FULL_SIZE (1024.0f)
#define FA_COLOR_PICKER_SETTINGS_FILE_NAME @"FAColorpicker.settings.json"

typedef void (^FAColorPickerStoreThumbnailCompletionBlock)(UIImage* thumbnailImage);

typedef NS_ENUM(NSInteger, FAColorPickerStoreList)
{
    FAColorPickerStoreListRecent,
    FAColorPickerStoreListFavorites
};

@interface FAColorPickerStore : NSObject

+ (instancetype) sharedInstance;
+ (CGFloat) thumbnailSizePixels;
+ (CGFloat) thumbnailSizePoints;

// get colors for a list
- (NSArray*) colorsForList:(FAColorPickerStoreList)list;

// add or update a color in a list
- (void) upsertColor:(FAColorPickerColor*)color list:(FAColorPickerStoreList)list moveToFront:(BOOL)moveToFront;

// remove an instance of a color, this may cleanup underlying files if no more colors reference this rgb or texture
- (void) deleteColor:(FAColorPickerColor*)color fromList:(FAColorPickerStoreList)list;

// save all changes to file
- (void) saveColorSettings;

// get a thumbnail image for a color - color must be saved first. completion is called back on the main thread. color must have been made from an image, not rgb values.
// if no completion, image is returned
- (UIImage*) thumbnailImageForColor:(FAColorPickerColor*)color completion:(FAColorPickerStoreThumbnailCompletionBlock)completion;

// get full path to the thumbnail image for this color, nil if none
- (NSString*) thumbnailPathForColor:(FAColorPickerColor*)color;

// get full path to the full image for this color, nil if none
- (NSString*) fullPathForColor:(FAColorPickerColor*)color;

// array of FAColorPickerColor
@property (nonatomic, strong, readonly) NSArray* recentColors;

// array of FAColorPickerColor
@property (nonatomic, strong, readonly) NSArray* favoriteColors;

// Fadi get image from pod assists
+(UIImage*)imageNamedFromPodResources:(NSString *)name;
@end
