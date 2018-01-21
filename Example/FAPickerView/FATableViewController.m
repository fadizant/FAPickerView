//
//  FATableViewController.m
//  FAPickerView_Example
//
//  Created by Fadi Abuzant on 1/21/18.
//  Copyright © 2018 fadizant. All rights reserved.
//

#import "FATableViewController.h"

@interface FATableViewController ()

@end

@implementation FATableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch ((pickerViewTypeEnum)indexPath.row) {
        case pickerViewTypeEnumSingle:
        {
            NSMutableArray <FAPickerItem*> *items = [NSMutableArray new];
            FAPickerItem *item = [FAPickerItem new];
            item.title = @"Title 1";
            item.Id = @"1";
            [items addObject:item];
            item = [FAPickerItem new];
            item.title = @"Title 2";
            item.Id = @"2";
            [items addObject:item];
            item = [FAPickerItem new];
            item.title = @"Title 3";
            item.Id = @"3";
            [items addObject:item];
            item = [FAPickerItem new];
            item.title = @"Title 4";
            item.Id = @"4";
            [items addObject:item];
            
            [FAPickerView setMainColor:[UIColor colorWithRed:0.000 green:0.357 blue:0.675 alpha:1.00]];
            [[FAPickerView picker] showWithItems:items
                                    selectedItem:selectedItem
                                     HeaderTitle:@"Select one item"
                                          filter:NO
                                  WithCompletion:^(FAPickerItem *item) {
                                      NSLog(@"selected item = %@",item.title);
                                      selectedItem = item;
                                  } cancel:^{
                                      NSLog(@"Cancel");
                                  }];
        }
            break;
        case pickerViewTypeEnumMulti:
        {
            NSMutableArray <FAPickerItem*> *items = [NSMutableArray new];
            FAPickerItem *item = [FAPickerItem new];
            item.title = @"Title 1";
            item.Id = @"1";
            [items addObject:item];
            item = [FAPickerItem new];
            item.title = @"Title 2";
            item.Id = @"2";
            [items addObject:item];
            item = [FAPickerItem new];
            item.title = @"Title 3";
            item.Id = @"3";
            [items addObject:item];
            item = [FAPickerItem new];
            item.title = @"Title 4";
            item.Id = @"4";
            [items addObject:item];
            
            [FAPickerView setMainColor:[UIColor colorWithRed:0.675 green:0.000 blue:0.357 alpha:1.00]];
            [[FAPickerView picker] showWithItems:items
                                   selectedItems:selectedItems
                                     HeaderTitle:@"Select multi items"
                               cancelButtonTitle:@"cancle"
                              confirmButtonTitle:@"confirm"
                                          filter:YES
                                  WithCompletion:^(NSMutableArray<FAPickerItem *> *items) {
                                      for (FAPickerItem* item in items) {
                                          NSLog(@"selected item = %@",item.title);
                                      }
                                      selectedItems = items;
                                  } cancel:^{
                                      NSLog(@"Cancel");
                                  }];
        }
            break;
            case pickerViewTypeEnumDatepicker:
        {
            [FAPickerView setMainColor:[UIColor colorWithRed:0.000 green:0.675 blue:0.357 alpha:1.00]];
            [FAPickerView setDateTimeLocalized:@"en_USA"];
            [[FAPickerView picker] showselectedDate:selectedDate
                                        HeaderTitle:@"Select Date"
                                  cancelButtonTitle:@"Cancel"
                                 confirmButtonTitle:@"Confirm"
                                     WithCompletion:^(NSDate *date) {
                                         NSLog(@"selected date = %@",date.description);
                                         selectedDate = date;
                                     } cancel:^{
                                         NSLog(@"Cancel");
                                     }];
        }
            break;
            case pickerViewTypeEnumDateArabic:
        {
            [FAPickerView setMainColor:[UIColor colorWithRed:0.000 green:0.675 blue:0.357 alpha:1.00]];
            [FAPickerView setDateTimeLocalized:@"ar_KSA"];
            [[FAPickerView picker] showselectedDate:selectedDate
                                        HeaderTitle:@"اختر التاريخ"
                                  cancelButtonTitle:@"الغاء"
                                 confirmButtonTitle:@"موافق"
                                     WithCompletion:^(NSDate *date) {
                                         NSLog(@"selected date = %@",date.description);
                                         selectedDate = date;
                                     } cancel:^{
                                         NSLog(@"Cancel");
                                     }];
        }

            break;
            case pickerViewTypeEnumTimepicker:
        {
            [FAPickerView setMainColor:[UIColor colorWithRed:0.520 green:0.375 blue:0.357 alpha:1.00]];
            [FAPickerView setDateTimeLocalized:@"en_USA"];
            [[FAPickerView picker] showselectedDate:selectedDate
                                         DateFormat:UIDatePickerModeTime
                                        HeaderTitle:@"Select Date"
                                  cancelButtonTitle:@"Cancel"
                                 confirmButtonTitle:@"Confirm"
                                     WithCompletion:^(NSDate *date) {
                                         NSLog(@"selected date = %@",date.description);
                                         selectedDate = date;
                                     } cancel:^{
                                         NSLog(@"Cancel");
                                     }];
        }
            break;
            case pickerViewTypeEnumAlertOne:
        {
            [FAPickerView setMainColor:[UIColor colorWithRed:0.875 green:0.357 blue:0.357 alpha:1.00]];
            [[FAPickerView picker] showWithHeaderTitle:@"Alert !"
                                               Message:@"One Button ......."
                                    confirmButtonTitle:@"Done"
                                        WithCompletion:^(FAPickerAlertButton button) {
                                            NSLog(@"Button pressed : %i",(int)button);
                                        }];
        }
            break;
            case pickerViewTypeEnumAlertTwo:
        {
            [FAPickerView setMainColor:[UIColor colorWithRed:1.000 green:0.800 blue:0.000 alpha:1.00]];
            [[FAPickerView picker] showWithHeaderTitle:@"Alert !"
                                               Message:@"Two Button ......."
                                    confirmButtonTitle:@"Confirm"
                                     cancelButtonTitle:@"Cancel"
                                        WithCompletion:^(FAPickerAlertButton button) {
                                            NSLog(@"Button pressed : %i",(int)button);
                                        }];
        }
            break;
            case pickerViewTypeEnumAlertThree:
        {
            [FAPickerView setMainColor:[UIColor colorWithRed:0.353 green:0.941 blue:0.980 alpha:1.00]];
            [[FAPickerView picker] showWithHeaderTitle:@"Alert !"
                                               Message:@"Three Button ......."
                                    confirmButtonTitle:@"Yes"
                                     cancelButtonTitle:@"No"
                                      thirdButtonTitle:@"Cancel"
                                        WithCompletion:^(FAPickerAlertButton button) {
                                            NSLog(@"Button pressed : %i",(int)button);
                                        }];
        }
            break;
        default:
            break;
    }
}
@end
