//
//  FATableViewController.h
//  FAPickerView_Example
//
//  Created by Fadi Abuzant on 1/21/18.
//  Copyright © 2018 fadizant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAPickerView.h"

@interface FATableViewController : UITableViewController
{
    NSMutableArray <FAPickerItem*> *selectedItems;
    FAPickerItem *selectedItem;
    NSDate *selectedDate;
    NSArray *items;
}

typedef NS_ENUM(NSInteger, pickerViewTypeEnum) {
    pickerViewTypeEnumSingle,
    pickerViewTypeEnumMulti,
    pickerViewTypeEnumItemsWithURLImags,
    pickerViewTypeEnumItemsWithColors,
    pickerViewTypeEnumDatepicker,
    pickerViewTypeEnumDateArabic,
    pickerViewTypeEnumTimepicker,
    pickerViewTypeEnumDatepickerRange,
    pickerViewTypeEnumTimepickerRange,
    pickerViewTypeEnumAlertOne,
    pickerViewTypeEnumAlertTwo,
    pickerViewTypeEnumAlertThree
};

@end
