//
//  FAColorPicker+UIColor.h
//
//  Created by Fadi Abuzant on 3/4/18.
//  Copyright © 2018 fadizant. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIColor (FAColorPicker)

// returns a hex string, i.e. #FFEEDDFF (RGBA)
- (NSString*) hexStringFromColor;

// returns a hex string with the alpha set to one, i.e. AABBCCFF (RGB)
- (NSString*) hexStringFromColorAlphaOne;

// returns a hex string with no alpha, i.e. AABBCC (RGB)
- (NSString*) hexStringFromColorNoAlpha;

// human readable string from color
- (NSString*) stringFromColor;

- (CGFloat) alpha;
- (UInt32) rgbHex;
- (UInt32) rgbaHex;
- (BOOL) red:(CGFloat*)red green:(CGFloat*)green blue:(CGFloat*)blue alpha:(CGFloat*)alpha;
- (CGFloat) red;
- (CGFloat) green;
- (CGFloat) blue;
- (CGFloat) white;
- (BOOL) canProvideRGBComponents;
- (CGColorSpaceModel) colorSpaceModel;

+ (UIColor*) colorWithRGBHex:(UInt32)hex;
+ (UIColor*) colorWithRGBAHex:(UInt32)hex;
+ (UIColor*) colorWithHexString:(NSString*)stringToConvert;
+ (UIColor*) colorWithString:(NSString*)stringToConvert;

@end
