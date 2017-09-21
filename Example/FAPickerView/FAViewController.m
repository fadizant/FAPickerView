//
//  FAViewController.m
//  FAPickerView
//
//  Created by fadizant on 09/16/2016.
//  Copyright (c) 2016 fadizant. All rights reserved.
//

#import "FAViewController.h"

@interface FAViewController ()

@end

@implementation FAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)singleChooseButton:(UIButton *)sender {
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

- (IBAction)multiChooseButton:(UIButton *)sender {
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

- (IBAction)datePickerButton:(UIButton *)sender {
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

- (IBAction)dateArabicFormatButton:(UIButton *)sender {
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

- (IBAction)alert1Button:(UIButton *)sender {
    [FAPickerView setMainColor:[UIColor colorWithRed:0.875 green:0.357 blue:0.357 alpha:1.00]];
    [[FAPickerView picker] showWithHeaderTitle:@"Alert !"
                                       Message:@"One Button ......."
                            confirmButtonTitle:@"Done"
                                WithCompletion:^(FAPickerAlertButton button) {
                                    NSLog(@"Button pressed : %i",(int)button);
                                }];
}

- (IBAction)alert2Button:(UIButton *)sender {
    [FAPickerView setMainColor:[UIColor colorWithRed:1.000 green:0.800 blue:0.000 alpha:1.00]];
    [[FAPickerView picker] showWithHeaderTitle:@"Alert !"
                                       Message:@"Two Button ......."
                            confirmButtonTitle:@"Confirm"
                             cancelButtonTitle:@"Cancel"
                                WithCompletion:^(FAPickerAlertButton button) {
                                    NSLog(@"Button pressed : %i",(int)button);
                                }];
}

- (IBAction)alert3Button:(UIButton *)sender {
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





@end
