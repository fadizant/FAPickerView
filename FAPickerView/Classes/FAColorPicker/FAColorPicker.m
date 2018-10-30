//
//  FAColorPicker.m
//
//  Created by Fadi Abuzant on 3/4/18.
//  Copyright © 2018 fadizant. All rights reserved.
//

#import "FAColorPicker.h"
#import "FAColorPickerColor.h"

CGFloat FAColorPickerThumbnailSizeInPointsPhone = 42.0f;
CGFloat FAColorPickerThumbnailSizeInPointsPad = 54.0f;
UIFont* FAColorPickerFont;
UIColor* FAColorPickerLabelColor;
UIColor* FAColorPickerBackgroundColor;
UIColor* FAColorPickerBorderColor;
NSInteger FAColorPickerStoreMaxColors = 200;
BOOL FAColorPickerShowSaturationBar = NO;
BOOL FAColorPickerHighlightLastHue = NO;
BOOL FAColorPickerUsePNG = NO;
CGFloat FAColorPickerJPEG2000Quality = 0.9f;
NSString* FAColorPickerSharedAppGroup = nil;

NSBundle* FAColorPickerBundle() {
    NSBundle *bundle = [NSBundle bundleForClass:FAColorPickerColor.class];
    NSString *bundlePath = [bundle pathForResource:@"FAColorPicker" ofType:@"bundle"];
    return [NSBundle bundleWithPath:bundlePath];
}

NSString* DRCPTR(NSString* key, ...)
{
    NSBundle *bundle = FAColorPickerBundle();
    NSString* result = NSLocalizedStringFromTableInBundle(key, @"FAColorPickerLocalizable", bundle, nil);
    va_list ap;
    va_start(ap, key);
    result = [[NSString alloc] initWithFormat:result arguments:ap];
    va_end(ap);
    return result;
}

UIImage* FAColorPickerImage(NSString* subPath)
{
    if (subPath.length == 0)
    {
        return nil;
    }

    static NSCache* imageWithContentsOfFileCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
    ^{
        imageWithContentsOfFileCache = [[NSCache alloc] init];
    });

    NSBundle *bundle = FAColorPickerBundle();
    NSString *path = [bundle.bundlePath stringByAppendingPathComponent:subPath];
    UIImage *img = [UIImage imageNamed:path];
    return img;
}

