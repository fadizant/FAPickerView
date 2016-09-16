//
//  FAViewController.h
//  FAPickerView
//
//  Created by fadizant on 09/16/2016.
//  Copyright (c) 2016 fadizant. All rights reserved.
//

@import UIKit;
#import "FAPickerView.h"

@interface FAViewController : UIViewController
{
    NSMutableArray <FAPickerItem*> *selectedItems;
    FAPickerItem *selectedItem;
    NSDate *selectedDate;
}

@end
