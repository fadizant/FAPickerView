//
//  FAPickerView.h
//
//  Created by chenzeyu on 9/6/15.
//  Copyright (c) 2015 chenzeyu. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FAPickerView;
@class FAPickerItem;

@protocol FAPickerViewDataSource <NSObject>

@required

@optional
/* number of items for picker */
- (NSInteger)numberOfRowsInPickerView:(FAPickerView *)pickerView;

/*
 Implement at least one of the following method,
 FAPickerView:(FAPickerView *)pickerView
 attributedTitleForRow:(NSInteger)row has higer priority
*/

/* attributed picker item title for each row */
- (NSAttributedString *)fapickerView:(FAPickerView *)pickerView
                            attributedTitleForRow:(NSInteger)row;

/* picker item title for each row */
- (NSString *)fapickerView:(FAPickerView *)pickerView
                            titleForRow:(NSInteger)row;

/* picker item image for each row */
- (UIImage *)fapickerView:(FAPickerView *)pickerView imageForRow:(NSInteger)row;

@end

@protocol FAPickerViewDelegate <NSObject>

@optional

/** delegate method for picking one item */
- (void)fapickerView:(FAPickerView *)pickerView
          didConfirmWithItemAtRow:(NSInteger)row;

- (void)fapickerView:(FAPickerView *)pickerView
    didConfirmWithItem:(FAPickerItem*)item;

- (void)fapickerView:(FAPickerView *)pickerView
  didConfirmWithDate:(NSDate*)date;

/*
 delegate method for picking multiple items,
 implement this method if allowMultipleSelection is YES,
 rows is an array of NSNumbers
 */
- (void)fapickerView:(FAPickerView *)pickerView
          didConfirmWithItemsAtRows:(NSArray *)rows;

- (void)fapickerView:(FAPickerView *)pickerView
    didConfirmWithItemsAtItems:(NSMutableArray <FAPickerItem*> *)items;

/** delegate method for canceling */
- (void)fapickerViewDidClickCancelButton:(FAPickerView *)pickerView;

/* picker will show */
- (void)fapickerViewWillDisplay:(FAPickerView *)pickerView;

/* picker did show */
- (void)fapickerViewDidDisplay:(FAPickerView *)pickerView;

/* picker will dismiss */
- (void)fapickerViewWillDismiss:(FAPickerView *)pickerView;

/* picker did dismiss */
- (void)fapickerViewDidDismiss:(FAPickerView *)pickerView;

@end

#pragma mark - Block declear
//Block
typedef NS_ENUM(NSInteger, FAPickerAlertButton) {
    FAPickerAlertButtonCancel,
    FAPickerAlertButtonConfirm,
    FAPickerAlertButtonThird,
};

typedef void (^completedWithItem)(FAPickerItem* item);
typedef void (^completedWithDate)(NSDate* date);
typedef void (^completedWithItemsAtItems)(NSMutableArray <FAPickerItem*> *items);
typedef void (^completedWithAlert)(FAPickerAlertButton button);
typedef void (^cancel)();

@interface FAPickerView : UIView<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>

#pragma mark - Static

+(FAPickerView*)picker;

#pragma mark - Initialize and methods the picker view
/** picker type enum */
typedef NS_ENUM(NSInteger, FAPickerType) {
    FAPickerTypeItems,
    FAPickerTypeDate,
    FAPickerTypeAlert,
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
- (void)show;
- (void)showInContainer:(id)container;

/** reload the picker */
- (void)reloadData;

/** return previously selected item */
- (FAPickerItem*) selectedItem;

/** return previously selected item, in array of FAPickerItem form. */
- (NSMutableArray<FAPickerItem*>*)selectedItems;

/** set pre-selected items, items should be array of FAPickerItem. */
- (void)setSelectedItems:(NSMutableArray <FAPickerItem*> *)items;

/** return previously selected row, in array of NSNumber form. */
- (NSArray *)selectedRows;

/** set pre-selected rows, rows should be array of NSNumber. */
- (void)setSelectedRows: (NSArray *)rows;

/** unselect all rows */
- (void)unselectAll;

#pragma mark - block methods
-(void)showWithItems:(NSMutableArray<FAPickerItem *>*)items
        selectedItem:(FAPickerItem *)item
         HeaderTitle:(NSString *)headerTitle
   cancelButtonTitle:(NSString *)cancelButtonTitle
  confirmButtonTitle:(NSString *)confirmButtonTitle
              filter:(BOOL)filter
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel;

-(void)showWithItems:(NSMutableArray<FAPickerItem *>*)items
selectedItemWithTitle:(NSString *)title
         HeaderTitle:(NSString *)headerTitle
   cancelButtonTitle:(NSString *)cancelButtonTitle
  confirmButtonTitle:(NSString *)confirmButtonTitle
              filter:(BOOL)filter
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel;

-(void)showWithItems:(NSMutableArray<FAPickerItem *>*)items
       selectedItems:(NSMutableArray<FAPickerItem *>*)selectedItems
         HeaderTitle:(NSString *)headerTitle
   cancelButtonTitle:(NSString *)cancelButtonTitle
  confirmButtonTitle:(NSString *)confirmButtonTitle
              filter:(BOOL)filter
      WithCompletion:(completedWithItemsAtItems)complete cancel:(cancel)cancel;

-(void)showselectedDate:(NSDate *)date
            HeaderTitle:(NSString *)headerTitle
      cancelButtonTitle:(NSString *)cancelButtonTitle
     confirmButtonTitle:(NSString *)confirmButtonTitle
         WithCompletion:(completedWithDate)complete cancel:(cancel)cancel;

-(void)showselectedDate:(NSDate *)date
             DateFormat:(UIDatePickerMode)datePickerMode
            HeaderTitle:(NSString *)headerTitle
      cancelButtonTitle:(NSString *)cancelButtonTitle
     confirmButtonTitle:(NSString *)confirmButtonTitle
         WithCompletion:(completedWithDate)complete cancel:(cancel)cancel;

-(void)showWithItems:(NSMutableArray<FAPickerItem *>*)items
        selectedItem:(FAPickerItem *)item
         HeaderTitle:(NSString *)headerTitle
              filter:(BOOL)filter
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel;

-(void)showWithItems:(NSMutableArray<FAPickerItem *>*)items
selectedItemWithTitle:(NSString *)title
         HeaderTitle:(NSString *)headerTitle
              filter:(BOOL)filter
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel;

-(void)showWithHeaderTitle:(NSString *)headerTitle
                   Message:(NSString *)message
        confirmButtonTitle:(NSString *)confirmButtonTitle
            WithCompletion:(completedWithAlert)complete;

-(void)showWithHeaderTitle:(NSString *)headerTitle
                   Message:(NSString *)message
        confirmButtonTitle:(NSString *)confirmButtonTitle
         cancelButtonTitle:(NSString *)cancelButtonTitle
            WithCompletion:(completedWithAlert)complete;

-(void)showWithHeaderTitle:(NSString *)headerTitle
                   Message:(NSString *)message
        confirmButtonTitle:(NSString *)confirmButtonTitle
         cancelButtonTitle:(NSString *)cancelButtonTitle
          thirdButtonTitle:(NSString *)thirdButtonTitle
            WithCompletion:(completedWithAlert)complete;

#pragma mark - delegate

@property id<FAPickerViewDelegate> delegate;

@property id<FAPickerViewDataSource> dataSource;

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
@property BOOL Filter;

/** Defualt date */
@property NSDate *selectedDate;

/** selecteditem by title */
- (void)setSelectedItemByTitle:(NSString* )title;

/** Alert Message */
@property NSString *message;

#pragma mark - block value
@property completedWithItem completeWithItem;
@property completedWithDate completedWithDate;
@property completedWithItemsAtItems completedWithItemsAtItems;
@property completedWithAlert completeWithAlert;
@property cancel cancel;
@end

@interface FAPickerItem : NSObject

@property (nonatomic,retain) NSString* Id;
@property (nonatomic,retain) NSString* title;
@property (nonatomic,retain) UIImage* image;
@property (nonatomic) BOOL selected;

@end
