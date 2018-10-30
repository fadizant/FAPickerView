//
//  FAColorPicker.h
//
//  Created by Fadi Abuzant on 3/4/18.
//  Copyright © 2018 fadizant. All rights reserved.
//

#import <Foundation/Foundation.h>

// stands for Digital Ruby Color Picker Translation
NSString* FACPTR(NSString* key, ...);

UIImage* FAColorPickerImage(NSString* subPath);

// size of each individual color in points on iPhone, default is 42
extern CGFloat FAColorPickerThumbnailSizeInPointsPhone;

// size of each individual color in points on iPad, default is 54
extern CGFloat FAColorPickerThumbnailSizeInPointsPad;

// font to use for the color picker
extern UIFont* FAColorPickerFont;

// color of labels text in the color picker views
extern UIColor* FAColorPickerLabelColor;

// background color of the view controllers
extern UIColor* FAColorPickerBackgroundColor;

// border color of the colors - pick something that is different than the background color to help your colors stand out
extern UIColor* FAColorPickerBorderColor;

// maximum colors in the favorites, recent and standard color list - default 200
extern NSInteger FAColorPickerStoreMaxColors;

// should a saturation bar be shown on the color wheel view? Default is NO
extern BOOL FAColorPickerShowSaturationBar;

// highlight the last hue picked in the hue view, default is NO
extern BOOL FAColorPickerHighlightLastHue;

// if you are allowing textures, they default to JPEG2000 to save disk space. This is slower to save and may have a tiny loss of quality,
// so if performance is a concern, set this to YES.
// ***** once you have set this once for your app, do not ever change it as it will invalidate the hashes for all your textures (this would be bad) *****
extern BOOL FAColorPickerUsePNG;

// default is 0.9f, value of 0.0f to 1.0f, 1.0f is lossless but biggest file size and hence more disk space used - ignored if using PNG for texture
// ***** once you have set this once for your app, do not ever change it as it will invalidate the hashes for all your textures (this would be bad) *****
extern CGFloat FAColorPickerJPEG2000Quality;

// new in iOS 8 is the concept of shared folders - if you want the color picker to use a shared folder accessible by apps
// with the same group id, set this to your group id, otherwise leave nil to use the documents folder. Default is nil
extern NSString* FAColorPickerSharedAppGroup;
