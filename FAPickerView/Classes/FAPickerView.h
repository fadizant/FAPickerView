//
//  FAPickerView.h
//
//  Created by Fadi Abuzant on 3/4/18.
//  Copyright © 2018 fadizant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAColorPickerWheelView.h"
#import "FAColorPicker.h"
#import "FAColorPickerColor.h"
#import "FAColorPicker+UIColor.h"
#import "FAPickerItem.h"
#import "FAPickerSection.h"

//@class FAPickerView;
//@class FAPickerItem;

#pragma mark - Block declear
//Alert
typedef NS_ENUM(NSInteger, FAPickerAlertButton) {
    FAPickerAlertButtonCancel,
    FAPickerAlertButtonConfirm,
    FAPickerAlertButtonThird,
};

//Custom View
typedef NS_ENUM(NSInteger, FAPickerCustomViewButton) {
    FAPickerCustomViewButtonCancel,
    FAPickerCustomViewButtonConfirm,
};

typedef void (^completedWithItem)(FAPickerItem* item);
typedef void (^completedWithItemsAtItems)(NSMutableArray <FAPickerItem*> *items);
typedef void (^completedWithDate)(NSDate* date);
typedef void (^completedWithAlert)(FAPickerAlertButton button);
typedef void (^completedWithColor)(UIColor* color);
typedef void (^completedWithCustomView)(FAPickerCustomViewButton button);
typedef void (^cancel)(void);

@interface FAPickerView : UIView<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>

#pragma mark - Static

+(FAPickerView*)picker;
+(FAPickerView*)currentPicker;

#pragma mark Close
+(void)ClosePicker;

#pragma mark - Initialize and methods the picker view
/** picker type enum */
typedef NS_ENUM(NSInteger, FAPickerType) {
    FAPickerTypeItems,
    FAPickerTypeDate,
    FAPickerTypeAlert,
    FAPickerTypeColor,
    FAPickerTypeCustomView,
    FAPickerTypeCustomPicker,
};

+(UIColor*)mainColor;
+(void)setMainColor:(UIColor*)color;
+(void)setDateTimeLocalized:(NSString*)localized;

/** Initialize the picker view with titles
 @param headerTitle The title of header
 @param cancelButtonTitle The title for cancelButton
 @param confirmButtonTitle The title for confirmButton
 */
- (id)initWithType:(FAPickerType)pickerType
       HeaderTitle:(NSString *)headerTitle
 cancelButtonTitle:(NSString *)cancelButtonTitle
confirmButtonTitle:(NSString *)confirmButtonTitle;

/** show the picker */
//- (void)show;
//- (void)showInContainer:(id)container;

/** reload the picker */
- (void)reloadData;

/** return previously selected item */
- (FAPickerItem*) selectedItem;

/** return previously selected item, in array of FAPickerItem form. */
- (NSMutableArray<FAPickerItem*>*)selectedItems;

/** set pre-selected items, items should be array of FAPickerItem. */
- (void)setSelectedItems:(NSMutableArray <FAPickerItem*> *)items;

#pragma mark - block methods
#pragma mark Items with single selctor
-(void)showWithItems:(NSMutableArray<FAPickerItem*>*)items
        selectedItem:(FAPickerItem*)item
              filter:(BOOL)filter
         HeaderTitle:(NSString *)headerTitle
   cancelButtonTitle:(NSString *)cancelButtonTitle
  confirmButtonTitle:(NSString *)confirmButtonTitle
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel;

-(void)showWithItems:(NSMutableArray<FAPickerItem*>*)items
selectedItemWithTitle:(NSString *)title
              filter:(BOOL)filter
         HeaderTitle:(NSString *)headerTitle
   cancelButtonTitle:(NSString *)cancelButtonTitle
  confirmButtonTitle:(NSString *)confirmButtonTitle
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel;

#pragma mark Items with multi selctor
-(void)showWithItems:(NSMutableArray<FAPickerItem*>*)items
       selectedItems:(NSMutableArray<FAPickerItem*>*)selectedItems
              filter:(BOOL)filter
         HeaderTitle:(NSString *)headerTitle
   cancelButtonTitle:(NSString *)cancelButtonTitle
  confirmButtonTitle:(NSString *)confirmButtonTitle
      WithCompletion:(completedWithItemsAtItems)complete cancel:(cancel)cancel;

#pragma mark Items with single selctor Without footer
-(void)showWithItems:(NSMutableArray<FAPickerItem*>*)items
        selectedItem:(FAPickerItem*)item
              filter:(BOOL)filter
         HeaderTitle:(NSString *)headerTitle
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel;

-(void)showWithItems:(NSMutableArray<FAPickerItem*>*)items
              filter:(BOOL)filter
selectedItemWithTitle:(NSString *)title
         HeaderTitle:(NSString *)headerTitle
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel;

    
#pragma mark Sections with single selctor
-(void)showWithSections:(NSMutableArray<FAPickerSection *>*)sections
           selectedItem:(FAPickerItem*)item
            HeaderTitle:(NSString *)headerTitle
      cancelButtonTitle:(NSString *)cancelButtonTitle
     confirmButtonTitle:(NSString *)confirmButtonTitle
         WithCompletion:(completedWithItem)complete cancel:(cancel)cancel;
    
    -(void)showWithSections:(NSMutableArray<FAPickerSection *>*)sections
      selectedItemWithTitle:(NSString *)title
                HeaderTitle:(NSString *)headerTitle
          cancelButtonTitle:(NSString *)cancelButtonTitle
         confirmButtonTitle:(NSString *)confirmButtonTitle
             WithCompletion:(completedWithItem)complete cancel:(cancel)cancel;

#pragma mark Sections with multi selctor
-(void)showWithSections:(NSMutableArray<FAPickerSection *>*)sections
          selectedItems:(NSMutableArray<FAPickerItem*>*)selectedItems
            HeaderTitle:(NSString *)headerTitle
      cancelButtonTitle:(NSString *)cancelButtonTitle
     confirmButtonTitle:(NSString *)confirmButtonTitle
         WithCompletion:(completedWithItemsAtItems)complete cancel:(cancel)cancel;
    
#pragma mark Sections with single selctor Without footer
-(void)showWithSections:(NSMutableArray<FAPickerSection *>*)sections
           selectedItem:(FAPickerItem*)item
            HeaderTitle:(NSString *)headerTitle
         WithCompletion:(completedWithItem)complete cancel:(cancel)cancel;
    
-(void)showWithSections:(NSMutableArray<FAPickerSection *>*)sections
  selectedItemWithTitle:(NSString *)title
            HeaderTitle:(NSString *)headerTitle
         WithCompletion:(completedWithItem)complete cancel:(cancel)cancel;
    
    
#pragma mark Date

-(void)showWithSelectedDate:(NSDate *)date
                HeaderTitle:(NSString *)headerTitle
          cancelButtonTitle:(NSString *)cancelButtonTitle
         confirmButtonTitle:(NSString *)confirmButtonTitle
             WithCompletion:(completedWithDate)complete cancel:(cancel)cancel;

-(void)showWithSelectedDate:(NSDate *)date
                 DateFormat:(UIDatePickerMode)datePickerMode
                HeaderTitle:(NSString *)headerTitle
          cancelButtonTitle:(NSString *)cancelButtonTitle
         confirmButtonTitle:(NSString *)confirmButtonTitle
             WithCompletion:(completedWithDate)complete cancel:(cancel)cancel;

#pragma mark Date and Time With Range
-(void)showWithSelectedDate:(NSDate *)date
                MaximumDate:(NSDate *)maximumDate
                MinimumDate:(NSDate *)minimumDate
                HeaderTitle:(NSString *)headerTitle
          cancelButtonTitle:(NSString *)cancelButtonTitle
         confirmButtonTitle:(NSString *)confirmButtonTitle
             WithCompletion:(completedWithDate)complete cancel:(cancel)cancel;

-(void)showWithSelectedDate:(NSDate *)date
                 DateFormat:(UIDatePickerMode)datePickerMode
                MaximumDate:(NSDate *)maximumDate
                MinimumDate:(NSDate *)minimumDate
                HeaderTitle:(NSString *)headerTitle
          cancelButtonTitle:(NSString *)cancelButtonTitle
         confirmButtonTitle:(NSString *)confirmButtonTitle
             WithCompletion:(completedWithDate)complete cancel:(cancel)cancel;

#pragma mark Color

-(void)showWithSelectedColor:(UIColor *)color
                 HeaderTitle:(NSString *)headerTitle
           cancelButtonTitle:(NSString *)cancelButtonTitle
          confirmButtonTitle:(NSString *)confirmButtonTitle
              WithCompletion:(completedWithColor)complete cancel:(cancel)cancel;

#pragma mark Alert

-(void)showWithMessage:(NSString *)message
           headerTitle:(NSString *)headerTitle
    confirmButtonTitle:(NSString *)confirmButtonTitle
        WithCompletion:(completedWithAlert)complete;

-(void)showWithMessage:(NSString *)message
           headerTitle:(NSString *)headerTitle
    confirmButtonTitle:(NSString *)confirmButtonTitle
     cancelButtonTitle:(NSString *)cancelButtonTitle
        WithCompletion:(completedWithAlert)complete;

-(void)showWithMessage:(NSString *)message
           headerTitle:(NSString *)headerTitle
    confirmButtonTitle:(NSString *)confirmButtonTitle
     cancelButtonTitle:(NSString *)cancelButtonTitle
      thirdButtonTitle:(NSString *)thirdButtonTitle
        WithCompletion:(completedWithAlert)complete;

#pragma mark Custom View

-(void)showWithCustomView:(UIViewController *)view
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
           WithCompletion:(completedWithCustomView)complete;

-(void)showWithCustomView:(UIViewController *)view
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
        cancelButtonTitle:(NSString *)cancelButtonTitle
           WithCompletion:(completedWithCustomView)complete;

-(void)showWithCustomView:(UIViewController *)view
CustomViewContainerHeight:(float)height
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
           WithCompletion:(completedWithCustomView)complete;

-(void)showWithCustomView:(UIViewController *)view
CustomViewContainerHeight:(float)height
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
        cancelButtonTitle:(NSString *)cancelButtonTitle
           WithCompletion:(completedWithCustomView)complete;

-(void)showWithCustomView:(UIViewController *)view
            BottomPadding:(float)bottomPadding
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
           WithCompletion:(completedWithCustomView)complete;

-(void)showWithCustomView:(UIViewController *)view
            BottomPadding:(float)bottomPadding
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
        cancelButtonTitle:(NSString *)cancelButtonTitle
           WithCompletion:(completedWithCustomView)complete;

#pragma mark Custom Picker

-(void)showWithCustomPickerView:(UIViewController *)view;

-(void)showWithCustomPickerView:(UIViewController *)view
                  CancelGesture:(BOOL)cancelGesture;

-(void)showWithCustomPickerView:(UIViewController *)view
      CustomViewContainerHeight:(float)height;

-(void)showWithCustomPickerView:(UIViewController *)view
      CustomViewContainerHeight:(float)height
                  CancelGesture:(BOOL)cancelGesture;

-(void)showWithCustomPickerView:(UIViewController *)view
                  BottomPadding:(float)bottomPadding;

-(void)showWithCustomPickerView:(UIViewController *)view
                  BottomPadding:(float)bottomPadding
                  CancelGesture:(BOOL)cancelGesture;

#pragma mark - Style

/** whether to show footer (including confirm and cancel buttons), default NO */
@property BOOL needFooterView;

/** whether allow tap background to dismiss the picker, default YES */
@property BOOL tapBackgroundToDismiss;

/** whether allow selection of multiple items/rows, default NO, if this
 property is YES, then footerView will be shown */
@property BOOL allowMultipleSelection;

/** picker header background color */
@property (nonatomic, strong) UIColor *headerBackgroundColor;

/** picker header title font */
@property (nonatomic, strong) UIFont *headerTitleFont;

/** picker header title color */
@property (nonatomic, strong) UIColor *headerTitleColor;

/** picker cancel button background color */
@property (nonatomic, strong) UIColor *cancelButtonBackgroundColor;

/** picker cancel button normal state color */
@property (nonatomic, strong) UIColor *cancelButtonNormalColor;

/** picker cancel button highlighted state color */
@property (nonatomic, strong) UIColor *cancelButtonHighlightedColor;

/** picker confirm button background color */
@property (nonatomic, strong) UIColor *confirmButtonBackgroundColor;

/** picker confirm button normal state color */
@property (nonatomic, strong) UIColor *confirmButtonNormalColor;

/** picker confirm button highlighted state color */
@property (nonatomic, strong) UIColor *confirmButtonHighlightedColor;

/** tint color for tableview, also checkmark color */
@property (nonatomic, strong) UIColor *checkmarkColor;

/** picker's animation duration for showing and dismissing */
@property CGFloat animationDuration;

/** width of picker */
@property CGFloat pickerWidth;

/** picker type */
@property FAPickerType pickerType;

/** items of picker */
@property NSMutableArray <FAPickerItem*> *items;
    
/** items of picker */
@property NSMutableArray <FAPickerSection*> *sections;

/** items of picker */
@property BOOL Filter;

/** Defualt date */
@property NSDate *selectedDate;

/** selecteditem by title */
- (void)setSelectedItemByTitle:(NSString* )title;

/** Alert Message */
@property NSString *message;

/** Defualt color */
@property UIColor *selectedColorPicker;
@property (nonatomic, strong) FAColorPickerWheelView* wheelView;

/** Custom View */
@property UIViewController *customView;
@property (nonatomic) float customViewHeight;
@property (nonatomic) float customContainerViewHeight;
@property (nonatomic) float customViewBottomPadding;


#pragma mark - block value
@property completedWithItem completeWithItem;
@property completedWithDate completedWithDate;
@property completedWithItemsAtItems completedWithItemsAtItems;
@property completedWithAlert completeWithAlert;
@property completedWithColor completedWithColor;
@property completedWithCustomView completedWithCustomView;
@property cancel cancel;
@end


