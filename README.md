# FAPickerView

[![Version](https://img.shields.io/cocoapods/v/FAPickerView.svg?style=flat)](http://cocoapods.org/pods/FAPickerView)
[![License](https://img.shields.io/cocoapods/l/FAPickerView.svg?style=flat)](http://cocoapods.org/pods/FAPickerView)
[![Platform](https://img.shields.io/cocoapods/p/FAPickerView.svg?style=flat)](http://cocoapods.org/pods/FAPickerView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.



## How to use

### Items

<img src="http://www.m5zn.com/newuploads/2018/03/04/gif//9a5aecbb16247e0.gif" height="400"/>

##### ObjC

```ruby
// Single item select
NSMutableArray <FAPickerItem*> *items = [NSMutableArray new];
[items addObject:[[FAPickerItem alloc]initWithID:@"1" Title:@"Title 1"]];
[items addObject:[[FAPickerItem alloc]initWithID:@"2" Title:@"Title 2"]];
[items addObject:[[FAPickerItem alloc]initWithID:@"3" Title:@"Title 3"]];

[FAPickerView setMainColor:[UIColor colorWithRed:0.000 green:0.357 blue:0.675 alpha:1.00]];
[FAPickerView showWithItems:items
                        selectedItem:selectedItem
                              filter:NO
                         HeaderTitle:@"Select one item"
                      WithCompletion:^(FAPickerItem *item) {
                          NSLog(@"selected item = %@",item.title);
                          self->selectedItem = item;
                      } cancel:^{
                          NSLog(@"Cancel");
                      }];
```
```ruby
// Multi item select
NSMutableArray <FAPickerItem*> *items = [NSMutableArray new];
[items addObject:[[FAPickerItem alloc]initWithID:@"1" Title:@"Title 1"]];
[items addObject:[[FAPickerItem alloc]initWithID:@"2" Title:@"Title 2"]];
[items addObject:[[FAPickerItem alloc]initWithID:@"3" Title:@"Title 3"]];
[items addObject:[[FAPickerItem alloc]initWithID:@"4" Title:@"Title 4"]];
[items addObject:[[FAPickerItem alloc]initWithID:@"5" Title:@"Title 5"]];
[items addObject:[[FAPickerItem alloc]initWithID:@"6" Title:@"Title 6"]];

[FAPickerView setMainColor:[UIColor colorWithRed:0.000 green:0.357 blue:0.675 alpha:1.00]];
[FAPickerView showWithItems:items
                       selectedItems:selectedItems
                              filter:NO
                         HeaderTitle:@"Select multi items"
                   cancelButtonTitle:@"cancle"
                  confirmButtonTitle:@"confirm"
                      WithCompletion:^(NSMutableArray<FAPickerItem *> *items) {
                          for (FAPickerItem* item in items) {
                              NSLog(@"selected item = %@",item.title);
                          }
                          self->selectedItems = items;
                      } cancel:^{
                          NSLog(@"Cancel");
                      }];
```
```ruby
// Single item select with sections
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
                         WithCompletion:^(FAPickerItem *item) {
                             NSLog(@"selected item = %@",item.title);
                             self->sectionSelectedItem = item;
                         } cancel:^{
                             NSLog(@"Cancel");
                         }];

```
```ruby
// Multi item select with sections
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
                          selectedItems:sectionSelectedItems
                            HeaderTitle:@"Select multi items"
                      cancelButtonTitle:@"cancel"
                     confirmButtonTitle:@"confirm"
                         WithCompletion:^(NSMutableArray<FAPickerItem *> *items) {
                             for (FAPickerItem* item in items) {
                                 NSLog(@"selected item = %@",item.title);
                             }
                             self->sectionSelectedItems = items;
                         } cancel:^{
                             NSLog(@"Cancel");
                         }];

```
```ruby
// With URL images

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


[FAPickerView setMainColor:[UIColor colorWithRed:0.000 green:0.357 blue:0.675 alpha:1.00]];
[FAPickerView showWithItems:items
               selectedItem:nil
                     filter:YES
                HeaderTitle:@"Select multi items"
          cancelButtonTitle:@"cancel"
         confirmButtonTitle:@"confirm"
             WithCompletion:^(FAPickerItem *item) {
                 for (FAPickerItem* item in items) {
                     NSLog(@"selected item = %@",item.title);
                 }
                 self->selectedItems = items;
             } cancel:^{
                 NSLog(@"Cancel");
             }];
```
```ruby
// Colored items

NSMutableArray <FAPickerItem*> *items = [NSMutableArray new];
FAPickerItem *item = [FAPickerItem new];
[items addObject:[[FAPickerItem alloc]initWithID:@"1" Title:@"Red" TitleColor:[UIColor redColor] ImageColor:[UIColor redColor] Circle:YES]];
[items addObject:[[FAPickerItem alloc]initWithID:@"2" Title:@"Blue" TitleColor:[UIColor blueColor] ImageColor:[UIColor blueColor] Circle:YES]];
[items addObject:[[FAPickerItem alloc]initWithID:@"3" Title:@"Green" TitleColor:[UIColor greenColor] ImageColor:[UIColor greenColor] Circle:NO]];
[items addObject:[[FAPickerItem alloc]initWithID:@"4" Title:@"Magenta" TitleColor:[UIColor magentaColor] ImageColor:[UIColor magentaColor] Circle:NO]];

[FAPickerView setMainColor:[UIColor colorWithRed:0.000 green:0.357 blue:0.675 alpha:1.00]];
[FAPickerView showWithItems:items
      selectedItemWithTitle:@""
                     filter:NO
                HeaderTitle:@"Select item with color"
             WithCompletion:^(FAPickerItem *items) {
                 NSLog(@"selected item = %@",item.title);
             } cancel:^{
                 NSLog(@"Cancel");
             }];
```

##### Swift 4+

```ruby
// Single item select
var items = Array<FAPickerItem>()
items.append(FAPickerItem.init(id: "1", title: "Title 1"))
items.append(FAPickerItem.init(id: "2", title: "Title 2"))
items.append(FAPickerItem.init(id: "3", title: "Title 3"))

FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.357, blue: 0.675, alpha: 1.00))
FAPickerView.showSingleSelectItem(items: NSMutableArray(array: items),
                                  selectedItem: selectedItem,
                                  filter: false,
                                  headerTitle: "Select one item",
                                  complete: { (item:FAPickerItem?) in
                                    self.selectedItem = item ?? FAPickerItem()
}, cancel: {
    
})
```
```ruby
// Multi items select
items.append(FAPickerItem.init(id: "1", title: "Title 1"))
items.append(FAPickerItem.init(id: "2", title: "Title 2"))
items.append(FAPickerItem.init(id: "3", title: "Title 3"))
items.append(FAPickerItem.init(id: "4", title: "Title 4"))
items.append(FAPickerItem.init(id: "5", title: "Title 5"))
items.append(FAPickerItem.init(id: "6", title: "Title 6"))

FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.357, blue: 0.675, alpha: 1.00))
FAPickerView.showMultiSelectItems(items: NSMutableArray(array: items),
                                  selectedItems: NSMutableArray(array: selectedItems),
                                  filter: false,
                                  headerTitle: "Select multi items",
                                  cancelTitle: "cancel",
                                  confirmTitle: "confirm",
                                  complete: { (items:NSMutableArray?) in
                                    if let array = items as? [FAPickerItem] {
                                        self.selectedItems = array
                                    }
}, cancel: {
    
})
```
```ruby
// Single item select with sections
var sections = Array<FAPickerSection>()
var items1 = Array<FAPickerItem>()
items1.append(FAPickerItem.init(id: "1", title: "Title 1"))
items1.append(FAPickerItem.init(id: "2", title: "Title 2"))
items1.append(FAPickerItem.init(id: "3", title: "Title 3"))
sections.append(FAPickerSection.init(title: "Section 1", items: NSMutableArray(array: items1)))

var items2 = Array<FAPickerItem>()
items2.append(FAPickerItem.init(id: "4", title: "Title 1"))
items2.append(FAPickerItem.init(id: "5", title: "Title 2"))
items2.append(FAPickerItem.init(id: "6", title: "Title 3"))
sections.append(FAPickerSection.init(title: "Section 2", items: NSMutableArray(array: items2)))

FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.357, blue: 0.675, alpha: 1.00))
FAPickerView.showSectionsWithSingleSelectItem(sections: NSMutableArray(array: sections),
                                              selectedItem: selectedItem,
                                              headerTitle: "Select one item",
                                              complete: { (item:FAPickerItem?) in
                                    self.selectedItem = item ?? FAPickerItem()
}, cancel: {
    
})
```
```ruby
// Multi items select with sections
var sections = Array<FAPickerSection>()
var items1 = Array<FAPickerItem>()
items1.append(FAPickerItem.init(id: "1", title: "Title 1"))
items1.append(FAPickerItem.init(id: "2", title: "Title 2"))
items1.append(FAPickerItem.init(id: "3", title: "Title 3"))
sections.append(FAPickerSection.init(title: "Section 1", items: NSMutableArray(array: items1)))

var items2 = Array<FAPickerItem>()
items2.append(FAPickerItem.init(id: "4", title: "Title 1"))
items2.append(FAPickerItem.init(id: "5", title: "Title 2"))
items2.append(FAPickerItem.init(id: "6", title: "Title 3"))
sections.append(FAPickerSection.init(title: "Section 2", items: NSMutableArray(array: items2)))

var items3 = Array<FAPickerItem>()
items3.append(FAPickerItem.init(id: "7", title: "Title 1"))
items3.append(FAPickerItem.init(id: "8", title: "Title 2"))
items3.append(FAPickerItem.init(id: "9", title: "Title 3"))
sections.append(FAPickerSection.init(title: "Section 3", items: NSMutableArray(array: items3)))

FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.357, blue: 0.675, alpha: 1.00))
FAPickerView.showSectionsWithMultiSelectItem(sections: NSMutableArray(array: sections),
                                             selectedItems: NSMutableArray(array: selectedItems),
                                             headerTitle: "Select multi items",
                                             cancelTitle: "cancel",
                                             confirmTitle: "confirm",
                                             complete: { (items:NSMutableArray?) in
                                                if let array = items as? [FAPickerItem] {
                                                    self.selectedItems = array
                                                }
}, cancel: {
    
})
```
```ruby
// With URL images
var items = Array<FAPickerItem>()
items.append(FAPickerItem.init(id: "1",
                               title: "Facebook",
                               imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/facebook-icon_128x128.png",
                               thumb: UIImage.init(named: "Thumb")!,
                               circle: true))
items.append(FAPickerItem.init(id: "2",
                               title: "Google",
                               imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/googleplus-icon_128x128.png",
                               thumb: UIImage.init(named: "Thumb")!,
                               circle: true))
items.append(FAPickerItem.init(id: "3",
                               title: "LinkedIn",
                               imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/linkedin-icon_128x128.png",
                               thumb: UIImage.init(named: "Thumb")!,
                               circle: true))
items.append(FAPickerItem.init(id: "4",
                               title: "Twitter",
                               imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/twitter-icon_128x128.png",
                               thumb: UIImage.init(named: "Thumb")!,
                               circle: true))
items.append(FAPickerItem.init(id: "5",
                               title: "Youtube",
                               imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/youtube-icon_128x128.png",
                               thumb: UIImage.init(named: "Thumb")!,
                               circle: true))

FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.357, blue: 0.675, alpha: 1.00))
FAPickerView.showSingleSelectItem(items: NSMutableArray(array:items),
                                  selectedItem: nil,
                                  filter: true,
                                  headerTitle: "Select item with image",
                                  cancelTitle: "cancel",
                                  confirmTitle: "confirm",
                                  complete: { (items:FAPickerItem?) in
                                    
}, cancel: {
    
})
```
```ruby
// Colored items
var items = Array<FAPickerItem>()
items.append(FAPickerItem.init(id: "1", title: "Red", titleColor: .red, imageColor: .red, circle: true))
items.append(FAPickerItem.init(id: "2", title: "Blue", titleColor: .blue, imageColor: .blue, circle: true))
items.append(FAPickerItem.init(id: "3", title: "Green", titleColor: .green, imageColor: .green, circle: false))
items.append(FAPickerItem.init(id: "4", title: "Orange", titleColor: .orange, imageColor: .orange, circle: false))

FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.357, blue: 0.675, alpha: 1.00))
FAPickerView.showSingleSelectItem(items: NSMutableArray(array:items),
                                  selectedItemTitle: nil,
                                  filter: false,
                                  headerTitle: "Select item with color",
                                  cancelTitle: "cancel",
                                  confirmTitle: "confirm",
                                  complete: { (item:FAPickerItem?) in
                                    
}, cancel: {
    
})
```
---
### Date

<img src="http://www.m5zn.com/newuploads/2018/03/04/gif//60668cc80da759b.gif" height="400"/>

##### ObjC

```ruby
// English format
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
}];
```
```ruby
// Arabic format
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
```
```ruby
// Time
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
```
```ruby
// Date Range
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
```
```ruby
// Time Range
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

```

##### Swift 4+

```ruby
// English format
FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.675, blue: 0.357, alpha: 1.00))
FAPickerView.setDateTimeLocalized("en_USA")
FAPickerView.showDate(selectedDate: selectedDate,
                      headerTitle: "Select Date",
                      cancelTitle: "cancel",
                      confirmTitle: "confirm",
                      complete: { (date:Date?) in
                       self.selectedDate = date!
}, cancel: {
    
})
```
```ruby
// Arabic format
FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.675, blue: 0.357, alpha: 1.00))
FAPickerView.setDateTimeLocalized("ar_KSA")
FAPickerView.showDate(selectedDate: selectedDate,
                      headerTitle: "اختر التاريخ",
                      cancelTitle: "الغاء",
                      confirmTitle: "موافق",
                      complete: { (date:Date?) in
                        self.selectedDate = date!
}, cancel: {
    
})
```
```ruby
// Time
FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.675, blue: 0.357, alpha: 1.00))
FAPickerView.setDateTimeLocalized("en_USA")
FAPickerView.showDate(selectedDate: selectedDate,
                      datePickerMode: .time,
                      headerTitle: "Select Date",
                      cancelTitle: "cancel",
                      confirmTitle: "confirm",
                      complete: { (date:Date?) in
                        self.selectedDate = date!
}, cancel: {
    
})
```
```ruby
// Date Range
let calendar = NSCalendar.init(calendarIdentifier: .gregorian)
let currentDate = Date()
var comps = DateComponents.init()
comps.day = 5
let maxDate = calendar?.date(byAdding: comps as DateComponents, to: currentDate, options: NSCalendar.Options(rawValue: 0))
comps.day = -5
let minDate = calendar?.date(byAdding: comps as DateComponents, to: currentDate, options: NSCalendar.Options(rawValue: 0))

FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.675, blue: 0.357, alpha: 1.00))
FAPickerView.setDateTimeLocalized("en_USA")
FAPickerView.showDateWithRange(selectedDate: selectedDate,
                               maximumDate: maxDate ?? Date(),
                               minimumDate: minDate ?? Date(),
                               headerTitle: "Select Date with range",
                               cancelTitle: "cancel",
                               confirmTitle: "confirm",
                               complete: { (date:Date?) in
                                self.selectedDate = date!
}, cancel: {
    
})
```
```ruby
// Time Range
let calendar = NSCalendar.init(calendarIdentifier: .gregorian)
let currentDate = Date()
var comps = DateComponents.init()
comps.hour = 5
let maxDate = calendar?.date(byAdding: comps as DateComponents, to: currentDate, options: NSCalendar.Options(rawValue: 0))
comps.hour = -5
let minDate = calendar?.date(byAdding: comps as DateComponents, to: currentDate, options: NSCalendar.Options(rawValue: 0))

FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.675, blue: 0.357, alpha: 1.00))
FAPickerView.setDateTimeLocalized("en_USA")
FAPickerView.showDateWithRange(selectedDate: selectedDate,
                               datePickerMode: .dateAndTime,
                               maximumDate: maxDate ?? Date(),
                               minimumDate: minDate ?? Date(),
                               headerTitle: "Select Datetime with range",
                               cancelTitle: "cancel",
                               confirmTitle: "confirm",
                               complete: { (date:Date?) in
                                self.selectedDate = date!
}, cancel: {
    
})
```
---
### Color

<img src="http://www.m5zn.com/newuploads/2018/03/04/gif//cf44d7698bde5f2.gif" height="400"/>

##### ObjC

```ruby
[FAPickerView showWithSelectedColor:[tableView cellForRowAtIndexPath:indexPath].textLabel.textColor
                                 HeaderTitle:@"Select color"
                           cancelButtonTitle:@"Cancel"
                          confirmButtonTitle:@"Confirm"
                              WithCompletion:^(UIColor *color) {
                                  [tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = color;
                                  [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = color.hexStringFromColorNoAlpha;
                              } cancel:^{
                                  
                              }];
```

##### Swift 4+

```ruby
FAPickerView.showColor(selectedColor: tableView.cellForRow(at: indexPath)?.textLabel?.textColor ?? UIColor.white,
                       headerTitle: "Select color",
                       cancelTitle: "cancel",
                       confirmTitle: "confirm",
                       complete: { (color:UIColor?) in
                        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = color
                        tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = color?.hexStringFromColorNoAlpha()
}, cancel: {
    
})
```
---
### Custom View

<img src="http://www.m5zn.com/newuploads/2018/03/04/gif//a18bf99a2105d33.gif" height="400"/>

##### ObjC

```ruby
// Container View
[FAPickerView setMainColor:[UIColor colorWithRed:0.99 green:0.49 blue:0.32 alpha:1.0]];
[FAPickerView showWithCustomView:[self.storyboard instantiateViewControllerWithIdentifier:@"FACustomViewController"]
                              headerTitle:@"Custom View"
                        confirmButtonTitle:@"Done"
                         cancelButtonTitle:@"Cancel"
                            WithCompletion:^(FAPickerCustomViewButton button) {
                                
                            }];
```
```ruby
// Picker View
[FAPickerView setMainColor:[UIColor colorWithRed:0.99 green:0.49 blue:0.32 alpha:1.0]];
FACustomViewController * view = [self.storyboard instantiateViewControllerWithIdentifier:@"FACustomViewController"];
view.isCustomPicker = YES;
[FAPickerView showWithCustomPickerView:view CancelGesture:NO];
```
##### Swift 4

```ruby
// Container View
FAPickerView.setMainColor(UIColor.init(red: 0.99, green: 0.49, blue: 0.32, alpha: 1.00))
FAPickerView.showCustomContainerView(viewController: (self.storyboard?.instantiateViewController(withIdentifier: "FACustomViewController"))!,
                                     headerTitle: "Custom View",
                                     confirmTitle: "Done",
                                     cancelTitle: "Cancel") { (button:FAPickerCustomViewButton) in
                                        
}
```
```ruby
// Picker View
if let view = self.storyboard?.instantiateViewController(withIdentifier: "FACustomViewController") as? FACustomViewController {
    view.isCustomPicker = true
    FAPickerView.showCustomPickerView(viewController: view, isCancelable: false)
}
```
---
### Alert View

<img src="http://www.m5zn.com/newuploads/2018/03/04/gif//1ce8f03713c2651.gif" height="400"/>

##### ObjC

```ruby
// One button
[FAPickerView setMainColor:[UIColor colorWithRed:0.675 green:0.000 blue:0.357 alpha:1.00]];
[FAPickerView showWithMessage:@"One Button ......."
                           headerTitle:@"Alert !"
                        confirmButtonTitle:@"Done"
                            WithCompletion:^(FAPickerAlertButton button) {
                                NSLog(@"Button pressed : %i",(int)button);
                            }];
```
```ruby
// Two button
[FAPickerView setMainColor:[UIColor colorWithRed:0.675 green:0.000 blue:0.357 alpha:1.00]];
[FAPickerView showWithMessage:@"Two Button ......."
                               headerTitle:@"Alert !"
                        confirmButtonTitle:@"Confirm"
                         cancelButtonTitle:@"Cancel"
                            WithCompletion:^(FAPickerAlertButton button) {
                                NSLog(@"Button pressed : %i",(int)button);
                            }];
```
```ruby
// Three buttons
[FAPickerView setMainColor:[UIColor colorWithRed:0.675 green:0.000 blue:0.357 alpha:1.00]];
[FAPickerView showWithMessage:@"Three Buttons ......."
                               headerTitle:@"Alert !"
                        confirmButtonTitle:@"Yes"
                         cancelButtonTitle:@"No"
                          thirdButtonTitle:@"Cancel"
                            WithCompletion:^(FAPickerAlertButton button) {
                                NSLog(@"Button pressed : %i",(int)button);
                            }];
```

##### Swift 4

```ruby
// One button
FAPickerView.setMainColor(UIColor.init(red: 0.675, green: 0.000, blue: 0.357, alpha: 1.00))
FAPickerView.showAlert(message: "One Button .......",
                       headerTitle: "Alert !",
                       confirmTitle: "Done") { (button:FAPickerAlertButton) in
                        
}
```
```ruby
// Two button
FAPickerView.setMainColor(UIColor.init(red: 0.675, green: 0.000, blue: 0.357, alpha: 1.00))
FAPickerView.showAlert(message: "Two Button .......",
                       headerTitle: "Alert !",
                       confirmTitle: "Confirm",
                       cancelTitle: "Cancel") { (button:FAPickerAlertButton) in
                        
}
```
```ruby
// Three buttons
FAPickerView.setMainColor(UIColor.init(red: 0.675, green: 0.000, blue: 0.357, alpha: 1.00))
FAPickerView.showAlert(message: "Three Buttons .......",
                       headerTitle: "Alert !",
                       confirmTitle: "Yes",
                       cancelTitle: "No",
                       thirdOptionTitle: "Cancel") { (button:FAPickerAlertButton) in
                        
}
```
## Installation

FAPickerView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "FAPickerView"
```

## Author

fadizant, fadizant@gmail.com

## License

FAPickerView is available under the MIT license. See the LICENSE file for more info.
