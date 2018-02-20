//
//  UIImage+FAImage.h
//  Gloocall
//
//  Created by Fadi on 31/5/16.
//  Copyright © 2016 Apprikot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FAImage)

- (UIImage *) imageScaledToSize:(CGSize)newSize ;
- (UIImage *) imageScaledToWidth: (float) i_width ;
- (UIImage *) imageWithImage:(UIImage *)image andLimitSize_MB:(float)size ;
- (UIImage *) imageLimitSize_MB:(float)size;
- (UIImage *) imageScaledToWidth:(float)i_width andLimitSize_MB:(float)size ;
- (UIImage *) imageLimitWidth:(float)i_width andLimitSize_MB:(float)size;
@end
