//
//  FAColorPickerColor.m
//
//  Created by Fadi Abuzant on 3/4/18.
//  Copyright © 2018 fadizant. All rights reserved.

#import "FAColorPickerColor.h"
#import "FAColorPicker+UIColor.h"
#import "FAColorPickerStore.h"

@implementation FAColorPickerColor
{
    UIImage* _image;
    UIImage* _thumbnailImage;
}

- (instancetype) initWithColor:(UIColor*)color
{
    if ((self = [super init]) == nil) { return nil; }

    if (!color.canProvideRGBComponents)
    {
        color = [UIColor redColor];
    }

    self.rgbColor = color;
    self.alpha = color.alpha;

    return self;
}

- (instancetype) initWithImage:(UIImage*)image
{
    if ((self = [super init]) == nil) { return nil; }

    NSAssert(image != nil, @"Image must not be nil");

    // on iOS 6, to account for older devices, make the max size smaller
    CGFloat systemVersion = [[UIDevice currentDevice].systemVersion floatValue];
    CGFloat maxSize = MIN((systemVersion >= 7.0f ? 1024.0f : 512.0f), MAX(image.size.width / image.scale, image.size.height / image.scale));

    {
        CGRect rect = [self fitSize:image.size inRect:CGRectMake(0.0f, 0.0f, maxSize, maxSize)];
        _image = [self normalizeImage:image size:rect.size clip:NO];
    }

    {
        CGFloat size = [FAColorPickerStore thumbnailSizePixels];
        _thumbnailImage = [self normalizeImage:_image size:CGSizeMake(size, size) clip:YES];
    }

    self.alpha = 1.0f;

    return self;
}

- (instancetype) initWithDictionary:(NSDictionary*)dictionary
{
    if ((self = [super init]) == nil) { return nil; }

    _alpha = ((NSNumber*)dictionary[@"Alpha"]).floatValue;
    NSString* rgbaHex = (NSString*)dictionary[@"Rgba"];
    if (rgbaHex.length != 0)
    {
        _rgbColor = [UIColor colorWithHexString:rgbaHex];
    }
    _fullImageHash = (NSString*)dictionary[@"FullImageHash"];

    return self;
}

- (instancetype) initWithClone:(FAColorPickerColor*)color
{
    if ((self = [super init]) == nil) { return nil; }

    _alpha = color.alpha;
    _rgbColor = color.rgbColor;
    _image = color.image;
    _thumbnailImage = color.thumbnailImage;
    _fullImageHash = color.fullImageHash;

    return self;
}

- (UIImage*) normalizeImage:(UIImage*)image size:(CGSize)size clip:(BOOL)clip
{
    if (image == nil)
    {
        return nil;
    }

    // we normalize images so that the hashes compute properly - compressed formats are stored in a variety of pixel and alpha formats,
    // and we want everything to be BGRA 32 bits per pixel, 8 bits per component
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(NULL, rect.size.width, rect.size.height, 8, 4 * rect.size.width, colorSpaceRef, (kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little));
    CGColorSpaceRelease(colorSpaceRef);
    CGContextSetInterpolationQuality(ctx, kCGInterpolationHigh);
    CGContextSetBlendMode(ctx, kCGBlendModeCopy);
    CGContextClearRect(ctx, rect);
    if (clip)
    {
        CGContextAddEllipseInRect(ctx, rect);
        CGContextClip(ctx);
    }
    CGContextDrawImage(ctx, rect, image.CGImage);
    CGImageRef imgRef = CGBitmapContextCreateImage(ctx);
    UIImage* normalizedImage = [UIImage imageWithCGImage:imgRef];
    CGImageRelease(imgRef);
    CGContextRelease(ctx);

    return normalizedImage;
}

- (CGRect) fitSize:(CGSize)size inRect:(CGRect)inRect
{
    CGFloat widthScale = (inRect.size.width / size.width);
    CGFloat heightScale = (inRect.size.height / size.height);
    CGFloat ratio = MIN(widthScale, heightScale);
    CGSize newSize = CGSizeMake(size.width * ratio, size.height * ratio);
    CGFloat x = inRect.origin.x + (inRect.size.width - newSize.width) / 2.0f;
    CGFloat y = inRect.origin.y + (inRect.size.height - newSize.height) / 2.0f;
    CGRect newFrame = CGRectMake(x, y, newSize.width, newSize.height);

    return CGRectMake(0.0f, 0.0f, ceilf(newFrame.size.width), ceilf(newFrame.size.height));
}

- (void) setAlpha:(CGFloat)alpha
{
    _alpha = alpha;

    if (self.rgbColor != nil)
    {
        self.rgbColor = [self.rgbColor colorWithAlphaComponent:alpha];
    }
}

- (NSDictionary*) dictionary
{
    NSMutableDictionary* d = [NSMutableDictionary dictionary];

    d[@"Alpha"] = @(self.alpha);
    if (self.rgbColor != nil)
    {
        d[@"Rgba"] = self.rgbColor.hexStringFromColor;
    }
    if (self.fullImageHash.length != 0)
    {
        d[@"FullImageHash"] = self.fullImageHash;
    }

    return d;
}

- (void) clearImages
{
    _image = nil;
    _thumbnailImage = nil;
}

- (UIImage*) image
{
    if (_image == nil && self.fullImageHash.length != 0)
    {
        NSString* path = [[FAColorPickerStore sharedInstance] fullPathForColor:self];
        return [UIImage imageWithContentsOfFile:path];
    }

    return _image;
}

- (UIImage*) thumbnailImage
{
    if (_thumbnailImage == nil && self.fullImageHash.length != 0)
    {
        NSString* path = [[FAColorPickerStore sharedInstance] thumbnailPathForColor:self];
        return [UIImage imageWithContentsOfFile:path];
    }

    return _thumbnailImage;
}

- (NSString*) description
{
    return [NSString stringWithFormat:@"RGB: %@, Alpha: %f, Hash: %@, %@", self.rgbColor.hexStringFromColor, self.alpha, self.fullImageHash, super.description];
}

@end
