//
//  DRColorPicker.m
//
//  Created by Fadi Abuzant on 3/4/18.
//  Copyright © 2018 fadizant. All rights reserved.
//

#import "DRColorPicker.h"
#import "DRColorPickerColor.h"

CGFloat DRColorPickerThumbnailSizeInPointsPhone = 42.0f;
CGFloat DRColorPickerThumbnailSizeInPointsPad = 54.0f;
UIFont* DRColorPickerFont;
UIColor* DRColorPickerLabelColor;
UIColor* DRColorPickerBackgroundColor;
UIColor* DRColorPickerBorderColor;
NSInteger DRColorPickerStoreMaxColors = 200;
BOOL DRColorPickerShowSaturationBar = NO;
BOOL DRColorPickerHighlightLastHue = NO;
BOOL DRColorPickerUsePNG = NO;
CGFloat DRColorPickerJPEG2000Quality = 0.9f;
NSString* DRColorPickerSharedAppGroup = nil;

NSBundle* DRColorPickerBundle() {
    NSBundle *bundle = [NSBundle bundleForClass:DRColorPickerColor.class];
    NSString *bundlePath = [bundle pathForResource:@"DRColorPicker" ofType:@"bundle"];
    return [NSBundle bundleWithPath:bundlePath];
}

NSString* DRCPTR(NSString* key, ...)
{
    NSBundle *bundle = DRColorPickerBundle();
    NSString* result = NSLocalizedStringFromTableInBundle(key, @"DRColorPickerLocalizable", bundle, nil);
    va_list ap;
    va_start(ap, key);
    result = [[NSString alloc] initWithFormat:result arguments:ap];
    va_end(ap);
    return result;
}

UIImage* DRColorPickerImage(NSString* subPath)
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

    NSBundle *bundle = DRColorPickerBundle();
    NSString *path = [bundle.bundlePath stringByAppendingPathComponent:subPath];
    UIImage *img = [UIImage imageNamed:path];
    return img;
}

