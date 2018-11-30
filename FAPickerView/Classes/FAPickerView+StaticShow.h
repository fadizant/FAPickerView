//
//  FAPickerView+StaticShow.h
//  FAPickerView
//
//  Created by Fadi Abuzant on 11/12/18.
//

#import <FAPickerView/FAPickerView.h>

NS_ASSUME_NONNULL_BEGIN

@interface FAPickerView (StaticShow)

#pragma mark + block methods
#pragma mark Items with single selctor
+(void)showWithItems:(NSMutableArray<FAPickerItem*>*)items
        selectedItem:(nullable FAPickerItem*)item
              filter:(BOOL)filter
         HeaderTitle:(NSString *)headerTitle
   cancelButtonTitle:(NSString *)cancelButtonTitle
  confirmButtonTitle:(NSString *)confirmButtonTitle
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel NS_SWIFT_NAME(showSingleSelectItem(items:selectedItem:filter:headerTitle:cancelTitle:confirmTitle:complete:cancel:));

+(void)showWithItems:(NSMutableArray<FAPickerItem*>*)items
selectedItemWithTitle:(nullable NSString *)title
              filter:(BOOL)filter
         HeaderTitle:(NSString *)headerTitle
   cancelButtonTitle:(NSString *)cancelButtonTitle
  confirmButtonTitle:(NSString *)confirmButtonTitle
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel NS_SWIFT_NAME(showSingleSelectItem(items:selectedItemTitle:filter:headerTitle:cancelTitle:confirmTitle:complete:cancel:));

#pragma mark Items with multi selctor
+(void)showWithItems:(NSMutableArray<FAPickerItem*>*)items
       selectedItems:(nullable NSMutableArray<FAPickerItem*>*)selectedItems
              filter:(BOOL)filter
         HeaderTitle:(NSString *)headerTitle
   cancelButtonTitle:(NSString *)cancelButtonTitle
  confirmButtonTitle:(NSString *)confirmButtonTitle
      WithCompletion:(completedWithItemsAtItems)complete cancel:(cancel)cancel NS_SWIFT_NAME(showMultiSelectItems(items:selectedItems:filter:headerTitle:cancelTitle:confirmTitle:complete:cancel:));

#pragma mark Items with single selctor Without footer
+(void)showWithItems:(NSMutableArray<FAPickerItem*>*)items
        selectedItem:(nullable FAPickerItem*)item
              filter:(BOOL)filter
         HeaderTitle:(NSString *)headerTitle
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel NS_SWIFT_NAME(showSingleSelectItem(items:selectedItem:filter:headerTitle:complete:cancel:));

+(void)showWithItems:(NSMutableArray<FAPickerItem*>*)items
selectedItemWithTitle:(nullable NSString *)title
              filter:(BOOL)filter
         HeaderTitle:(NSString *)headerTitle
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel NS_SWIFT_NAME(showSingleSelectItem(items:selectedItemTitle:filter:headerTitle:complete:cancel:));

#pragma mark Sections with single selctor
+(void)showWithSections:(NSMutableArray<FAPickerSection *>*)sections
           selectedItem:(FAPickerItem*)item
            HeaderTitle:(NSString *)headerTitle
      cancelButtonTitle:(NSString *)cancelButtonTitle
     confirmButtonTitle:(NSString *)confirmButtonTitle
         WithCompletion:(completedWithItem)complete cancel:(cancel)cancel NS_SWIFT_NAME(showSectionsWithSingleSelectItem(sections:selectedItem:headerTitle:cancelTitle:confirmTitle:complete:cancel:));
    
+(void)showWithSections:(NSMutableArray<FAPickerSection *>*)sections
  selectedItemWithTitle:(NSString *)title
            HeaderTitle:(NSString *)headerTitle
      cancelButtonTitle:(NSString *)cancelButtonTitle
     confirmButtonTitle:(NSString *)confirmButtonTitle
         WithCompletion:(completedWithItem)complete cancel:(cancel)cancel NS_SWIFT_NAME(showSectionsWithSingleSelectItem(sections:selectedItemTitle:headerTitle:cancelTitle:confirmTitle:complete:cancel:));
    
#pragma mark Sections with multi selctor
+(void)showWithSections:(NSMutableArray<FAPickerSection *>*)sections
          selectedItems:(NSMutableArray<FAPickerItem*>*)selectedItems
            HeaderTitle:(NSString *)headerTitle
      cancelButtonTitle:(NSString *)cancelButtonTitle
     confirmButtonTitle:(NSString *)confirmButtonTitle
         WithCompletion:(completedWithItemsAtItems)complete cancel:(cancel)cancel NS_SWIFT_NAME(showSectionsWithMultiSelectItem(sections:selectedItems:headerTitle:cancelTitle:confirmTitle:complete:cancel:));
    
#pragma mark Sections with single selctor Without footer
+(void)showWithSections:(NSMutableArray<FAPickerSection *>*)sections
           selectedItem:(FAPickerItem*)item
            HeaderTitle:(NSString *)headerTitle
         WithCompletion:(completedWithItem)complete cancel:(cancel)cancel NS_SWIFT_NAME(showSectionsWithSingleSelectItem(sections:selectedItem:headerTitle:complete:cancel:));
    
+(void)showWithSections:(NSMutableArray<FAPickerSection *>*)sections
  selectedItemWithTitle:(NSString *)title
            HeaderTitle:(NSString *)headerTitle
         WithCompletion:(completedWithItem)complete cancel:(cancel)cancel NS_SWIFT_NAME(showSectionsWithSingleSelectItem(sections:selectedItemTitle:headerTitle:complete:cancel:));
    
#pragma mark Date

+(void)showWithSelectedDate:(NSDate *)date
                HeaderTitle:(NSString *)headerTitle
          cancelButtonTitle:(NSString *)cancelButtonTitle
         confirmButtonTitle:(NSString *)confirmButtonTitle
             WithCompletion:(completedWithDate)complete cancel:(cancel)cancel NS_SWIFT_NAME(showDate(selectedDate:headerTitle:cancelTitle:confirmTitle:complete:cancel:));

+(void)showWithSelectedDate:(NSDate *)date
                 DateFormat:(UIDatePickerMode)datePickerMode
                HeaderTitle:(NSString *)headerTitle
          cancelButtonTitle:(NSString *)cancelButtonTitle
         confirmButtonTitle:(NSString *)confirmButtonTitle
             WithCompletion:(completedWithDate)complete cancel:(cancel)cancel NS_SWIFT_NAME(showDate(selectedDate:datePickerMode:headerTitle:cancelTitle:confirmTitle:complete:cancel:));

#pragma mark Date and Time With Range
+(void)showWithSelectedDate:(NSDate *)date
                MaximumDate:(NSDate *)maximumDate
                MinimumDate:(NSDate *)minimumDate
                HeaderTitle:(NSString *)headerTitle
          cancelButtonTitle:(NSString *)cancelButtonTitle
         confirmButtonTitle:(NSString *)confirmButtonTitle
             WithCompletion:(completedWithDate)complete cancel:(cancel)cancel NS_SWIFT_NAME(showDateWithRange(selectedDate:maximumDate:minimumDate:headerTitle:cancelTitle:confirmTitle:complete:cancel:));

+(void)showWithSelectedDate:(NSDate *)date
                 DateFormat:(UIDatePickerMode)datePickerMode
                MaximumDate:(NSDate *)maximumDate
                MinimumDate:(NSDate *)minimumDate
                HeaderTitle:(NSString *)headerTitle
          cancelButtonTitle:(NSString *)cancelButtonTitle
         confirmButtonTitle:(NSString *)confirmButtonTitle
             WithCompletion:(completedWithDate)complete cancel:(cancel)cancel NS_SWIFT_NAME(showDateWithRange(selectedDate:datePickerMode:maximumDate:minimumDate:headerTitle:cancelTitle:confirmTitle:complete:cancel:));

#pragma mark Color

+(void)showWithSelectedColor:(UIColor *)color
                 HeaderTitle:(NSString *)headerTitle
           cancelButtonTitle:(NSString *)cancelButtonTitle
          confirmButtonTitle:(NSString *)confirmButtonTitle
              WithCompletion:(completedWithColor)complete cancel:(cancel)cancel NS_SWIFT_NAME(showColor(selectedColor:headerTitle:cancelTitle:confirmTitle:complete:cancel:));

#pragma mark Alert

+(void)showWithMessage:(NSString *)message
           headerTitle:(NSString *)headerTitle
    confirmButtonTitle:(NSString *)confirmButtonTitle
        WithCompletion:(completedWithAlert)complete NS_SWIFT_NAME(showAlert(message:headerTitle:confirmTitle:complete:));

+(void)showWithMessage:(NSString *)message
           headerTitle:(NSString *)headerTitle
    confirmButtonTitle:(NSString *)confirmButtonTitle
     cancelButtonTitle:(NSString *)cancelButtonTitle
        WithCompletion:(completedWithAlert)complete NS_SWIFT_NAME(showAlert(message:headerTitle:confirmTitle:cancelTitle:complete:));

+(void)showWithMessage:(NSString *)message
           headerTitle:(NSString *)headerTitle
    confirmButtonTitle:(NSString *)confirmButtonTitle
     cancelButtonTitle:(NSString *)cancelButtonTitle
      thirdButtonTitle:(NSString *)thirdButtonTitle
        WithCompletion:(completedWithAlert)complete NS_SWIFT_NAME(showAlert(message:headerTitle:confirmTitle:cancelTitle:thirdOptionTitle:complete:));

#pragma mark Custom View

+(void)showWithCustomView:(UIViewController *)view
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
           WithCompletion:(completedWithCustomView)complete NS_SWIFT_NAME(showCustomContainerView(viewController:headerTitle:confirmTitle:complete:));

+(void)showWithCustomView:(UIViewController *)view
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
        cancelButtonTitle:(NSString *)cancelButtonTitle
           WithCompletion:(completedWithCustomView)complete NS_SWIFT_NAME(showCustomContainerView(viewController:headerTitle:confirmTitle:cancelTitle:complete:));

+(void)showWithCustomView:(UIViewController *)view
CustomViewContainerHeight:(float)height
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
           WithCompletion:(completedWithCustomView)complete NS_SWIFT_NAME(showCustomContainerViewWithHeight(viewController:height:headerTitle:confirmTitle:complete:));

+(void)showWithCustomView:(UIViewController *)view
CustomViewContainerHeight:(float)height
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
        cancelButtonTitle:(NSString *)cancelButtonTitle
           WithCompletion:(completedWithCustomView)complete NS_SWIFT_NAME(showCustomContainerViewWithHeight(viewController:height:headerTitle:confirmTitle:cancelTitle:complete:));

+(void)showWithCustomView:(UIViewController *)view
            BottomPadding:(float)bottomPadding
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
           WithCompletion:(completedWithCustomView)complete NS_SWIFT_NAME(showCustomContainerViewWithBottomPadding(viewController:bottomPadding:headerTitle:confirmTitle:complete:));

+(void)showWithCustomView:(UIViewController *)view
            BottomPadding:(float)bottomPadding
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
        cancelButtonTitle:(NSString *)cancelButtonTitle
           WithCompletion:(completedWithCustomView)complete NS_SWIFT_NAME(showCustomContainerViewWithBottomPadding(viewController:bottomPadding:headerTitle:confirmTitle:cancelTitle:complete:));

#pragma mark Custom Picker

+(void)showWithCustomPickerView:(UIViewController *)view NS_SWIFT_NAME(showCustomPickerView(viewController:));

+(void)showWithCustomPickerView:(UIViewController *)view
                  CancelGesture:(BOOL)cancelGesture NS_SWIFT_NAME(showCustomPickerView(viewController:isCancelable:));

+(void)showWithCustomPickerView:(UIViewController *)view
      CustomViewContainerHeight:(float)height NS_SWIFT_NAME(showCustomPickerViewWithHeight(viewController:height:));

+(void)showWithCustomPickerView:(UIViewController *)view
      CustomViewContainerHeight:(float)height
                  CancelGesture:(BOOL)cancelGesture NS_SWIFT_NAME(showCustomPickerViewWithHeight(viewController:height:isCancelable:));

+(void)showWithCustomPickerView:(UIViewController *)view
                  BottomPadding:(float)bottomPadding NS_SWIFT_NAME(showCustomPickerViewWithBottomPadding(viewController:bottomPadding:));

+(void)showWithCustomPickerView:(UIViewController *)view
                  BottomPadding:(float)bottomPadding
                  CancelGesture:(BOOL)cancelGesture NS_SWIFT_NAME(showCustomPickerViewWithBottomPadding(viewController:bottomPadding:isCancelable:));
@end

NS_ASSUME_NONNULL_END
