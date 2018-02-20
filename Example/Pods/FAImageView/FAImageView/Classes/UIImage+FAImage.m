//
//  UIImage+FAImage.m
//  Gloocall
//
//  Created by Fadi on 31/5/16.
//  Copyright © 2016 Apprikot. All rights reserved.
//

#import "UIImage+FAImage.h"

@implementation UIImage (FAImage)

- (UIImage *) imageScaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (UIImage *) imageScaledToWidth: (float) i_width {//method to scale image accordcing to width
    
    float oldWidth = self.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = self.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [self drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *) imageWithImage:(UIImage *)image andLimitSize_MB:(float)size {
    
    float comprisse = 1;
    NSData *imageData = UIImageJPEGRepresentation(image, comprisse);
    while ([imageData length] > (size  * 1024 * 1024)) {
        comprisse -= 0.5;
        imageData = UIImageJPEGRepresentation(image, comprisse);
    }
    
    return [UIImage imageWithData:imageData];
}

- (UIImage *) imageLimitSize_MB:(float)size {
    
    return [self imageWithImage:self andLimitSize_MB:size];
}

- (UIImage *) imageScaledToWidth:(float)i_width andLimitSize_MB:(float)size {
    
    UIImage *image = [self imageScaledToWidth:i_width];
    return [self imageWithImage:image andLimitSize_MB:size];
}

- (UIImage *) imageLimitWidth:(float)i_width andLimitSize_MB:(float)size {
    
    UIImage *image = self.size.width > i_width ? [self imageScaledToWidth:i_width] : self;
    return [self imageWithImage:image andLimitSize_MB:size];
}
@end
