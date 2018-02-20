//
//  circleUIImageView.h
//  SlideBar
//
//  Created by Fadi on 6/8/15.
//  Copyright (c) 2015 BeeCell. All rights reserved.
//

#import <UIKit/UIKit.h>
//View IBInspectable property in UI
IB_DESIGNABLE

@interface FACircleUIImageView : UIImageView
#pragma mark UI Property
/**
 * Border Color
 */
@property (nonatomic,retain) IBInspectable UIColor *borderColor;
/**
 * Border Width
 */
@property (nonatomic) IBInspectable CGFloat borderWidth;
/**
 * Corner
 */
@property (nonatomic) IBInspectable CGFloat borderCorner;
/**
 * isCorner
 */
@property (nonatomic) IBInspectable BOOL isCircle;
@end
