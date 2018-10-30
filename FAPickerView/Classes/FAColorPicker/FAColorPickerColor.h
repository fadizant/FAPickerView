//
//  FAColorPickerColor.h
//
//  Created by Fadi Abuzant on 3/4/18.
//  Copyright © 2018 fadizant. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FAColorPickerColor : NSObject

// init with a rgb color, identifier is created from color rgba
- (instancetype) initWithColor:(UIColor*)color;

// init with an image
- (instancetype) initWithImage:(UIImage*)image;

// init with a dictionary
- (instancetype) initWithDictionary:(NSDictionary*)dictionary;

// init with a color (clone)
- (instancetype) initWithClone:(FAColorPickerColor*)color;

// a dictionary for serialization
- (NSDictionary*) dictionary;

// free up memory from images
- (void) clearImages;

// rgba color
@property (nonatomic, strong) UIColor* rgbColor;

// alpha
@property (nonatomic, assign) CGFloat alpha;

// if rgbColor is nil, this hash represents the MD5 hash of the image bytes
@property (nonatomic, strong) NSString* fullImageHash;

// finally, if this is a new color with an image that needs to be created, populate this property
@property (nonatomic, strong, readonly) UIImage* image;
@property (nonatomic, strong, readonly) UIImage* thumbnailImage;

@end
