//
//  FAColorPickerWheelView.h
//
//  Created by Fadi Abuzant on 3/4/18.
//  Copyright © 2018 fadizant. All rights reserved.

#import <UIKit/UIKit.h>

typedef void (^FAColorPickerWheelViewColorChangedBlock)(UIColor* color);

@interface FAColorPickerWheelView : UIView

@property (nonatomic, copy) FAColorPickerWheelViewColorChangedBlock colorChangedBlock;
@property (nonatomic, strong) UIColor* color;

@property (nonatomic) BOOL hideColorInfo;

@end

