//
//  circleUIImageView.m
//  SlideBar
//
//  Created by Fadi on 6/8/15.
//  Copyright (c) 2015 BeeCell. All rights reserved.
//

#import "FACircleUIImageView.h"

@implementation FACircleUIImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

}
*/


- (void)layoutSubviews{
    
    [super layoutSubviews];
    [self layoutIfNeeded];
    
    self.layer.borderColor = [_borderColor CGColor];
    self.layer.borderWidth = _borderWidth;
    //circle Image
    [self.layer setCornerRadius:_isCircle ? self.frame.size.height/2 :_borderCorner];
    [self.layer setMasksToBounds:YES];
    
}




@end
