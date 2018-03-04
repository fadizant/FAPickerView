//
//  DRColorPickerStore.h
//
//  Created by Fadi Abuzant on 3/4/18.
//  Copyright © 2018 fadizant. All rights reserved.

#import <Foundation/Foundation.h>
#import "DRColorPicker+UIColor.h"
#import "DRColorPickerColor.h"

#define DR_COLOR_PICKER_FULL_SIZE (1024.0f)
#define DR_COLOR_PICKER_SETTINGS_FILE_NAME @"drcolorpicker.settings.json"

typedef void (^DRColorPickerStoreThumbnailCompletionBlock)(UIImage* thumbnailImage);

typedef NS_ENUM(NSInteger, DRColorPickerStoreList)
{
    DRColorPickerStoreListRecent,
    DRColorPickerStoreListFavorites
};

@interface DRColorPickerStore : NSObject

+ (instancetype) sharedInstance;
+ (CGFloat) thumbnailSizePixels;
+ (CGFloat) thumbnailSizePoints;

// get colors for a list
- (NSArray*) colorsForList:(DRColorPickerStoreList)list;

// add or update a color in a list
- (void) upsertColor:(DRColorPickerColor*)color list:(DRColorPickerStoreList)list moveToFront:(BOOL)moveToFront;

// remove an instance of a color, this may cleanup underlying files if no more colors reference this rgb or texture
- (void) deleteColor:(DRColorPickerColor*)color fromList:(DRColorPickerStoreList)list;

// save all changes to file
- (void) saveColorSettings;

// get a thumbnail image for a color - color must be saved first. completion is called back on the main thread. color must have been made from an image, not rgb values.
// if no completion, image is returned
- (UIImage*) thumbnailImageForColor:(DRColorPickerColor*)color completion:(DRColorPickerStoreThumbnailCompletionBlock)completion;

// get full path to the thumbnail image for this color, nil if none
- (NSString*) thumbnailPathForColor:(DRColorPickerColor*)color;

// get full path to the full image for this color, nil if none
- (NSString*) fullPathForColor:(DRColorPickerColor*)color;

// array of DRColorPickerColor
@property (nonatomic, strong, readonly) NSArray* recentColors;

// array of DRColorPickerColor
@property (nonatomic, strong, readonly) NSArray* favoriteColors;

// Fadi get image from pod assists
+(UIImage*)imageNamedFromPodResources:(NSString *)name;
@end
