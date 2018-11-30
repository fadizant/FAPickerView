//
//  FAPickerView+StaticShow.m
//  FAPickerView
//
//  Created by Fadi Abuzant on 11/12/18.
//

#import "FAPickerView+StaticShow.h"

@implementation FAPickerView (StaticShow)

#pragma mark - Block
#pragma mark Items with single selctor
+(void)showWithItems:(NSMutableArray<FAPickerItem*>*)items
        selectedItem:(nullable FAPickerItem*)item
              filter:(BOOL)filter
         HeaderTitle:(NSString *)headerTitle
   cancelButtonTitle:(NSString *)cancelButtonTitle
  confirmButtonTitle:(NSString *)confirmButtonTitle
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel
{
    [[FAPickerView picker] showWithItems:items
                            selectedItem:item
                                  filter:filter
                             HeaderTitle:headerTitle
                       cancelButtonTitle:cancelButtonTitle
                      confirmButtonTitle:confirmButtonTitle
                          WithCompletion:complete cancel:cancel];
}

+(void)showWithItems:(NSMutableArray<FAPickerItem*>*)items
selectedItemWithTitle:(nullable NSString *)title
              filter:(BOOL)filter
         HeaderTitle:(NSString *)headerTitle
   cancelButtonTitle:(NSString *)cancelButtonTitle
  confirmButtonTitle:(NSString *)confirmButtonTitle
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel
{
    [[FAPickerView picker] showWithItems:items
                   selectedItemWithTitle:title
                                  filter:filter
                             HeaderTitle:headerTitle
                       cancelButtonTitle:cancelButtonTitle
                      confirmButtonTitle:confirmButtonTitle
                          WithCompletion:complete cancel:cancel];
}

#pragma mark Items with multi selctor
+(void)showWithItems:(NSMutableArray<FAPickerItem*>*)items
       selectedItems:(nullable NSMutableArray<FAPickerItem*>*)selectedItems
              filter:(BOOL)filter
         HeaderTitle:(NSString *)headerTitle
   cancelButtonTitle:(NSString *)cancelButtonTitle
  confirmButtonTitle:(NSString *)confirmButtonTitle
      WithCompletion:(completedWithItemsAtItems)complete cancel:(cancel)cancel
{
    [[FAPickerView picker] showWithItems:items
                           selectedItems:selectedItems
                                  filter:filter
                             HeaderTitle:headerTitle
                       cancelButtonTitle:cancelButtonTitle
                      confirmButtonTitle:confirmButtonTitle
                          WithCompletion:complete cancel:cancel];
}

#pragma mark Items with single selctor Without footer
+(void)showWithItems:(NSMutableArray<FAPickerItem*>*)items
        selectedItem:(nullable FAPickerItem*)item
              filter:(BOOL)filter
         HeaderTitle:(NSString *)headerTitle
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel
{
    [[FAPickerView picker] showWithItems:items
                            selectedItem:item
                                  filter:filter
                             HeaderTitle:headerTitle
                          WithCompletion:complete cancel:cancel];
}

+(void)showWithItems:(NSMutableArray<FAPickerItem*>*)items
selectedItemWithTitle:(nullable NSString *)title
              filter:(BOOL)filter
         HeaderTitle:(NSString *)headerTitle
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel
{
    [[FAPickerView picker] showWithItems:items
                                  filter:filter
                   selectedItemWithTitle:title
                             HeaderTitle:headerTitle
                          WithCompletion:complete cancel:cancel];
}
    
#pragma mark Sections with single selctor
+(void)showWithSections:(NSMutableArray<FAPickerSection *>*)sections
           selectedItem:(FAPickerItem*)item
            HeaderTitle:(NSString *)headerTitle
      cancelButtonTitle:(NSString *)cancelButtonTitle
     confirmButtonTitle:(NSString *)confirmButtonTitle
         WithCompletion:(completedWithItem)complete cancel:(cancel)cancel{
    [[FAPickerView picker] showWithSections:sections
                               selectedItem:item
                                HeaderTitle:headerTitle
                          cancelButtonTitle:cancelButtonTitle
                         confirmButtonTitle:confirmButtonTitle
                             WithCompletion:complete cancel:cancel];
}
    
+(void)showWithSections:(NSMutableArray<FAPickerSection *>*)sections
  selectedItemWithTitle:(NSString *)title
            HeaderTitle:(NSString *)headerTitle
      cancelButtonTitle:(NSString *)cancelButtonTitle
     confirmButtonTitle:(NSString *)confirmButtonTitle
         WithCompletion:(completedWithItem)complete cancel:(cancel)cancel{
    [[FAPickerView picker] showWithSections:sections
                      selectedItemWithTitle:title
                                HeaderTitle:headerTitle
                          cancelButtonTitle:cancelButtonTitle
                         confirmButtonTitle:confirmButtonTitle
                             WithCompletion:complete cancel:cancel];
}
    
#pragma mark Sections with multi selctor
+(void)showWithSections:(NSMutableArray<FAPickerSection *>*)sections
          selectedItems:(NSMutableArray<FAPickerItem*>*)selectedItems
            HeaderTitle:(NSString *)headerTitle
      cancelButtonTitle:(NSString *)cancelButtonTitle
     confirmButtonTitle:(NSString *)confirmButtonTitle
         WithCompletion:(completedWithItemsAtItems)complete cancel:(cancel)cancel{
    [[FAPickerView picker] showWithSections:sections
                              selectedItems:selectedItems
                                HeaderTitle:headerTitle
                          cancelButtonTitle:cancelButtonTitle
                         confirmButtonTitle:confirmButtonTitle
                             WithCompletion:complete cancel:cancel];
}
    
#pragma mark Sections with single selctor Without footer
+(void)showWithSections:(NSMutableArray<FAPickerSection *>*)sections
           selectedItem:(FAPickerItem*)item
            HeaderTitle:(NSString *)headerTitle
         WithCompletion:(completedWithItem)complete cancel:(cancel)cancel{
    [[FAPickerView picker] showWithSections:sections
                               selectedItem:item
                                HeaderTitle:headerTitle
                             WithCompletion:complete cancel:cancel];
}
    
+(void)showWithSections:(NSMutableArray<FAPickerSection *>*)sections
  selectedItemWithTitle:(NSString *)title
            HeaderTitle:(NSString *)headerTitle
         WithCompletion:(completedWithItem)complete cancel:(cancel)cancel{
    [[FAPickerView picker] showWithSections:sections
                      selectedItemWithTitle:title
                                HeaderTitle:headerTitle
                             WithCompletion:complete cancel:cancel];
}

#pragma mark Date and Time

+(void)showWithSelectedDate:(NSDate *)date
                HeaderTitle:(NSString *)headerTitle
          cancelButtonTitle:(NSString *)cancelButtonTitle
         confirmButtonTitle:(NSString *)confirmButtonTitle
             WithCompletion:(completedWithDate)complete cancel:(cancel)cancel
{
    [[FAPickerView picker] showWithSelectedDate:date
                                    HeaderTitle:headerTitle
                              cancelButtonTitle:cancelButtonTitle
                             confirmButtonTitle:confirmButtonTitle
                                 WithCompletion:complete cancel:cancel];
}

+(void)showWithSelectedDate:(NSDate *)date
                 DateFormat:(UIDatePickerMode)datePickerMode
                HeaderTitle:(NSString *)headerTitle
          cancelButtonTitle:(NSString *)cancelButtonTitle
         confirmButtonTitle:(NSString *)confirmButtonTitle
             WithCompletion:(completedWithDate)complete cancel:(cancel)cancel
{
    [[FAPickerView picker] showWithSelectedDate:date
                                     DateFormat:datePickerMode
                                    HeaderTitle:headerTitle
                              cancelButtonTitle:cancelButtonTitle
                             confirmButtonTitle:confirmButtonTitle
                                 WithCompletion:complete cancel:cancel];
}

#pragma mark Date and Time With Range

+(void)showWithSelectedDate:(NSDate *)date
                MaximumDate:(NSDate *)maximumDate
                MinimumDate:(NSDate *)minimumDate
                HeaderTitle:(NSString *)headerTitle
          cancelButtonTitle:(NSString *)cancelButtonTitle
         confirmButtonTitle:(NSString *)confirmButtonTitle
             WithCompletion:(completedWithDate)complete cancel:(cancel)cancel
{
    [[FAPickerView picker] showWithSelectedDate:date
                                    MaximumDate:maximumDate
                                    MinimumDate:minimumDate
                                    HeaderTitle:headerTitle
                              cancelButtonTitle:cancelButtonTitle
                             confirmButtonTitle:confirmButtonTitle
                                 WithCompletion:complete cancel:cancel];
}

+(void)showWithSelectedDate:(NSDate *)date
                 DateFormat:(UIDatePickerMode)datePickerMode
                MaximumDate:(NSDate *)maximumDate
                MinimumDate:(NSDate *)minimumDate
                HeaderTitle:(NSString *)headerTitle
          cancelButtonTitle:(NSString *)cancelButtonTitle
         confirmButtonTitle:(NSString *)confirmButtonTitle
             WithCompletion:(completedWithDate)complete cancel:(cancel)cancel
{
    [[FAPickerView picker] showWithSelectedDate:date
                                     DateFormat:datePickerMode
                                    MaximumDate:maximumDate
                                    MinimumDate:minimumDate
                                    HeaderTitle:headerTitle
                              cancelButtonTitle:cancelButtonTitle
                             confirmButtonTitle:confirmButtonTitle
                                 WithCompletion:complete cancel:cancel];
}

#pragma mark color picker
+(void)showWithSelectedColor:(UIColor *)color
                 HeaderTitle:(NSString *)headerTitle
           cancelButtonTitle:(NSString *)cancelButtonTitle
          confirmButtonTitle:(NSString *)confirmButtonTitle
              WithCompletion:(completedWithColor)complete cancel:(cancel)cancel
{
    [[FAPickerView picker] showWithSelectedColor:color
                                     HeaderTitle:headerTitle
                               cancelButtonTitle:cancelButtonTitle
                              confirmButtonTitle:confirmButtonTitle
                                  WithCompletion:complete cancel:cancel];
}

#pragma mark Alert view
+(void)showWithMessage:(NSString *)message
           headerTitle:(NSString *)headerTitle
    confirmButtonTitle:(NSString *)confirmButtonTitle
        WithCompletion:(completedWithAlert)complete
{
    [[FAPickerView picker] showWithMessage:message
                               headerTitle:headerTitle
                        confirmButtonTitle:confirmButtonTitle
                            WithCompletion:complete];
}

+(void)showWithMessage:(NSString *)message
           headerTitle:(NSString *)headerTitle
    confirmButtonTitle:(NSString *)confirmButtonTitle
     cancelButtonTitle:(NSString *)cancelButtonTitle
        WithCompletion:(completedWithAlert)complete
{
    [[FAPickerView picker] showWithMessage:message
                               headerTitle:headerTitle
                        confirmButtonTitle:confirmButtonTitle
                         cancelButtonTitle:cancelButtonTitle
                            WithCompletion:complete];
}

+(void)showWithMessage:(NSString *)message
           headerTitle:(NSString *)headerTitle
    confirmButtonTitle:(NSString *)confirmButtonTitle
     cancelButtonTitle:(NSString *)cancelButtonTitle
      thirdButtonTitle:(NSString *)thirdButtonTitle
        WithCompletion:(completedWithAlert)complete
{
    [[FAPickerView picker] showWithMessage:message
                               headerTitle:headerTitle
                        confirmButtonTitle:confirmButtonTitle
                         cancelButtonTitle:cancelButtonTitle
                          thirdButtonTitle:thirdButtonTitle
                            WithCompletion:complete];
}

#pragma mark Custom view

+(void)showWithCustomView:(UIViewController *)view
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
           WithCompletion:(completedWithCustomView)complete
{
    [[FAPickerView picker] showWithCustomView:view
                                  headerTitle:headerTitle
                           confirmButtonTitle:confirmButtonTitle
                               WithCompletion:complete];
}

+(void)showWithCustomView:(UIViewController *)view
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
        cancelButtonTitle:(NSString *)cancelButtonTitle
           WithCompletion:(completedWithCustomView)complete
{
    [[FAPickerView picker] showWithCustomView:view
                                  headerTitle:headerTitle
                           confirmButtonTitle:confirmButtonTitle
                            cancelButtonTitle:cancelButtonTitle
                               WithCompletion:complete];
}

+(void)showWithCustomView:(UIViewController *)view
CustomViewContainerHeight:(float)height
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
           WithCompletion:(completedWithCustomView)complete
{
    [[FAPickerView picker] showWithCustomView:view
                    CustomViewContainerHeight:height
                                  headerTitle:headerTitle
                           confirmButtonTitle:confirmButtonTitle
                               WithCompletion:complete];
}

+(void)showWithCustomView:(UIViewController *)view
CustomViewContainerHeight:(float)height
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
        cancelButtonTitle:(NSString *)cancelButtonTitle
           WithCompletion:(completedWithCustomView)complete
{
    [[FAPickerView picker] showWithCustomView:view
                    CustomViewContainerHeight:height
                                  headerTitle:headerTitle
                           confirmButtonTitle:confirmButtonTitle
                            cancelButtonTitle:cancelButtonTitle
                               WithCompletion:complete];
}

+(void)showWithCustomView:(UIViewController *)view
            BottomPadding:(float)bottomPadding
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
           WithCompletion:(completedWithCustomView)complete{
    
    [[FAPickerView picker] showWithCustomView:view
                                BottomPadding:bottomPadding
                                  headerTitle:headerTitle
                           confirmButtonTitle:confirmButtonTitle
                               WithCompletion:complete];
}

+(void)showWithCustomView:(UIViewController *)view
            BottomPadding:(float)bottomPadding
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
        cancelButtonTitle:(NSString *)cancelButtonTitle
           WithCompletion:(completedWithCustomView)complete{
    
    [[FAPickerView picker] showWithCustomView:view
                                BottomPadding:bottomPadding
                                  headerTitle:headerTitle
                           confirmButtonTitle:confirmButtonTitle
                            cancelButtonTitle:cancelButtonTitle
                               WithCompletion:complete];
}

#pragma mark Custom Picker

+(void)showWithCustomPickerView:(UIViewController *)view{
    [[FAPickerView picker] showWithCustomPickerView:view];
}


+(void)showWithCustomPickerView:(UIViewController *)view
                  CancelGesture:(BOOL)cancelGesture{
    [[FAPickerView picker] showWithCustomPickerView:view
                                      CancelGesture:cancelGesture];
}


+(void)showWithCustomPickerView:(UIViewController *)view
      CustomViewContainerHeight:(float)height{
    [[FAPickerView picker] showWithCustomPickerView:view
                          CustomViewContainerHeight:height];
}

+(void)showWithCustomPickerView:(UIViewController *)view
      CustomViewContainerHeight:(float)height
                  CancelGesture:(BOOL)cancelGesture{
    [[FAPickerView picker] showWithCustomPickerView:view
                          CustomViewContainerHeight:height
                                      CancelGesture:cancelGesture];
}

+(void)showWithCustomPickerView:(UIViewController *)view
                  BottomPadding:(float)bottomPadding{
    [[FAPickerView picker] showWithCustomPickerView:view
                                      BottomPadding:bottomPadding];
}

+(void)showWithCustomPickerView:(UIViewController *)view
                  BottomPadding:(float)bottomPadding
                  CancelGesture:(BOOL)cancelGesture{
    [[FAPickerView picker] showWithCustomPickerView:view
                                      BottomPadding:bottomPadding
                                      CancelGesture:cancelGesture];
}
@end
