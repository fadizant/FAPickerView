//
//  DRColorPickerWheelView.h
//
//  Created by Fadi Abuzant on 3/4/18.
//  Copyright © 2018 fadizant. All rights reserved.

#import <UIKit/UIKit.h>

typedef void (^DRColorPickerWheelViewColorChangedBlock)(UIColor* color);

@interface DRColorPickerWheelView : UIView

@property (nonatomic, copy) DRColorPickerWheelViewColorChangedBlock colorChangedBlock;
@property (nonatomic, strong) UIColor* color;

@property (nonatomic) BOOL hideColorInfo;

@end

