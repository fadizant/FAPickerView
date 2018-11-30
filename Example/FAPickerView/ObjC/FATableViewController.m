//
//  FATableViewController.m
//  FAPickerView_Example
//
//  Created by Fadi Abuzant on 1/21/18.
//  Copyright © 2018 fadizant. All rights reserved.
//

#import "FATableViewController.h"
#import "FACustomViewController.h"


@interface FATableViewController ()

@end

@implementation FATableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch ((pickerViewTypeEnum)indexPath.row) {
        case pickerViewTypeEnumSingle:
        {
            NSMutableArray <FAPickerItem*> *items = [NSMutableArray new];
            [items addObject:[[FAPickerItem alloc]initWithID:@"1" Title:@"Title 1"]];
            [items addObject:[[FAPickerItem alloc]initWithID:@"2" Title:@"Title 2"]];
            [items addObject:[[FAPickerItem alloc]initWithID:@"3" Title:@"Title 3"]];
            
            [FAPickerView setMainColor:[UIColor colorWithRed:0.000 green:0.357 blue:0.675 alpha:1.00]];
            [FAPickerView showWithItems:items
                           selectedItem:selectedItem
                                 filter:NO
                            HeaderTitle:@"Select one item"
                         WithCompletion:^(FAPickerItem*item) {
                             NSLog(@"selected item = %@",item.title);
                             self->selectedItem = item;
                         } cancel:^{
                             NSLog(@"Cancel");
                         }];
        }
            break;
        case pickerViewTypeEnumMulti:
        {
            NSMutableArray <FAPickerItem*> *items = [NSMutableArray new];
            [items addObject:[[FAPickerItem alloc]initWithID:@"1" Title:@"Title 1"]];
            [items addObject:[[FAPickerItem alloc]initWithID:@"2" Title:@"Title 2"]];
            [items addObject:[[FAPickerItem alloc]initWithID:@"3" Title:@"Title 3"]];
            [items addObject:[[FAPickerItem alloc]initWithID:@"4" Title:@"Title 4"]];
            [items addObject:[[FAPickerItem alloc]initWithID:@"5" Title:@"Title 5"]];
            [items addObject:[[FAPickerItem alloc]initWithID:@"6" Title:@"Title 6"]];
            [items addObject:[[FAPickerItem alloc]initWithID:@"7" Title:@"Title 7"]];
            [items addObject:[[FAPickerItem alloc]initWithID:@"8" Title:@"Title 8"]];
            [items addObject:[[FAPickerItem alloc]initWithID:@"9" Title:@"Title 9"]];
            [items addObject:[[FAPickerItem alloc]initWithID:@"10" Title:@"Title 10"]];
            
            [FAPickerView setMainColor:[UIColor colorWithRed:0.000 green:0.357 blue:0.675 alpha:1.00]];
            [FAPickerView showWithItems:items
                          selectedItems:selectedItems
                                 filter:NO
                            HeaderTitle:@"Select multi items"
                      cancelButtonTitle:@"cancle"
                     confirmButtonTitle:@"confirm"
                         WithCompletion:^(NSMutableArray<FAPickerItem*> *items) {
                             for (FAPickerItem* item in items) {
                                 NSLog(@"selected item = %@",item.title);
                             }
                             self->selectedItems = items;
                         } cancel:^{
                             NSLog(@"Cancel");
                         }];
            
        }
            break;
        case pickerViewTypeEnumSectionSingle: {
            NSMutableArray <FAPickerSection*> *sections = [NSMutableArray new];
            
            NSMutableArray <FAPickerItem*> *items1 = [NSMutableArray new];
            [items1 addObject:[[FAPickerItem alloc]initWithID:@"1" Title:@"Title 1"]];
            [items1 addObject:[[FAPickerItem alloc]initWithID:@"2" Title:@"Title 2"]];
            [items1 addObject:[[FAPickerItem alloc]initWithID:@"3" Title:@"Title 3"]];
            [sections addObject:[[FAPickerSection alloc]initWithTitle:@"Section 1" Items:items1]];
            
            NSMutableArray <FAPickerItem*> *items2 = [NSMutableArray new];
            [items2 addObject:[[FAPickerItem alloc]initWithID:@"4" Title:@"Title 1"]];
            [items2 addObject:[[FAPickerItem alloc]initWithID:@"5" Title:@"Title 2"]];
            [items2 addObject:[[FAPickerItem alloc]initWithID:@"6" Title:@"Title 3"]];
            [sections addObject:[[FAPickerSection alloc]initWithTitle:@"Section 2" Items:items2]];
            
            [FAPickerView setMainColor:[UIColor colorWithRed:0.000 green:0.357 blue:0.675 alpha:1.00]];
            [FAPickerView showWithSections:sections
                              selectedItem:sectionSelectedItem
                               HeaderTitle:@"Select one item"
                            WithCompletion:^(FAPickerItem*item) {
                                NSLog(@"selected item = %@",item.title);
                                self->sectionSelectedItem = item;
                            } cancel:^{
                                NSLog(@"Cancel");
                            }];
            break;
        }
        case pickerViewTypeEnumSectionMulti: {
            NSMutableArray <FAPickerSection*> *sections = [NSMutableArray new];
            
            NSMutableArray <FAPickerItem*> *items1 = [NSMutableArray new];
            [items1 addObject:[[FAPickerItem alloc]initWithID:@"1" Title:@"Title 1"]];
            [items1 addObject:[[FAPickerItem alloc]initWithID:@"2" Title:@"Title 2"]];
            [items1 addObject:[[FAPickerItem alloc]initWithID:@"3" Title:@"Title 3"]];
            [sections addObject:[[FAPickerSection alloc]initWithTitle:@"Section 1" Items:items1]];
            
            NSMutableArray <FAPickerItem*> *items2 = [NSMutableArray new];
            [items2 addObject:[[FAPickerItem alloc]initWithID:@"4" Title:@"Title 1"]];
            [items2 addObject:[[FAPickerItem alloc]initWithID:@"5" Title:@"Title 2"]];
            [items2 addObject:[[FAPickerItem alloc]initWithID:@"6" Title:@"Title 3"]];
            [sections addObject:[[FAPickerSection alloc]initWithTitle:@"Section 2" Items:items2]];
            
            NSMutableArray <FAPickerItem*> *items3 = [NSMutableArray new];
            [items3 addObject:[[FAPickerItem alloc]initWithID:@"7" Title:@"Title 1"]];
            [items3 addObject:[[FAPickerItem alloc]initWithID:@"8" Title:@"Title 2"]];
            [items3 addObject:[[FAPickerItem alloc]initWithID:@"9" Title:@"Title 3"]];
            [sections addObject:[[FAPickerSection alloc]initWithTitle:@"Section 3" Items:items3]];
            
            [FAPickerView setMainColor:[UIColor colorWithRed:0.000 green:0.357 blue:0.675 alpha:1.00]];
            [FAPickerView showWithSections:sections
                             selectedItems:sectionSelectedItems
                               HeaderTitle:@"Select multi items"
                         cancelButtonTitle:@"cancel"
                        confirmButtonTitle:@"confirm"
                            WithCompletion:^(NSMutableArray<FAPickerItem*> *items) {
                                for (FAPickerItem* item in items) {
                                    NSLog(@"selected item = %@",item.title);
                                }
                                self->sectionSelectedItems = items;
                            } cancel:^{
                                NSLog(@"Cancel");
                            }];
            break;
        }
        case pickerViewTypeEnumItemsWithURLImags:
        {
            NSMutableArray <FAPickerItem*> *items = [NSMutableArray new];
            [items addObject:[[FAPickerItem alloc] initWithID:@"1"
                                                        Title:@"Facebook"
                                                     ImageURL:@"https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/facebook-icon_128x128.png"
                                                        Thumb:[UIImage imageNamed:@"Thumb"]
                                                       Circle:YES]];
            [items addObject:[[FAPickerItem alloc] initWithID:@"2"
                                                        Title:@"Google"
                                                     ImageURL:@"https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/googleplus-icon_128x128.png"
                                                        Thumb:[UIImage imageNamed:@"Thumb"]
                                                       Circle:YES]];
            [items addObject:[[FAPickerItem alloc] initWithID:@"3"
                                                        Title:@"LinkedIn"
                                                     ImageURL:@"https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/linkedin-icon_128x128.png"
                                                        Thumb:[UIImage imageNamed:@"Thumb"]
                                                       Circle:YES]];
            [items addObject:[[FAPickerItem alloc] initWithID:@"4"
                                                        Title:@"Twitter"
                                                     ImageURL:@"https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/twitter-icon_128x128.png"
                                                        Thumb:[UIImage imageNamed:@"Thumb"]
                                                       Circle:YES]];
            [items addObject:[[FAPickerItem alloc] initWithID:@"5"
                                                        Title:@"Youtube"
                                                     ImageURL:@"https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/youtube-icon_128x128.png"
                                                        Thumb:[UIImage imageNamed:@"Thumb"]
                                                       Circle:YES]];
            [items addObject:[[FAPickerItem alloc] initWithID:@"6"
                                                        Title:@"Skype"
                                                     ImageURL:@"https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/skype-icon_128x128.png"
                                                        Thumb:[UIImage imageNamed:@"Thumb"]
                                                       Circle:YES]];
            [items addObject:[[FAPickerItem alloc] initWithID:@"7"
                                                        Title:@"Pinterest"
                                                     ImageURL:@"https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/pinterest-icon_128x128.png"
                                                        Thumb:[UIImage imageNamed:@"Thumb"]
                                                       Circle:YES]];
            [items addObject:[[FAPickerItem alloc] initWithID:@"8"
                                                        Title:@"Instagram"
                                                     ImageURL:@"https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/instagram-icon_128x128.png"
                                                        Thumb:[UIImage imageNamed:@"Thumb"]
                                                       Circle:YES]];
            [items addObject:[[FAPickerItem alloc] initWithID:@"9"
                                                        Title:@"Vimeo"
                                                     ImageURL:@"https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/vimeo-icon_128x128.png"
                                                        Thumb:[UIImage imageNamed:@"Thumb"]
                                                       Circle:YES]];
            [items addObject:[[FAPickerItem alloc] initWithID:@"10"
                                                        Title:@"Flickr"
                                                     ImageURL:@"https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/flickr-icon_128x128.png"
                                                        Thumb:[UIImage imageNamed:@"Thumb"]
                                                       Circle:YES]];
            
            
            [FAPickerView setMainColor:[UIColor colorWithRed:0.000 green:0.357 blue:0.675 alpha:1.00]];
            [FAPickerView showWithItems:items
                           selectedItem:nil
                                 filter:YES
                            HeaderTitle:@"Select multi items"
                      cancelButtonTitle:@"cancel"
                     confirmButtonTitle:@"confirm"
                         WithCompletion:^(FAPickerItem*item) {
                             for (FAPickerItem* item in items) {
                                 NSLog(@"selected item = %@",item.title);
                             }
                             self->selectedItems = items;
                         } cancel:^{
                             NSLog(@"Cancel");
                         }];
        }
            break;
        case pickerViewTypeEnumItemsWithColors:
        {
            NSMutableArray <FAPickerItem*> *items = [NSMutableArray new];
            FAPickerItem*item = [FAPickerItem new];
            [items addObject:[[FAPickerItem alloc]initWithID:@"1" Title:@"Red" TitleColor:[UIColor redColor] ImageColor:[UIColor redColor] Circle:YES]];
            [items addObject:[[FAPickerItem alloc]initWithID:@"2" Title:@"Blue" TitleColor:[UIColor blueColor] ImageColor:[UIColor blueColor] Circle:YES]];
            [items addObject:[[FAPickerItem alloc]initWithID:@"3" Title:@"Green" TitleColor:[UIColor greenColor] ImageColor:[UIColor greenColor] Circle:NO]];
            [items addObject:[[FAPickerItem alloc]initWithID:@"4" Title:@"Orange" TitleColor:[UIColor orangeColor] ImageColor:[UIColor orangeColor] Circle:YES]];
            [items addObject:[[FAPickerItem alloc]initWithID:@"5" Title:@"Purple" TitleColor:[UIColor purpleColor] ImageColor:[UIColor purpleColor] Circle:YES]];
            [items addObject:[[FAPickerItem alloc]initWithID:@"6" Title:@"Magenta" TitleColor:[UIColor magentaColor] ImageColor:[UIColor magentaColor] Circle:NO]];
            [items addObject:[[FAPickerItem alloc]initWithID:@"7" Title:@"Brown" TitleColor:[UIColor brownColor] ImageColor:[UIColor brownColor] Circle:YES]];
            
            [FAPickerView setMainColor:[UIColor colorWithRed:0.000 green:0.357 blue:0.675 alpha:1.00]];
            [FAPickerView showWithItems:items
                  selectedItemWithTitle:@""
                                 filter:NO
                            HeaderTitle:@"Select item with color"
                         WithCompletion:^(FAPickerItem*items) {
                             NSLog(@"selected item = %@",item.title);
                         } cancel:^{
                             NSLog(@"Cancel");
                         }];
        }
            break;
        case pickerViewTypeEnumDatepicker:
        {
            [FAPickerView setMainColor:[UIColor colorWithRed:0.000 green:0.675 blue:0.357 alpha:1.00]];
            [FAPickerView setDateTimeLocalized:@"en_USA"];
            [FAPickerView showWithSelectedDate:selectedDate
                                   HeaderTitle:@"Select Date"
                             cancelButtonTitle:@"Cancel"
                            confirmButtonTitle:@"Confirm"
                                WithCompletion:^(NSDate *date) {
                                    NSLog(@"selected date = %@",date.description);
                                    self->selectedDate = date;
                                } cancel:^{
                                    NSLog(@"Cancel");
                                }];
        }
            break;
        case pickerViewTypeEnumDateArabic:
        {
            [FAPickerView setMainColor:[UIColor colorWithRed:0.000 green:0.675 blue:0.357 alpha:1.00]];
            [FAPickerView setDateTimeLocalized:@"ar_KSA"];
            [FAPickerView showWithSelectedDate:selectedDate
                                   HeaderTitle:@"اختر التاريخ"
                             cancelButtonTitle:@"الغاء"
                            confirmButtonTitle:@"موافق"
                                WithCompletion:^(NSDate *date) {
                                    NSLog(@"selected date = %@",date.description);
                                    self->selectedDate = date;
                                } cancel:^{
                                    NSLog(@"Cancel");
                                }];
        }
            
            break;
        case pickerViewTypeEnumTimepicker:
        {
            [FAPickerView setMainColor:[UIColor colorWithRed:0.000 green:0.675 blue:0.357 alpha:1.00]];
            [FAPickerView setDateTimeLocalized:@"en_USA"];
            [FAPickerView showWithSelectedDate:selectedDate
                                    DateFormat:UIDatePickerModeTime
                                   HeaderTitle:@"Select Time"
                             cancelButtonTitle:@"Cancel"
                            confirmButtonTitle:@"Confirm"
                                WithCompletion:^(NSDate *date) {
                                    NSLog(@"selected date = %@",date.description);
                                    self->selectedDate = date;
                                } cancel:^{
                                    NSLog(@"Cancel");
                                }];
        }
            break;
        case pickerViewTypeEnumDatepickerRange:
        {
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDate *currentDate = [NSDate date];
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            [comps setDay:5];
            NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
            [comps setDay:-5];
            NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
            
            [FAPickerView setMainColor:[UIColor colorWithRed:0.000 green:0.675 blue:0.357 alpha:1.00]];
            [FAPickerView setDateTimeLocalized:@"en_USA"];
            [FAPickerView showWithSelectedDate:[NSDate date]
                                   MaximumDate:maxDate
                                   MinimumDate:minDate
                                   HeaderTitle:@"Select Date with range"
                             cancelButtonTitle:@"Cancel"
                            confirmButtonTitle:@"Confirm"
                                WithCompletion:^(NSDate *date) {
                                    NSLog(@"selected date = %@",date.description);
                                    self->selectedDate = date;
                                } cancel:^{
                                    NSLog(@"Cancel");
                                }];
        }
            break;
        case pickerViewTypeEnumTimepickerRange:
        {
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDate *currentDate = [NSDate date];
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            [comps setHour:5];
            NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
            [comps setHour:-5];
            NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
            
            [FAPickerView setMainColor:[UIColor colorWithRed:0.000 green:0.675 blue:0.357 alpha:1.00]];
            [FAPickerView setDateTimeLocalized:@"en_USA"];
            [FAPickerView showWithSelectedDate:[NSDate date]
                                    DateFormat:UIDatePickerModeDateAndTime
                                   MaximumDate:maxDate
                                   MinimumDate:minDate
                                   HeaderTitle:@"Select Time with range"
                             cancelButtonTitle:@"Cancel"
                            confirmButtonTitle:@"Confirm"
                                WithCompletion:^(NSDate *date) {
                                    NSLog(@"selected date = %@",date.description);
                                    self->selectedDate = date;
                                } cancel:^{
                                    NSLog(@"Cancel");
                                }];
        }
            break;
        case pickerViewTypeEnumColorPicker:
        {
            [FAPickerView showWithSelectedColor:[tableView cellForRowAtIndexPath:indexPath].textLabel.textColor
                                    HeaderTitle:@"Select color"
                              cancelButtonTitle:@"Cancel"
                             confirmButtonTitle:@"Confirm"
                                 WithCompletion:^(UIColor *color) {
                                     [tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = color;
                                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = color.hexStringFromColorNoAlpha;
                                 } cancel:^{
                                     
                                 }];
        }
            break;
        case pickerViewTypeEnumCustomView:
        {
            [FAPickerView setMainColor:[UIColor colorWithRed:0.99 green:0.49 blue:0.32 alpha:1.0]];
            [FAPickerView showWithCustomView:[self.storyboard instantiateViewControllerWithIdentifier:@"FACustomViewController"]
                               BottomPadding:15
                                 headerTitle:@"Custom View"
                          confirmButtonTitle:@"Done"
                           cancelButtonTitle:@"Cancel"
                              WithCompletion:^(FAPickerCustomViewButton button) {
                                  
                              }];
        }
            break;
        case pickerViewTypeEnumCustomPicker:
        {
            [FAPickerView setMainColor:[UIColor colorWithRed:0.99 green:0.49 blue:0.32 alpha:1.0]];
            FACustomViewController * view = [self.storyboard instantiateViewControllerWithIdentifier:@"FACustomViewController"];
            view.isCustomPicker = YES;
            [FAPickerView showWithCustomPickerView:view CancelGesture:NO];
        }
            break;
        case pickerViewTypeEnumAlertOne:
        {
            [FAPickerView setMainColor:[UIColor colorWithRed:0.675 green:0.000 blue:0.357 alpha:1.00]];
            [FAPickerView showWithMessage:@"One Button ......."
                              headerTitle:@"Alert !"
                       confirmButtonTitle:@"Done"
                           WithCompletion:^(FAPickerAlertButton button) {
                               NSLog(@"Button pressed : %i",(int)button);
                           }];
        }
            break;
        case pickerViewTypeEnumAlertTwo:
        {
            [FAPickerView setMainColor:[UIColor colorWithRed:0.675 green:0.000 blue:0.357 alpha:1.00]];
            [FAPickerView showWithMessage:@"Two Button ......."
                              headerTitle:@"Alert !"
                       confirmButtonTitle:@"Confirm"
                        cancelButtonTitle:@"Cancel"
                           WithCompletion:^(FAPickerAlertButton button) {
                               NSLog(@"Button pressed : %i",(int)button);
                           }];
        }
            break;
        case pickerViewTypeEnumAlertThree:
        {
            [FAPickerView setMainColor:[UIColor colorWithRed:0.675 green:0.000 blue:0.357 alpha:1.00]];
            [FAPickerView showWithMessage:@"Three Buttons ......."
                              headerTitle:@"Alert !"
                       confirmButtonTitle:@"Yes"
                        cancelButtonTitle:@"No"
                         thirdButtonTitle:@"Cancel"
                           WithCompletion:^(FAPickerAlertButton button) {
                               NSLog(@"Button pressed : %i",(int)button);
                           }];
        }
            break;
    }
}
@end
