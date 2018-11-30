//
//  FAPickerView.h
//
//  Created by Fadi Abuzant on 3/4/18.
//  Copyright © 2018 fadizant. All rights reserved.
//

#import "FAPickerView.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define mainFAPickerColor [UIColor colorWithRed:0.000 green:0.357 blue:0.675 alpha:1.00]
#define selectFAPickerColor [UIColor colorWithRed:0.000 green:0.357 blue:0.675 alpha:0.50]

#define FA_FOOTER_HEIGHT 44.0
#define FA_HEADER_HEIGHT 44.0
#define FA_BACKGROUND_ALPHA 0.9

typedef void (^CompletionCallback)(void);

@interface FAPickerView ()
    @property NSString *headerTitle;
    @property NSString *cancelButtonTitle;
    @property NSString *confirmButtonTitle;
    @property NSString *ThirdButtonTitle;
    @property UIView *backgroundDimmingView;
    @property UIView *containerView;
    @property UIView *headerView;
    @property UIView *footerview;
    @property UITableView *tableView;
//    @property NSMutableArray *selectedIndexPaths;
    @property CGRect previousBounds;
    @property UIDatePicker *datePicker;
    @property UIView *alertBody;
    @property UITextField *searchTextField;
    @property NSMutableArray <FAPickerItem*> *filterItem;
    @property NSMutableString *searchText;
    @property UILabel *dayLabel;
    @property UIDatePickerMode datePickerMode;
    @property NSDate* minimumDate;
    @property NSDate* maximumDate;
    @property UIView *colorPickerView;
    @property UIView *customViewContainer;
    @property UIView *customPickerViewContainer;
    //@property UIScrollView *customViewContainer;
    //@property UIScrollView *customPickerViewContainer;
    @end

@implementation FAPickerView
    
    static UIColor *mainColor;
    static UIColor *selectedColor;
    static NSString *dateTimeLocalized;
    
+(UIColor*)mainColor{return mainColor;}
+(void)setMainColor:(UIColor*)color
    {
        mainColor = color;
        selectedColor = [color colorWithAlphaComponent:0.5];
    }
    
+(void)setDateTimeLocalized:(NSString*)localized{dateTimeLocalized = localized;}
    
- (id)initWithType:(FAPickerType)pickerType
       HeaderTitle:(NSString *)headerTitle
 cancelButtonTitle:(NSString *)cancelButtonTitle
confirmButtonTitle:(NSString *)confirmButtonTitle{
    self = [super init];
    if(self){
        if([self needHandleOrientation]){
            [[NSNotificationCenter defaultCenter] addObserver: self
                                                     selector:@selector(deviceOrientationDidChange:)
                                                         name:UIDeviceOrientationDidChangeNotification
                                                       object: nil];
        }
        self.pickerType = pickerType;
        self.selectedDate = [NSDate date];
        self.tapBackgroundToDismiss = YES;
        self.needFooterView = NO;
        self.allowMultipleSelection = NO;
        self.animationDuration = 0.5f;
        self.confirmButtonTitle = confirmButtonTitle;
        self.cancelButtonTitle = cancelButtonTitle;
        
        self.headerTitle = headerTitle ? headerTitle : @"";
        //check if color is dark or light
        const CGFloat *component = CGColorGetComponents(mainColor ? mainColor.CGColor : mainFAPickerColor.CGColor);
        CGFloat brightness = ((component[0] * 299) + (component[1] * 587) + (component[2] * 114)) / 1000;
        
        self.headerTitleColor = (brightness < 0.75) ? [UIColor whiteColor] : [UIColor blackColor];
        
        //        self.headerTitleColor = [UIColor whiteColor];
        self.headerBackgroundColor = mainColor ? mainColor : mainFAPickerColor;//[UIColor colorWithRed:56.0/255 green:185.0/255 blue:158.0/255 alpha:1];
        
        self.cancelButtonNormalColor = mainColor ? mainColor : mainFAPickerColor;//[UIColor colorWithRed:59.0/255 green:72/255.0 blue:5.0/255 alpha:1];
        self.cancelButtonHighlightedColor = selectedColor ? selectedColor : selectFAPickerColor;//[UIColor grayColor];
        self.cancelButtonBackgroundColor = [UIColor colorWithRed:236.0/255 green:240/255.0 blue:241.0/255 alpha:1];
        
        //check if color is dark or light
        self.confirmButtonNormalColor = (brightness < 0.75) ? [UIColor whiteColor] : [UIColor blackColor];
        
        //        self.confirmButtonNormalColor = [UIColor whiteColor];
        self.confirmButtonHighlightedColor = [UIColor colorWithRed:236.0/255 green:240/255.0 blue:241.0/255 alpha:1];
        self.confirmButtonBackgroundColor = mainColor ? mainColor : mainFAPickerColor;//[UIColor colorWithRed:56.0/255 green:185.0/255 blue:158.0/255 alpha:1];
        
        self.checkmarkColor = mainColor ? mainColor : mainFAPickerColor;//[UIColor colorWithRed:56.0/255 green:185.0/255 blue:158.0/255 alpha:1];
        
        
        _previousBounds = [UIScreen mainScreen].bounds;
        self.frame = _previousBounds;
    }
    return self;
}
    
- (void)setupSubviews{
    if(!self.backgroundDimmingView){
        self.backgroundDimmingView = [self buildBackgroundDimmingView];
        [self addSubview:self.backgroundDimmingView];
    }
    
    self.containerView = [self buildContainerView];
    [self addSubview:self.containerView];
    
    switch (_pickerType) {
        case FAPickerTypeItems:
        self.tableView = [self buildTableView];
        [self.containerView addSubview:self.tableView];
        break;
        case FAPickerTypeDate:
        {
            self.datePicker = [self buildDatePicker];
            [self.containerView addSubview:self.datePicker];
            if (_datePickerMode == UIDatePickerModeDate) {
                //add day name
                _dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,
                                                                     self.datePicker.frame.size.height + self.datePicker.frame.origin.y,
                                                                     self.datePicker.frame.size.width,
                                                                     35)];
                _dayLabel.textColor = mainColor ? mainColor : mainFAPickerColor;
                _dayLabel.backgroundColor = [UIColor whiteColor];
                _dayLabel.textAlignment = NSTextAlignmentCenter;
                _dayLabel.font = [UIFont systemFontOfSize:20];
                
                NSDateFormatter *weekDay = [[NSDateFormatter alloc] init];
                if (dateTimeLocalized && ![dateTimeLocalized isEqualToString:@""]) {
                    weekDay.locale = [[NSLocale alloc] initWithLocaleIdentifier:dateTimeLocalized];
                }
                [weekDay setDateFormat:@"EEEE"];
                
                _dayLabel.text = [weekDay stringFromDate:_selectedDate];
                
                [self.containerView addSubview:_dayLabel];
            }
        }
        break;
        case FAPickerTypeAlert:
        self.alertBody = [self buildAlert];
        [self.containerView addSubview:self.alertBody];
        break;
        case FAPickerTypeColor:
        self.colorPickerView = [self buildColorPicker];
        [self.containerView addSubview:self.colorPickerView];
        break;
        case FAPickerTypeCustomView:
        self.customViewContainer = [self buildCustomViewContainer];
        [self.containerView addSubview:self.customViewContainer];
        break;
        case FAPickerTypeCustomPicker:
        self.customPickerViewContainer = [self buildCustomPickerViewContainer];
        [self.containerView addSubview:self.customPickerViewContainer];
        break;
        default:
        break;
    }
    
    
    self.headerView = [self buildHeaderView];
    [self.containerView addSubview:self.headerView];
    
    if (_Filter) {
        self.searchTextField = [self buildSearchView];
        [self.containerView addSubview:self.searchTextField];
    }
    
    
    self.footerview = [self buildFooterView];
    [self.containerView addSubview:self.footerview];
    
    CGRect frame = self.containerView.frame;
    
    
    switch (_pickerType) {
        case FAPickerTypeItems:
        self.containerView.frame = CGRectMake(frame.origin.x,
                                              frame.origin.y,
                                              frame.size.width,
                                              self.headerView.frame.size.height + self.tableView.frame.size.height + self.footerview.frame.size.height + (_Filter ? self.searchTextField.frame.size.height : 0));
        break;
        case FAPickerTypeDate:
        self.containerView.frame = CGRectMake(frame.origin.x,
                                              frame.origin.y,
                                              frame.size.width,
                                              self.headerView.frame.size.height + self.datePicker.frame.size.height + self.footerview.frame.size.height+ (_Filter ? self.searchTextField.frame.size.height : 0) + (_datePickerMode == UIDatePickerModeDate ? _dayLabel.frame.size.height : 0));
        break;
        case FAPickerTypeAlert:
        self.containerView.frame = CGRectMake(frame.origin.x,
                                              frame.origin.y,
                                              frame.size.width,
                                              self.headerView.frame.size.height + self.alertBody.frame.size.height + self.footerview.frame.size.height+ (_Filter ? self.searchTextField.frame.size.height : 0));
        break;
        case FAPickerTypeColor:
        self.containerView.frame = CGRectMake(frame.origin.x,
                                              frame.origin.y,
                                              frame.size.width,
                                              self.headerView.frame.size.height + self.colorPickerView.frame.size.height + self.footerview.frame.size.height+ (_Filter ? self.searchTextField.frame.size.height : 0));
        [self changeHeaderAndFooterColors:self.selectedColorPicker];
        break;
        case FAPickerTypeCustomView:
        self.containerView.frame = CGRectMake(frame.origin.x,
                                              frame.origin.y,
                                              frame.size.width,
                                              self.headerView.frame.size.height + self.customViewContainer.frame.size.height + self.footerview.frame.size.height+ (_Filter ? self.searchTextField.frame.size.height : 0));
        break;
        case FAPickerTypeCustomPicker:
        self.containerView.frame = CGRectMake(frame.origin.x,
                                              frame.origin.y,
                                              frame.size.width,
                                              self.customPickerViewContainer.frame.size.height);
        break;
        default:
        break;
    }
    self.containerView.center = CGPointMake(self.center.x, self.center.y + self.frame.size.height);
    
}
    
- (void)performContainerAnimation {
    
    [UIView animateWithDuration:self.animationDuration delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:3.0f options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        self.containerView.center = self.center;
    } completion:^(BOOL finished) {
    }];
}
    
- (void)show {
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    self.frame = mainWindow.frame;
    [self showInContainer:mainWindow];
}
    
- (void)showInContainer:(id)container {
    
    if (self.allowMultipleSelection && !self.needFooterView) {
        self.needFooterView = self.allowMultipleSelection;
    }
    
    if ([container respondsToSelector:@selector(addSubview:)]) {
        [container addSubview:self];
        
        [self setupSubviews];
        [self performContainerAnimation];
        
        [UIView animateWithDuration:self.animationDuration animations:^{
            self.backgroundDimmingView.alpha = FA_BACKGROUND_ALPHA;
        }];
    }
}
    
- (void)reloadData{
    [self.tableView reloadData];
}
    
- (void)dismissPicker:(CompletionCallback)completion{
    
    [UIView animateWithDuration:self.animationDuration delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:3.0f options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        self.containerView.center = CGPointMake(self.center.x, self.center.y + self.frame.size.height);
    }completion:^(BOOL finished) {
    }];
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.backgroundDimmingView.alpha = 0.0;
    } completion:^(BOOL finished) {
        if(finished){
            if(completion){
                completion();
            }
            [self removeFromSuperview];
        }
    }];
}
    
-(void) changeHeaderAndFooterColors:(UIColor*)color{
    self.headerView.backgroundColor = color;
    //check if color is dark or light
    const CGFloat *component = CGColorGetComponents(color.CGColor);
    CGFloat brightness = ((component[0] * 299) + (component[1] * 587) + (component[2] * 114)) / 1000;
    
    ((UILabel*)[self.headerView viewWithTag:100]).textColor = (brightness < 0.75) ? [UIColor whiteColor] : [UIColor blackColor];
    
    [((UIButton*)[self.footerview viewWithTag:100]) setTitleColor: (brightness < 0.75) ? color : [UIColor blackColor] forState:UIControlStateNormal];
    [((UIButton*)[self.footerview viewWithTag:100]) setTitleColor: (brightness < 0.75) ? [color colorWithAlphaComponent:0.5] : [UIColor blackColor] forState:UIControlStateHighlighted];
    
    [((UIButton*)[self.footerview viewWithTag:200]) setTitleColor:(brightness < 0.75) ? [UIColor whiteColor] : [UIColor blackColor] forState:UIControlStateNormal];
    [((UIButton*)[self.footerview viewWithTag:200]) setTitleColor:(brightness < 0.75) ? [UIColor whiteColor] : [UIColor blackColor] forState:UIControlStateHighlighted];
    ((UIButton*)[self.footerview viewWithTag:200]).backgroundColor = color;
}
    
#pragma mark- Build Views
- (UIView *)buildContainerView {
    CGFloat widthRatio = _pickerWidth ? _pickerWidth / [UIScreen mainScreen].bounds.size.width : 0.8;
    CGAffineTransform transform = CGAffineTransformMake(widthRatio, 0, 0, 0.8, 0, 0);
    CGRect newRect = CGRectApplyAffineTransform(self.frame, transform);
    UIView *cv = [[UIView alloc] initWithFrame:newRect];
    cv.layer.cornerRadius = 6.0f;
    cv.clipsToBounds = YES;
    cv.center = CGPointMake(self.center.x, self.center.y + self.frame.size.height);
    return cv;
}
    
- (UITableView *)buildTableView{
    CGFloat widthRatio = _pickerWidth ? _pickerWidth / [UIScreen mainScreen].bounds.size.width : 0.8;
    CGAffineTransform transform = CGAffineTransformMake(widthRatio, 0, 0, 0.8, 0, 0);
    CGRect newRect = CGRectApplyAffineTransform(self.frame, transform);
    NSInteger n = _items ? _items.count : 0;
    if (_sections) {
        for (FAPickerSection *section in _sections) {
            n += section.items ? section.items.count : 0;
        }
        
    }
    CGRect tableRect;
    float heightOffset = (_Filter ? 35 + FA_HEADER_HEIGHT : FA_HEADER_HEIGHT) + FA_FOOTER_HEIGHT;
    if(n > 0){
        float height = n * 44.0;
        height += _sections ? (_sections.count * 28) : 0;
        height = height > newRect.size.height - heightOffset ? newRect.size.height -heightOffset : height;
        tableRect = CGRectMake(0, (_Filter ? 35 + FA_HEADER_HEIGHT : FA_HEADER_HEIGHT), newRect.size.width, height);
    } else {
        tableRect = CGRectMake(0, (_Filter ? 35 + FA_HEADER_HEIGHT : FA_HEADER_HEIGHT), newRect.size.width, newRect.size.height - heightOffset);
    }
    UITableView *tableView = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //scroll to selected cell after animation
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            // update in main thread
            if (self->_sections) {
                for (FAPickerSection* section in self->_sections.reverseObjectEnumerator) {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"selected == %i", YES];
                    NSArray *filteredArray = [section.items filteredArrayUsingPredicate:predicate];
                    if (filteredArray.count) {
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[section.items indexOfObject:filteredArray.firstObject]
                                                                    inSection:[self->_sections indexOfObject:section]];
                        [tableView scrollToRowAtIndexPath:indexPath
                                         atScrollPosition:UITableViewScrollPositionNone animated:YES];
                        break;
                    }
                }
            } else {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"selected == %i", YES];
                NSArray *filteredArray = [self->_items filteredArrayUsingPredicate:predicate];
                
                if (filteredArray.count) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self->_items indexOfObject:filteredArray.firstObject]
                                                                inSection:0];
                    [tableView scrollToRowAtIndexPath:indexPath
                                     atScrollPosition:UITableViewScrollPositionNone animated:YES];
                }
            }
        });
        
    });
    
    return tableView;
}
    
- (UIDatePicker *)buildDatePicker{
    CGFloat widthRatio = _pickerWidth ? _pickerWidth / [UIScreen mainScreen].bounds.size.width : 0.8;
    CGAffineTransform transform = CGAffineTransformMake(widthRatio, 0, 0, 0.8, 0, 0);
    CGRect newRect = CGRectApplyAffineTransform(self.frame, transform);
    CGRect tableRect;
    float heightOffset = FA_HEADER_HEIGHT + FA_FOOTER_HEIGHT;
    float height = 162;
    height = height > newRect.size.height - heightOffset ? newRect.size.height -heightOffset : height;
    tableRect = CGRectMake(0, 44.0, newRect.size.width, height);
    
    UIDatePicker *datepicker = [[UIDatePicker alloc] initWithFrame:tableRect];
    datepicker.tintColor = mainColor ? mainColor : mainFAPickerColor;
    [datepicker setValue:mainColor ? mainColor : mainFAPickerColor forKey:@"textColor"];
    datepicker.backgroundColor = [UIColor whiteColor];
    datepicker.datePickerMode = UIDatePickerModeDate;
    datepicker.date = _selectedDate;
    datepicker.datePickerMode = _datePickerMode;
    
    if (_minimumDate)
    [datepicker setMinimumDate:_minimumDate];
    if (_maximumDate)
    [datepicker setMaximumDate:_maximumDate];
    
    
    
    [datepicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    
    if (dateTimeLocalized && ![dateTimeLocalized isEqualToString:@""]) {
        datepicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:dateTimeLocalized];
    }
    
    return datepicker;
}
    
- (UIView *)buildColorPicker{
    CGFloat widthRatio = _pickerWidth ? _pickerWidth / [UIScreen mainScreen].bounds.size.width : 0.8;
    CGAffineTransform transform = CGAffineTransformMake(widthRatio, 0, 0, 0.8, 0, 0);
    CGRect newRect = CGRectApplyAffineTransform(self.frame, transform);
    CGRect tableRect;
    float heightOffset = FA_HEADER_HEIGHT + FA_FOOTER_HEIGHT;
    float height = ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft ||
                    [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) ? 180 : 260;
    height = height > newRect.size.height - heightOffset ? newRect.size.height -heightOffset : height;
    tableRect = CGRectMake(0, 44.0, newRect.size.width, height);
    
    UIView *view = [[UIView alloc]initWithFrame:tableRect];
    view.backgroundColor = UIColor.whiteColor;
    CGRect frame = CGRectMake(10, 10, newRect.size.width - 20, height - 20);
    self.wheelView = [[FAColorPickerWheelView alloc] initWithFrame:frame];
    if (self.selectedColorPicker)
    self.wheelView.color = self.selectedColorPicker;
    self.wheelView.hideColorInfo = YES;
    [view addSubview:self.wheelView];
    
    __weak FAPickerView *weakSelf = self;
    self.wheelView.colorChangedBlock = ^(UIColor *color) {
        weakSelf.selectedColorPicker = color;
        
        [weakSelf changeHeaderAndFooterColors:color];
    };
    
    return view;
}
    
- (UIView *)buildCustomViewContainer{
    
    float getHeight = _customContainerViewHeight;
    if (!getHeight) {
        for (UIView* view in _customView.view.subviews) {
            getHeight = getHeight < (view.frame.origin.y + view.frame.size.height) ? (view.frame.origin.y + view.frame.size.height) : getHeight ;
        }
        _customContainerViewHeight = getHeight;
    }
    if (!_customViewHeight){
        _customViewHeight = _customContainerViewHeight;
    }
    
    CGFloat widthRatio = _pickerWidth ? _pickerWidth / [UIScreen mainScreen].bounds.size.width : 0.8;
    CGAffineTransform transform = CGAffineTransformMake(widthRatio, 0, 0, 0.8, 0, 0);
    CGRect newRect = CGRectApplyAffineTransform(self.frame, transform);
    CGRect tableRect;
    float heightOffset = FA_HEADER_HEIGHT + FA_FOOTER_HEIGHT;
    float bottomPadding = _customViewBottomPadding ? _customViewBottomPadding : 10;
    float height = _customViewHeight + bottomPadding;
    height = height > newRect.size.height - heightOffset ? newRect.size.height -heightOffset : height;
    tableRect = CGRectMake(0, 44.0, newRect.size.width, height);
    CGRect customRect = CGRectMake(0, 0, newRect.size.width, (height > getHeight + bottomPadding) ? height : (getHeight + bottomPadding)  ) ;
    
    UIView *view = [[UIView alloc]initWithFrame:tableRect];
    //    UIScrollView *view = [[UIScrollView alloc]initWithFrame:tableRect];
    _customView.view.clipsToBounds = YES;
    _customView.view.frame = customRect;
    [view addSubview:_customView.view];
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    [_customView didMoveToParentViewController:mainWindow.rootViewController];
    //    view.bounces = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        float getHeight = 0;
        for (UIView* view in self->_customView.view.subviews) {
            getHeight = getHeight < (view.frame.origin.y + view.frame.size.height) ? (view.frame.origin.y + view.frame.size.height) : getHeight ;
        }
        //        self.customViewContainer.contentSize = CGSizeMake(newRect.size.width, getHeight);
        self->_customView.view.frame = customRect;
    });
    
    return view;
}
    
- (UIView *)buildCustomPickerViewContainer{
    
    float getHeight = _customContainerViewHeight;
    if (!getHeight) {
        for (UIView* view in _customView.view.subviews) {
            getHeight = getHeight < (view.frame.origin.y + view.frame.size.height) ? (view.frame.origin.y + view.frame.size.height) : getHeight ;
        }
        _customContainerViewHeight = getHeight;
    }
    if (!_customViewHeight){
        _customViewHeight = _customContainerViewHeight;
    }
    
    CGFloat widthRatio = _pickerWidth ? _pickerWidth / [UIScreen mainScreen].bounds.size.width : 0.8;
    CGAffineTransform transform = CGAffineTransformMake(widthRatio, 0, 0, 0.8, 0, 0);
    CGRect newRect = CGRectApplyAffineTransform(self.frame, transform);
    CGRect tableRect;
    float heightOffset = 0;
    float bottomPadding = _customViewBottomPadding ? _customViewBottomPadding : 10;
    float height = _customViewHeight + bottomPadding;
    height = height > newRect.size.height - heightOffset ? newRect.size.height -heightOffset : height;
    tableRect = CGRectMake(0, 0, newRect.size.width, height);
    CGRect customRect = CGRectMake(0, 0, newRect.size.width, (height > getHeight + bottomPadding) ? height : (getHeight + bottomPadding));
    
    UIView *view = [[UIView alloc]initWithFrame:tableRect];
    //    UIScrollView *view = [[UIScrollView alloc]initWithFrame:tableRect];
    _customView.view.clipsToBounds = YES;
    _customView.view.frame = customRect;
    [view addSubview:_customView.view];
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    [_customView didMoveToParentViewController:mainWindow.rootViewController];
    //    view.bounces = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        float getHeight = 0;
        for (UIView* view in self->_customView.view.subviews) {
            getHeight = getHeight < (view.frame.origin.y + view.frame.size.height) ? (view.frame.origin.y + view.frame.size.height) : getHeight ;
        }
        //        self.customPickerViewContainer.contentSize = CGSizeMake(newRect.size.width, getHeight);
    });
    
    return view;
}
    
    
- (UIView *)buildAlert{
    CGFloat widthRatio = _pickerWidth ? _pickerWidth / [UIScreen mainScreen].bounds.size.width : 0.8;
    CGAffineTransform transform = CGAffineTransformMake(widthRatio, 0, 0, 0.8, 0, 0);
    CGRect newRect = CGRectApplyAffineTransform(self.frame, transform);
    CGRect tableRect;
    //    float heightOffset = FA_HEADER_HEIGHT + FA_FOOTER_HEIGHT;
    
    //get height from string
    CGSize constrainedSize = CGSizeMake(newRect.size.width - 10 , 9999);
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont systemFontOfSize:16.0], NSFontAttributeName,
                                          nil];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:_message attributes:attributesDictionary];
    
    CGRect requiredHeight = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    float height = requiredHeight.size.height + 10;
    height = height < FA_HEADER_HEIGHT * 2 ? FA_HEADER_HEIGHT * 2 : height;
    tableRect = CGRectMake(5, 0, newRect.size.width-10, height);
    
    UILabel *body = [[UILabel alloc] initWithFrame:tableRect];
    body.textColor = mainColor ? mainColor : mainFAPickerColor;
    body.backgroundColor = [UIColor whiteColor];
    body.textAlignment = NSTextAlignmentCenter;
    body.text = _message;
    body.numberOfLines = 0;
    body.font = [UIFont systemFontOfSize:16];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 44.0, newRect.size.width, height)];
    view.backgroundColor = [UIColor whiteColor];
    [view addSubview:body];
    return view;
}
    
    
- (UIView *)buildBackgroundDimmingView{
    
    UIView *bgView;
    //blur effect for iOS8
    CGFloat frameHeight = self.frame.size.height;
    CGFloat frameWidth = self.frame.size.width;
    CGFloat sideLength = frameHeight > frameWidth ? frameHeight : frameWidth;
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
        UIBlurEffect *eff = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        bgView = [[UIVisualEffectView alloc] initWithEffect:eff];
        bgView.frame = CGRectMake(0, 0, sideLength, sideLength);
    }
    else {
        bgView = [[UIView alloc] initWithFrame:self.frame];
        bgView.backgroundColor = [UIColor blackColor];
    }
    bgView.alpha = 0.0;
    if(self.tapBackgroundToDismiss){
        [bgView addGestureRecognizer:
         [[UITapGestureRecognizer alloc] initWithTarget:self
                                                 action:@selector(cancelButtonPressed:)]];
    }
    return bgView;
}
    
- (UIView *)buildFooterView{
    if (!self.needFooterView){
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    CGRect rect;//= self.tableView.frame;
    BOOL isAlert = NO;
    switch (_pickerType) {
        case FAPickerTypeItems:
        rect = self.tableView.frame;
        break;
        case FAPickerTypeDate:
        rect = self.datePicker.frame;
        rect.size.height += _datePickerMode == UIDatePickerModeDate ? _dayLabel.frame.size.height : 0;
        break;
        case FAPickerTypeAlert:
        rect = self.alertBody.frame;
        isAlert= YES;
        break;
        case FAPickerTypeColor:
        rect = self.colorPickerView.frame;
        break;
        case FAPickerTypeCustomView:
        rect = self.customViewContainer.frame;
        isAlert= YES;
        break;
        case FAPickerTypeCustomPicker:
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        break;
        default:
        break;
    }
    
    if (!isAlert) {
        CGRect newRect = CGRectMake(0,
                                    rect.origin.y + rect.size.height,
                                    rect.size.width,
                                    FA_FOOTER_HEIGHT);
        CGRect leftRect = CGRectMake(0,0, newRect.size.width /2, FA_FOOTER_HEIGHT);
        CGRect rightRect = CGRectMake(newRect.size.width /2,0, newRect.size.width /2, FA_FOOTER_HEIGHT);
        
        UIView *view = [[UIView alloc] initWithFrame:newRect];
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:leftRect];
        [cancelButton setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
        [cancelButton setTitleColor: self.cancelButtonNormalColor forState:UIControlStateNormal];
        [cancelButton setTitleColor:self.cancelButtonHighlightedColor forState:UIControlStateHighlighted];
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        cancelButton.backgroundColor = self.cancelButtonBackgroundColor;
        [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.tag = 100;
        [view addSubview:cancelButton];
        
        UIButton *confirmButton = [[UIButton alloc] initWithFrame:rightRect];
        [confirmButton setTitle:self.confirmButtonTitle forState:UIControlStateNormal];
        [confirmButton setTitleColor:self.confirmButtonNormalColor forState:UIControlStateNormal];
        [confirmButton setTitleColor:self.confirmButtonHighlightedColor forState:UIControlStateHighlighted];
        confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
        confirmButton.backgroundColor = self.confirmButtonBackgroundColor;
        [confirmButton addTarget:self action:@selector(confirmButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        confirmButton.tag = 200;
        [view addSubview:confirmButton];
        return view;
    } else {
        int numberOfButtons = 0;
        numberOfButtons += ![_confirmButtonTitle isEqualToString:@""] ? 1 : 0;
        numberOfButtons += ![_cancelButtonTitle isEqualToString:@""] ? 1 : 0;
        numberOfButtons += ![_ThirdButtonTitle isEqualToString:@""] ? 1 : 0;
        
        CGRect newRect = CGRectMake(0,
                                    rect.origin.y + rect.size.height,
                                    rect.size.width,
                                    numberOfButtons > 2 ? FA_FOOTER_HEIGHT * 2: FA_FOOTER_HEIGHT);
        CGRect leftRect = CGRectMake(0,0, newRect.size.width /2, FA_FOOTER_HEIGHT);
        CGRect rightRect = CGRectMake(newRect.size.width /2,0, newRect.size.width /2, FA_FOOTER_HEIGHT);
        CGRect bottom = CGRectMake(0,FA_FOOTER_HEIGHT, newRect.size.width , FA_FOOTER_HEIGHT);
        CGRect fill = CGRectMake(0,0, newRect.size.width , FA_FOOTER_HEIGHT);
        CGRect spliter = CGRectMake(newRect.size.width /2,0, 1 , FA_FOOTER_HEIGHT);
        
        UIView *view = [[UIView alloc] initWithFrame:newRect];
        
        switch (numberOfButtons) {
            case 1:
            {
                UIButton *confirmButton = [[UIButton alloc] initWithFrame:fill];
                [confirmButton setTitle:self.confirmButtonTitle forState:UIControlStateNormal];
                [confirmButton setTitleColor:self.cancelButtonNormalColor forState:UIControlStateNormal];
                [confirmButton setTitleColor:self.cancelButtonHighlightedColor forState:UIControlStateHighlighted];
                confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
                confirmButton.backgroundColor = self.cancelButtonBackgroundColor;
                [confirmButton addTarget:self action:@selector(confirmButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:confirmButton];
            }
            break;
            case 2:
            {
                UIButton *cancelButton = [[UIButton alloc] initWithFrame:leftRect];
                [cancelButton setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
                [cancelButton setTitleColor: self.cancelButtonNormalColor forState:UIControlStateNormal];
                [cancelButton setTitleColor:self.cancelButtonHighlightedColor forState:UIControlStateHighlighted];
                cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
                cancelButton.backgroundColor = self.cancelButtonBackgroundColor;
                [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:cancelButton];
                
                UIButton *confirmButton = [[UIButton alloc] initWithFrame:rightRect];
                [confirmButton setTitle:self.confirmButtonTitle forState:UIControlStateNormal];
                [confirmButton setTitleColor:self.confirmButtonNormalColor forState:UIControlStateNormal];
                [confirmButton setTitleColor:self.confirmButtonHighlightedColor forState:UIControlStateHighlighted];
                confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
                confirmButton.backgroundColor = self.confirmButtonBackgroundColor;
                [confirmButton addTarget:self action:@selector(confirmButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:confirmButton];
            }
            break;
            case 3:
            {
                UIButton *cancelButton = [[UIButton alloc] initWithFrame:leftRect];
                [cancelButton setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
                [cancelButton setTitleColor: self.confirmButtonNormalColor forState:UIControlStateNormal];
                [cancelButton setTitleColor:self.confirmButtonHighlightedColor forState:UIControlStateHighlighted];
                cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
                cancelButton.backgroundColor = self.confirmButtonBackgroundColor;
                [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:cancelButton];
                
                UIButton *confirmButton = [[UIButton alloc] initWithFrame:rightRect];
                [confirmButton setTitle:self.confirmButtonTitle forState:UIControlStateNormal];
                [confirmButton setTitleColor:self.confirmButtonNormalColor forState:UIControlStateNormal];
                [confirmButton setTitleColor:self.confirmButtonHighlightedColor forState:UIControlStateHighlighted];
                confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
                confirmButton.backgroundColor = self.confirmButtonBackgroundColor;
                [confirmButton addTarget:self action:@selector(confirmButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:confirmButton];
                
                UIButton *ThirdButton = [[UIButton alloc] initWithFrame:bottom];
                [ThirdButton setTitle:self.ThirdButtonTitle forState:UIControlStateNormal];
                [ThirdButton setTitleColor: self.cancelButtonNormalColor forState:UIControlStateNormal];
                [ThirdButton setTitleColor:self.cancelButtonHighlightedColor forState:UIControlStateHighlighted];
                ThirdButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
                ThirdButton.backgroundColor = self.cancelButtonBackgroundColor;
                [ThirdButton addTarget:self action:@selector(thirdButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:ThirdButton];
                
                UIView *Spliter = [[UIView alloc]initWithFrame:spliter];
                Spliter.backgroundColor = self.cancelButtonBackgroundColor;
                [view addSubview:Spliter];
            }
            break;
            default:
            break;
        }
        return view;
    }
    
}
    
- (UIView *)buildHeaderView{
    UIView *view ;//= [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, FA_HEADER_HEIGHT)];
    
    switch (_pickerType) {
        case FAPickerTypeItems:
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width,  FA_HEADER_HEIGHT)];
        break;
        case FAPickerTypeDate:
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.datePicker.frame.size.width, FA_HEADER_HEIGHT)];
        break;
        case FAPickerTypeAlert:
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.alertBody.frame.size.width, FA_HEADER_HEIGHT)];
        break;
        case FAPickerTypeColor:
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.colorPickerView.frame.size.width, FA_HEADER_HEIGHT)];
        break;
        case FAPickerTypeCustomView:
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.customViewContainer.frame.size.width, FA_HEADER_HEIGHT)];
        break;
        case FAPickerTypeCustomPicker:
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        break;
        default:
        break;
    }
    
    
    view.backgroundColor = self.headerBackgroundColor;
    
    UIFont *headerFont = self.headerTitleFont == nil ? [UIFont systemFontOfSize:18.0] : self.headerTitleFont;
    
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName: self.headerTitleColor,
                           NSFontAttributeName:headerFont
                           };
    NSAttributedString *at = [[NSAttributedString alloc] initWithString:self.headerTitle attributes:dict];
    UILabel *label = [[UILabel alloc] initWithFrame:view.frame];
    label.attributedText = at;
    [label sizeToFit];
    label.tag = 100;
    [view addSubview:label];
    label.center = view.center;
    
    
    return view;
}
    
-(UITextField*)buildSearchView
    {
        UITextField *search = [[UITextField alloc] initWithFrame:CGRectMake(0, FA_HEADER_HEIGHT, self.tableView.frame.size.width,  35)];
        search.backgroundColor = [UIColor colorWithRed:236.0/255 green:240/255.0 blue:241.0/255 alpha:1];
        search.placeholder = NSLocalizedString(@"Search", @"");
        search.font = [UIFont systemFontOfSize:16];
        search.textColor = mainColor ? mainColor : mainFAPickerColor;
        search.tintColor = mainColor ? mainColor : mainFAPickerColor;
        search.returnKeyType = UIReturnKeyDone;
        search.delegate = self;
        search.clearButtonMode = UITextFieldViewModeWhileEditing;
        search.text = _searchText;
        if ([search respondsToSelector:@selector(setAttributedPlaceholder:)]) {
            search.attributedPlaceholder = [[NSAttributedString alloc] initWithString:search.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
        }
        
        //left margin
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 14, 35)];
        search.leftView = paddingView;
        search.leftViewMode = UITextFieldViewModeAlways;
        
        //bottom border
        UIView *border =  [[UIView alloc] initWithFrame:CGRectMake(0, 34, self.tableView.frame.size.width, 1)];
        border.backgroundColor =mainColor ? mainColor : mainFAPickerColor ;
        [search addSubview:border];
        
        
        return search;
    }
#pragma mark - Static
    
+(FAPickerView*)picker
    {
        return [FAPickerView new];
    }
    
+(FAPickerView*)currentPicker
    {
        
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        for (UIView *picker in mainWindow.subviews) {
            if ([picker isKindOfClass:[FAPickerView class]]) {
                return (FAPickerView*)picker;
            }
        }
        return [FAPickerView new];
    }
    
#pragma mark Close
+(void)ClosePicker{
    [[self currentPicker] dismissPicker:nil];
}
    
#pragma mark - textfield delegat
    
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
    {
        _searchText = [NSMutableString stringWithString:textField.text];
        [_searchText replaceCharactersInRange:range withString:string];
        if (_searchText && ![_searchText isEqualToString:@""]) {
            NSPredicate *firstNamePredicate = [NSPredicate predicateWithFormat:@"self.title CONTAINS[cd]%@",_searchText];
            
            self.filterItem = [[NSMutableArray alloc]initWithArray:[_items filteredArrayUsingPredicate:firstNamePredicate]];
        } else {
            self.filterItem = nil;
        }
        
        [self.tableView reloadData];
        
        return YES;
    }
- (BOOL)textFieldShouldClear:(UITextField *)textField
    {
        _searchText = [NSMutableString new
                       ];
        self.filterItem = nil;
        [self.tableView reloadData];
        return YES;
    }
    
- (BOOL)textFieldShouldReturn:(UITextField *)textField
    {
        [textField endEditing:YES];
        return YES;
    }
    
#pragma mark - picker buttons
- (IBAction)cancelButtonPressed:(id)sender{
    if (_searchTextField && [_searchTextField isFirstResponder] && [sender isKindOfClass:[UITapGestureRecognizer class]]) {
        [_searchTextField endEditing:YES];
        return;
    }
    
    if (_pickerType == FAPickerTypeAlert && [sender isKindOfClass:[UITapGestureRecognizer class]]) {
        return;
    }
    
    if (_pickerType == FAPickerTypeColor && [sender isKindOfClass:[UITapGestureRecognizer class]]) {
        return;
    }
    
    if (_pickerType == FAPickerTypeCustomView && [sender isKindOfClass:[UITapGestureRecognizer class]]) {
        return;
    }
    
    [self dismissPicker:^{
    }];
    if (_cancel) {
        _cancel();
    }
    
    if (_completeWithAlert) {
        _completeWithAlert(FAPickerAlertButtonCancel);
    }
    
    if (_completedWithCustomView) {
        _completedWithCustomView(FAPickerCustomViewButtonCancel);
    }
}
    
- (IBAction)confirmButtonPressed:(id)sender{
    [self dismissPicker:^{
        
        switch (self->_pickerType) {
            case FAPickerTypeItems:
            {
                if (self->_completeWithItem) {
                    self->_completeWithItem(self.selectedItem);
                }
                
                if (self->_completedWithItemsAtItems) {
                    self->_completedWithItemsAtItems(self.selectedItems);
                }
            }
            break;
            case FAPickerTypeDate:
            {
                if (self->_completedWithDate) {
                    self->_completedWithDate(self->_selectedDate);
                }
            }
            break;
            case FAPickerTypeAlert:
            {
                if (self->_completeWithAlert) {
                    self->_completeWithAlert(FAPickerAlertButtonConfirm);
                }
            }
            break;
            case FAPickerTypeColor:
            {
                if (self->_completedWithColor){
                    self->_completedWithColor(self->_selectedColorPicker);
                }
            }
            break;
            case FAPickerTypeCustomView:
            {
                if (self->_completedWithCustomView) {
                    self->_completedWithCustomView(FAPickerCustomViewButtonConfirm);
                }
            }
            break;
            default:
            break;
        }
        
        
        
        
    }];
}
    
- (IBAction)thirdButtonPressed:(id)sender{
    
    [self dismissPicker:^{
        if (self->_completeWithAlert) {
            self->_completeWithAlert(FAPickerAlertButtonThird);
        }
    }];
    
}
    
- (NSMutableArray<FAPickerItem*>*)selectedItems {
    if (_sections) {
        NSMutableArray<FAPickerItem*>* selectedItems = [NSMutableArray new];
        for (FAPickerSection *section in _sections) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"selected == %i", YES];
            NSMutableArray<FAPickerItem*>* newItems = [[NSMutableArray alloc]initWithArray:[section.items filteredArrayUsingPredicate:predicate]];
            if (newItems.count) {
                [selectedItems addObjectsFromArray:newItems];
            }
        }
        return selectedItems;
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"selected == %i", YES];
        NSMutableArray<FAPickerItem*>* newItems = [[NSMutableArray alloc]initWithArray:[_items filteredArrayUsingPredicate:predicate]];
        
        return newItems;
    }
}
    
- (void)setSelectedItems:(NSMutableArray <FAPickerItem*> *)items{
    if (_sections) {
        for (FAPickerItem*item in items) {
            for (FAPickerSection *section in _sections) {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title == %@ AND Id == %@", item.title , item.Id];
                NSArray *filteredArray = [section.items filteredArrayUsingPredicate:predicate];
                
                if ([section.items indexOfObjectIdenticalTo:filteredArray.firstObject] != NSNotFound) {
                    ((FAPickerItem*)filteredArray.firstObject).selected = YES;
                    break;
                }
            }
        }

    }
    else {
        for (FAPickerItem*item in items) {
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title == %@ AND Id == %@", item.title , item.Id];
            NSArray *filteredArray = [_items filteredArrayUsingPredicate:predicate];
            
            if ([_items indexOfObjectIdenticalTo:filteredArray.firstObject] != NSNotFound) {
                ((FAPickerItem*)filteredArray.firstObject).selected = YES;
            }
        }
    }
}
    
- (FAPickerItem*)selectedItem {
    if (_sections) {
        for (FAPickerSection *section in _sections) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"selected == %i", YES];
            NSMutableArray<FAPickerItem*>* newItems = [[NSMutableArray alloc]initWithArray:[section.items filteredArrayUsingPredicate:predicate]];
            if (newItems.count) {
                return newItems.firstObject;
            }
        }
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"selected == %i", YES];
        NSMutableArray<FAPickerItem*>* newItems = [[NSMutableArray alloc]initWithArray:[_items filteredArrayUsingPredicate:predicate]];
        
        return newItems.firstObject;
    }
    return nil;
    
}
    
- (void)setSelectedItem:(FAPickerItem* )item{
    if (_sections) {
        for (FAPickerSection *section in _sections) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title == %@ AND Id == %@", item.title , item.Id];
            NSArray *filteredArray = [section.items filteredArrayUsingPredicate:predicate];
            
            if ([section.items indexOfObjectIdenticalTo:filteredArray.firstObject] != NSNotFound) {
                ((FAPickerItem*)filteredArray.firstObject).selected = YES;
            }
        }
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title == %@ AND Id == %@", item.title , item.Id];
        NSArray *filteredArray = [_items filteredArrayUsingPredicate:predicate];
        
        if ([_items indexOfObjectIdenticalTo:filteredArray.firstObject] != NSNotFound) {
            ((FAPickerItem*)filteredArray.firstObject).selected = YES;
        }
    }
}
    
- (void)setSelectedItemByTitle:(NSString* )title{
    if (_sections) {
        NSMutableArray *rows = [NSMutableArray new];
        for (FAPickerSection *section in _sections) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title == %@", title];
            NSArray *filteredArray = [section.items filteredArrayUsingPredicate:predicate];
            
            if ([section.items indexOfObjectIdenticalTo:filteredArray.firstObject] != NSNotFound) {
                [rows addObject:[NSNumber numberWithInteger:[section.items indexOfObject:filteredArray.firstObject]]];
                ((FAPickerItem*)filteredArray.firstObject).selected = YES;
            }
        }
    }else {
        NSMutableArray *rows = [NSMutableArray new];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title == %@", title];
        NSArray *filteredArray = [_items filteredArrayUsingPredicate:predicate];
        
        if ([_items indexOfObjectIdenticalTo:filteredArray.firstObject] != NSNotFound) {
            [rows addObject:[NSNumber numberWithInteger:[_items indexOfObject:filteredArray.firstObject]]];
            
            ((FAPickerItem*)filteredArray.firstObject).selected = YES;
        }
    }
}
    
#pragma mark - UITableViewDataSource
    
    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        return _sections ? _sections.count : 1;
    }
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_filterItem) {
        return _filterItem.count;
    } else if (_items) {
        return _items.count;
    } else if (_sections && _sections.count > section && [_sections objectAtIndex:section].items) {
        return _sections[section].items.count;
    }
    return 0;
}
    
    - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        return _sections ? _sections[section].title : @"";
    }
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"fapicker_view_identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
    }
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
    
    BOOL isRTL = self.semanticContentAttribute == UISemanticContentAttributeForceRightToLeft ||
    [UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
    
    FAPickerItem* item;
    
    if (_filterItem) {
        item = [_filterItem objectAtIndex:indexPath.row];
    } else if (_items) {
        item = [_items objectAtIndex:indexPath.row];
    } else if (_sections && _sections.count > indexPath.section) {
        item = _sections[indexPath.section].items[indexPath.row];
    }
    
    if(item)
    {
        cell.textLabel.text = item.title;
        cell.imageView.image = item.image;
        cell.accessoryType = item.selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        
        // text color
        if (item.titleColor) {
            cell.textLabel.textColor = item.titleColor;
        }
        
        // image url
        if (item.imageURL && ![item.imageURL isEqualToString:@""]) {
            
            CGSize size = item.widthRatio ? CGSizeMake(30*item.widthRatio, 30) : CGSizeMake(30, 30);
            int x_Axis = isRTL ? tableView.frame.size.width - size.width - 15 : 15;
            [cell.imageView setImage:[FAPickerView imageWithColor:[UIColor clearColor] andSize:size]];
            
            UIImageView *circleImage = [UIImageView new];
            if (![cell viewWithTag:100]) {
                circleImage.frame = CGRectMake(x_Axis/*15*/, 8, size.width, size.height);
                circleImage.tag = 100;
                [cell addSubview:circleImage];
            }else{
                circleImage = (UIImageView*)[cell viewWithTag:100];
                circleImage.frame = CGRectMake(x_Axis/*15*/, 8, size.width, size.height);
            }
            
            [circleImage sd_setImageWithURL:[NSURL URLWithString:item.imageURL]
                           placeholderImage:item.Thumb];
            if (item.circleImage){
                circleImage.layer.cornerRadius = size.height/2;
                circleImage.layer.masksToBounds = YES;
            }else {
                circleImage.layer.cornerRadius = 0;
            }
            
        }
        
        // image color
        if (item.imageColor) {
            
            CGSize size = CGSizeMake(30, 30);
            int x_Axis = isRTL ? tableView.frame.size.width - size.width - 15 : 15;
            [cell.imageView setImage:[FAPickerView imageWithColor:[UIColor clearColor] andSize:size]];
            
            UIImageView *circleImage = [UIImageView new];
            if (![cell viewWithTag:100]) {
                circleImage.frame = CGRectMake(x_Axis/*15*/, 8, size.width, size.height);
                circleImage.tag = 100;
                [cell addSubview:circleImage];
            }else{
                circleImage = (UIImageView*)[cell viewWithTag:100];
            }
            
            [circleImage setImage:[FAPickerView imageWithColor:item.imageColor andSize:size]];
            if (item.circleImage){
                circleImage.layer.cornerRadius = size.height/2;
                circleImage.layer.masksToBounds = YES;
            }else {
                circleImage.layer.cornerRadius = 0;
            }
            
        }
    }
    
    if(self.checkmarkColor){
        cell.tintColor = self.checkmarkColor;
    }
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = selectedColor ? selectedColor : selectFAPickerColor;
    [cell setSelectedBackgroundView:bgColorView];
    
    if (isRTL)
    cell.textLabel.textAlignment = NSTextAlignmentRight;
    
    return cell;
}
    
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
    {
        CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
    
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.allowMultipleSelection){
        
        if (_filterItem && _filterItem.count) {
            [_filterItem objectAtIndex:indexPath.row].selected = ![_filterItem objectAtIndex:indexPath.row].selected;
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title == %@", [_filterItem objectAtIndex:indexPath.row].title];
            NSArray *filteredArray = [_items filteredArrayUsingPredicate:predicate];
            
            if ([_items indexOfObjectIdenticalTo:filteredArray.firstObject] != NSNotFound) {
                ((FAPickerItem*)filteredArray.firstObject).selected = [_filterItem objectAtIndex:indexPath.row].selected;
            }
            
        } else if (_sections) {
            [_sections objectAtIndex:indexPath.section].items[indexPath.row].selected = ![_sections objectAtIndex:indexPath.section].items[indexPath.row].selected;
        } else {
            [_items objectAtIndex:indexPath.row].selected = ![_items objectAtIndex:indexPath.row].selected;
        }
        [_tableView reloadData];
    } else { //single selection mode
        if (_items) {
            for (FAPickerItem*item in _items) {
                item.selected = NO;
            }
            
            if (_filterItem && _filterItem.count) {
                for (FAPickerItem*item in _filterItem) {
                    item.selected = NO;
                }
                
                [_filterItem objectAtIndex:indexPath.row].selected = YES;
                
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title == %@", [_filterItem objectAtIndex:indexPath.row].title];
                NSArray *filteredArray = [_items filteredArrayUsingPredicate:predicate];
                
                if ([_items indexOfObjectIdenticalTo:filteredArray.firstObject] != NSNotFound) {
                    ((FAPickerItem*)filteredArray.firstObject).selected = [_filterItem objectAtIndex:indexPath.row].selected;
                }
                [tableView reloadData];
                
            } else {
                [_items objectAtIndex:indexPath.row].selected = ![_items objectAtIndex:indexPath.row].selected;
            }
        }
        
        if (_sections) {
            for (FAPickerSection *section in _sections) {
                for (FAPickerItem*item in section.items) {
                    item.selected = NO;
                }
            }
            [_sections objectAtIndex:indexPath.section].items[indexPath.row].selected = ![_sections objectAtIndex:indexPath.section].items[indexPath.row].selected;
        }
        
        if (!self.needFooterView && _completeWithItem) {
            [self dismissPicker:^{
                self->_completeWithItem(self.selectedItem);
            }];
        }else {
            [_tableView reloadData];
        }
    }
    
}
    
#pragma mark - Date Change
-(void)dateChanged:(UIDatePicker*)sender
    {
        _selectedDate = sender.date;
        NSDateFormatter *weekDay = [[NSDateFormatter alloc] init];
        if (dateTimeLocalized && ![dateTimeLocalized isEqualToString:@""]) {
            weekDay.locale = [[NSLocale alloc] initWithLocaleIdentifier:dateTimeLocalized];
        }
        [weekDay setDateFormat:@"EEEE"];
        
        _dayLabel.text = [weekDay stringFromDate:_selectedDate];
    }
    
#pragma mark - Notification Handler
    
- (BOOL)needHandleOrientation{
    NSArray *supportedOrientations = [[[NSBundle mainBundle] infoDictionary]
                                      objectForKey:@"UISupportedInterfaceOrientations"];
    NSMutableSet *set = [NSMutableSet set];
    for(NSString *o in supportedOrientations){
        NSRange range = [o rangeOfString:@"Portrait"];
        if (range.location != NSNotFound) {
            [set addObject:@"Portrait"];
        }
        
        range = [o rangeOfString:@"Landscape"];
        if (range.location != NSNotFound) {
            [set addObject:@"Landscape"];
        }
    }
    return set.count == 2;
}
    
- (void)deviceOrientationDidChange:(NSNotification *)notification{
    CGRect rect = [UIScreen mainScreen].bounds;
    if (CGRectEqualToRect(rect, _previousBounds)) {
        return;
    }
    _previousBounds = rect;
    self.frame = rect;
    for(UIView *v in self.subviews){
        if([v isEqual:self.backgroundDimmingView]) continue;
        
        [UIView animateWithDuration:0.2f animations:^{
            v.alpha = 0.0;
        } completion:^(BOOL finished) {
            [v removeFromSuperview];
            //as backgroundDimmingView will not be removed
            if(self.subviews.count == 1){
                [self setupSubviews];
                [self performContainerAnimation];
            }
        }];
    }
}
    
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
    
    
    
#pragma mark - Block
#pragma mark Items with single selctor
-(void)showWithItems:(NSMutableArray<FAPickerItem*>*)items
        selectedItem:(FAPickerItem*)item
              filter:(BOOL)filter
         HeaderTitle:(NSString *)headerTitle
   cancelButtonTitle:(NSString *)cancelButtonTitle
  confirmButtonTitle:(NSString *)confirmButtonTitle
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel
    {
        [self initViewWithType:FAPickerTypeItems
                   HeaderTitle:headerTitle
             cancelButtonTitle:cancelButtonTitle
            confirmButtonTitle:confirmButtonTitle];
        _needFooterView = YES;
        _items = items;
        self.selectedItem = item;
        _Filter = filter;
        
        _completeWithItem = complete;
        _cancel = cancel;
        _tapBackgroundToDismiss = NO;
        [self show];
    }
    
-(void)showWithItems:(NSMutableArray<FAPickerItem*>*)items
selectedItemWithTitle:(NSString *)title
              filter:(BOOL)filter
         HeaderTitle:(NSString *)headerTitle
   cancelButtonTitle:(NSString *)cancelButtonTitle
  confirmButtonTitle:(NSString *)confirmButtonTitle
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel
    {
        [self initViewWithType:FAPickerTypeItems
                   HeaderTitle:headerTitle
             cancelButtonTitle:cancelButtonTitle
            confirmButtonTitle:confirmButtonTitle];
        _needFooterView = YES;
        _items = items;
        [self setSelectedItemByTitle:title];
        _Filter = filter;
        
        _completeWithItem = complete;
        _cancel = cancel;
        _tapBackgroundToDismiss = NO;
        [self show];
    }
    
#pragma mark Items with multi selctor
-(void)showWithItems:(NSMutableArray<FAPickerItem*>*)items
       selectedItems:(NSMutableArray<FAPickerItem*>*)selectedItems
              filter:(BOOL)filter
         HeaderTitle:(NSString *)headerTitle
   cancelButtonTitle:(NSString *)cancelButtonTitle
  confirmButtonTitle:(NSString *)confirmButtonTitle
      WithCompletion:(completedWithItemsAtItems)complete cancel:(cancel)cancel
    {
        [self initViewWithType:FAPickerTypeItems
                   HeaderTitle:headerTitle
             cancelButtonTitle:cancelButtonTitle
            confirmButtonTitle:confirmButtonTitle];
        _needFooterView = YES;
        _items = items;
        self.selectedItems = selectedItems;
        self.allowMultipleSelection = YES;
        _Filter = filter;
        
        _completedWithItemsAtItems = complete;
        _cancel = cancel;
        _tapBackgroundToDismiss = NO;
        [self show];
    }
    
#pragma mark Items with single selctor Without footer
-(void)showWithItems:(NSMutableArray<FAPickerItem*>*)items
        selectedItem:(FAPickerItem*)item
              filter:(BOOL)filter
         HeaderTitle:(NSString *)headerTitle
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel
    {
        [self initViewWithType:FAPickerTypeItems
                   HeaderTitle:headerTitle
             cancelButtonTitle:@""
            confirmButtonTitle:@""];
        _needFooterView = NO;
        _items = items;
        self.selectedItem = item;
        _Filter = filter;
        
        _completeWithItem = complete;
        _cancel = cancel;
        [self show];
    }
    
-(void)showWithItems:(NSMutableArray<FAPickerItem*>*)items
              filter:(BOOL)filter
selectedItemWithTitle:(NSString *)title
         HeaderTitle:(NSString *)headerTitle
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel
    {
        [self initViewWithType:FAPickerTypeItems
                   HeaderTitle:headerTitle
             cancelButtonTitle:@""
            confirmButtonTitle:@""];
        _needFooterView = NO;
        _items = items;
        [self setSelectedItemByTitle:title];
        _Filter = filter;
        
        _completeWithItem = complete;
        _cancel = cancel;
        [self show];
    }
    
    
    
    
    
    
#pragma mark Sections with single selctor
-(void)showWithSections:(NSMutableArray<FAPickerSection *>*)sections
        selectedItem:(FAPickerItem*)item
         HeaderTitle:(NSString *)headerTitle
   cancelButtonTitle:(NSString *)cancelButtonTitle
  confirmButtonTitle:(NSString *)confirmButtonTitle
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel
    {
        [self initViewWithType:FAPickerTypeItems
                   HeaderTitle:headerTitle
             cancelButtonTitle:cancelButtonTitle
            confirmButtonTitle:confirmButtonTitle];
        _needFooterView = YES;
        _sections = sections;
        self.selectedItem = item;
        _Filter = NO;
        
        _completeWithItem = complete;
        _cancel = cancel;
        _tapBackgroundToDismiss = NO;
        [self show];
    }
    
-(void)showWithSections:(NSMutableArray<FAPickerSection *>*)sections
selectedItemWithTitle:(NSString *)title
         HeaderTitle:(NSString *)headerTitle
   cancelButtonTitle:(NSString *)cancelButtonTitle
  confirmButtonTitle:(NSString *)confirmButtonTitle
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel
    {
        [self initViewWithType:FAPickerTypeItems
                   HeaderTitle:headerTitle
             cancelButtonTitle:cancelButtonTitle
            confirmButtonTitle:confirmButtonTitle];
        _needFooterView = YES;
        _sections = sections;
        [self setSelectedItemByTitle:title];
        _Filter = NO;

        _completeWithItem = complete;
        _cancel = cancel;
        _tapBackgroundToDismiss = NO;
        [self show];
    }

#pragma mark Sections with multi selctor
-(void)showWithSections:(NSMutableArray<FAPickerSection *>*)sections
       selectedItems:(NSMutableArray<FAPickerItem*>*)selectedItems
         HeaderTitle:(NSString *)headerTitle
   cancelButtonTitle:(NSString *)cancelButtonTitle
  confirmButtonTitle:(NSString *)confirmButtonTitle
      WithCompletion:(completedWithItemsAtItems)complete cancel:(cancel)cancel
    {
        [self initViewWithType:FAPickerTypeItems
                   HeaderTitle:headerTitle
             cancelButtonTitle:cancelButtonTitle
            confirmButtonTitle:confirmButtonTitle];
        _needFooterView = YES;
        _sections = sections;
        self.selectedItems = selectedItems;
        self.allowMultipleSelection = YES;
        _Filter = NO;

        _completedWithItemsAtItems = complete;
        _cancel = cancel;
        _tapBackgroundToDismiss = NO;
        [self show];
    }

#pragma mark Sections with single selctor Without footer
-(void)showWithSections:(NSMutableArray<FAPickerSection *>*)sections
        selectedItem:(FAPickerItem*)item
         HeaderTitle:(NSString *)headerTitle
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel
    {
        [self initViewWithType:FAPickerTypeItems
                   HeaderTitle:headerTitle
             cancelButtonTitle:@""
            confirmButtonTitle:@""];
        _needFooterView = NO;
        _sections = sections;
        self.selectedItem = item;
        _Filter = NO;

        _completeWithItem = complete;
        _cancel = cancel;
        [self show];
    }

-(void)showWithSections:(NSMutableArray<FAPickerSection *>*)sections
selectedItemWithTitle:(NSString *)title
         HeaderTitle:(NSString *)headerTitle
      WithCompletion:(completedWithItem)complete cancel:(cancel)cancel
    {
        [self initViewWithType:FAPickerTypeItems
                   HeaderTitle:headerTitle
             cancelButtonTitle:@""
            confirmButtonTitle:@""];
        _needFooterView = NO;
        _sections = sections;
        [self setSelectedItemByTitle:title];
        _Filter = NO;

        _completeWithItem = complete;
        _cancel = cancel;
        [self show];
    }
    
    
#pragma mark Date and Time
    
-(void)showWithSelectedDate:(NSDate *)date
                HeaderTitle:(NSString *)headerTitle
          cancelButtonTitle:(NSString *)cancelButtonTitle
         confirmButtonTitle:(NSString *)confirmButtonTitle
             WithCompletion:(completedWithDate)complete cancel:(cancel)cancel
    {
        [self initViewWithType:FAPickerTypeDate
                   HeaderTitle:headerTitle
             cancelButtonTitle:cancelButtonTitle
            confirmButtonTitle:confirmButtonTitle];
        _needFooterView = YES;
        self.selectedDate = date ? date : NSDate.date;
        _datePickerMode = UIDatePickerModeDate;
        _Filter = NO;
        
        _completedWithDate = complete;
        _cancel = cancel;
        _tapBackgroundToDismiss = NO;
        [self show];
    }
    
-(void)showWithSelectedDate:(NSDate *)date
                 DateFormat:(UIDatePickerMode)datePickerMode
                HeaderTitle:(NSString *)headerTitle
          cancelButtonTitle:(NSString *)cancelButtonTitle
         confirmButtonTitle:(NSString *)confirmButtonTitle
             WithCompletion:(completedWithDate)complete cancel:(cancel)cancel
    {
        [self initViewWithType:FAPickerTypeDate
                   HeaderTitle:headerTitle
             cancelButtonTitle:cancelButtonTitle
            confirmButtonTitle:confirmButtonTitle];
        _needFooterView = YES;
        self.selectedDate = date ? date : NSDate.date;
        _datePickerMode = datePickerMode;
        _Filter = NO;
        
        _completedWithDate = complete;
        _cancel = cancel;
        _tapBackgroundToDismiss = NO;
        [self show];
    }
    
#pragma mark Date and Time With Range
    
-(void)showWithSelectedDate:(NSDate *)date
                MaximumDate:(NSDate *)maximumDate
                MinimumDate:(NSDate *)minimumDate
                HeaderTitle:(NSString *)headerTitle
          cancelButtonTitle:(NSString *)cancelButtonTitle
         confirmButtonTitle:(NSString *)confirmButtonTitle
             WithCompletion:(completedWithDate)complete cancel:(cancel)cancel
    {
        [self initViewWithType:FAPickerTypeDate
                   HeaderTitle:headerTitle
             cancelButtonTitle:cancelButtonTitle
            confirmButtonTitle:confirmButtonTitle];
        _needFooterView = YES;
        self.selectedDate = date ? date : NSDate.date;
        _datePickerMode = UIDatePickerModeDate;
        _maximumDate = maximumDate;
        _minimumDate = minimumDate;
        _Filter = NO;
        
        _completedWithDate = complete;
        _cancel = cancel;
        _tapBackgroundToDismiss = NO;
        [self show];
    }
    
-(void)showWithSelectedDate:(NSDate *)date
                 DateFormat:(UIDatePickerMode)datePickerMode
                MaximumDate:(NSDate *)maximumDate
                MinimumDate:(NSDate *)minimumDate
                HeaderTitle:(NSString *)headerTitle
          cancelButtonTitle:(NSString *)cancelButtonTitle
         confirmButtonTitle:(NSString *)confirmButtonTitle
             WithCompletion:(completedWithDate)complete cancel:(cancel)cancel
    {
        [self initViewWithType:FAPickerTypeDate
                   HeaderTitle:headerTitle
             cancelButtonTitle:cancelButtonTitle
            confirmButtonTitle:confirmButtonTitle];
        _needFooterView = YES;
        self.selectedDate = date ? date : NSDate.date;
        _datePickerMode = datePickerMode;
        _maximumDate = maximumDate;
        _minimumDate = minimumDate;
        _Filter = NO;
        
        _completedWithDate = complete;
        _cancel = cancel;
        _tapBackgroundToDismiss = NO;
        [self show];
    }
    
#pragma mark color picker
-(void)showWithSelectedColor:(UIColor *)color
                 HeaderTitle:(NSString *)headerTitle
           cancelButtonTitle:(NSString *)cancelButtonTitle
          confirmButtonTitle:(NSString *)confirmButtonTitle
              WithCompletion:(completedWithColor)complete cancel:(cancel)cancel{
    [self initViewWithType:FAPickerTypeColor
               HeaderTitle:headerTitle
         cancelButtonTitle:cancelButtonTitle
        confirmButtonTitle:confirmButtonTitle];
    _selectedColorPicker = color ? color : [UIColor whiteColor];
    _needFooterView = YES;
    _Filter = NO;
    _completedWithColor = complete;
    _cancel = cancel;
    [self show];
}
    
#pragma mark Alert view
-(void)showWithMessage:(NSString *)message
           headerTitle:(NSString *)headerTitle
    confirmButtonTitle:(NSString *)confirmButtonTitle
        WithCompletion:(completedWithAlert)complete
    {
        [self initViewWithType:FAPickerTypeAlert
                   HeaderTitle:headerTitle
             cancelButtonTitle:@""
            confirmButtonTitle:confirmButtonTitle];
        _message = message;
        _needFooterView = YES;
        _Filter = NO;
        _completeWithAlert = complete;
        [self show];
    }
    
-(void)showWithMessage:(NSString *)message
           headerTitle:(NSString *)headerTitle
    confirmButtonTitle:(NSString *)confirmButtonTitle
     cancelButtonTitle:(NSString *)cancelButtonTitle
        WithCompletion:(completedWithAlert)complete
    {
        [self initViewWithType:FAPickerTypeAlert
                   HeaderTitle:headerTitle
             cancelButtonTitle:cancelButtonTitle
            confirmButtonTitle:confirmButtonTitle];
        _message = message;
        _needFooterView = YES;
        _Filter = NO;
        _completeWithAlert = complete;
        [self show];
    }
    
-(void)showWithMessage:(NSString *)message
           headerTitle:(NSString *)headerTitle
    confirmButtonTitle:(NSString *)confirmButtonTitle
     cancelButtonTitle:(NSString *)cancelButtonTitle
      thirdButtonTitle:(NSString *)thirdButtonTitle
        WithCompletion:(completedWithAlert)complete
    {
        [self initViewWithType:FAPickerTypeAlert
                   HeaderTitle:headerTitle
             cancelButtonTitle:cancelButtonTitle
            confirmButtonTitle:confirmButtonTitle];
        _ThirdButtonTitle = thirdButtonTitle;
        _message = message;
        _needFooterView = YES;
        _Filter = NO;
        _completeWithAlert = complete;
        [self show];
    }
    
#pragma mark Custom view
    
-(void)showWithCustomView:(UIViewController *)view
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
           WithCompletion:(completedWithCustomView)complete{
    [self initViewWithType:FAPickerTypeCustomView
               HeaderTitle:headerTitle
         cancelButtonTitle:@""
        confirmButtonTitle:confirmButtonTitle];
    _customView = view;
    _customViewHeight = 0;
    _needFooterView = YES;
    _Filter = NO;
    _completedWithCustomView = complete;
    [self show];
}
    
-(void)showWithCustomView:(UIViewController *)view
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
        cancelButtonTitle:(NSString *)cancelButtonTitle
           WithCompletion:(completedWithCustomView)complete{
    [self initViewWithType:FAPickerTypeCustomView
               HeaderTitle:headerTitle
         cancelButtonTitle:cancelButtonTitle
        confirmButtonTitle:confirmButtonTitle];
    _customView = view;
    _customViewHeight = 0;
    _needFooterView = YES;
    _Filter = NO;
    _completedWithCustomView = complete;
    [self show];
}
    
-(void)showWithCustomView:(UIViewController *)view
CustomViewContainerHeight:(float)height
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
           WithCompletion:(completedWithCustomView)complete{
    [self initViewWithType:FAPickerTypeCustomView
               HeaderTitle:headerTitle
         cancelButtonTitle:@""
        confirmButtonTitle:confirmButtonTitle];
    _customView = view;
    _customViewHeight = height < 0 ? 0 : height;
    _needFooterView = YES;
    _Filter = NO;
    _completedWithCustomView = complete;
    [self show];
}
    
-(void)showWithCustomView:(UIViewController *)view
CustomViewContainerHeight:(float)height
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
        cancelButtonTitle:(NSString *)cancelButtonTitle
           WithCompletion:(completedWithCustomView)complete{
    [self initViewWithType:FAPickerTypeCustomView
               HeaderTitle:headerTitle
         cancelButtonTitle:cancelButtonTitle
        confirmButtonTitle:confirmButtonTitle];
    _customView = view;
    _customViewHeight = height < 0 ? 0 : height;
    _needFooterView = YES;
    _Filter = NO;
    _completedWithCustomView = complete;
    [self show];
}

-(void)showWithCustomView:(UIViewController *)view
            BottomPadding:(float)bottomPadding
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
           WithCompletion:(completedWithCustomView)complete{
    [self initViewWithType:FAPickerTypeCustomView
               HeaderTitle:headerTitle
         cancelButtonTitle:@""
        confirmButtonTitle:confirmButtonTitle];
    _customView = view;
    _customViewHeight = 0;
    _needFooterView = YES;
    _Filter = NO;
    _completedWithCustomView = complete;
    _customViewBottomPadding = bottomPadding;
    [self show];
}

-(void)showWithCustomView:(UIViewController *)view
            BottomPadding:(float)bottomPadding
              headerTitle:(NSString *)headerTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle
        cancelButtonTitle:(NSString *)cancelButtonTitle
           WithCompletion:(completedWithCustomView)complete{
    [self initViewWithType:FAPickerTypeCustomView
               HeaderTitle:headerTitle
         cancelButtonTitle:cancelButtonTitle
        confirmButtonTitle:confirmButtonTitle];
    _customView = view;
    _customViewHeight = 0;
    _needFooterView = YES;
    _Filter = NO;
    _completedWithCustomView = complete;
    _customViewBottomPadding = bottomPadding;
    [self show];
}

#pragma mark Custom Picker
    
-(void)showWithCustomPickerView:(UIViewController *)view{
    [self initViewWithType:FAPickerTypeCustomPicker
               HeaderTitle:@""
         cancelButtonTitle:@""
        confirmButtonTitle:@""];
    _customView = view;
    _customViewHeight = 0;
    _needFooterView = NO;
    _Filter = NO;
    [self show];
}
    
    
-(void)showWithCustomPickerView:(UIViewController *)view
                  CancelGesture:(BOOL)cancelGesture{
    [self initViewWithType:FAPickerTypeCustomPicker
               HeaderTitle:@""
         cancelButtonTitle:@""
        confirmButtonTitle:@""];
    _customView = view;
    _customViewHeight = 0;
    _needFooterView = NO;
    _Filter = NO;
    _tapBackgroundToDismiss = cancelGesture;
    [self show];
}
    
    
-(void)showWithCustomPickerView:(UIViewController *)view
      CustomViewContainerHeight:(float)height{
    [self initViewWithType:FAPickerTypeCustomPicker
               HeaderTitle:@""
         cancelButtonTitle:@""
        confirmButtonTitle:@""];
    _customView = view;
    _customViewHeight = height < 0 ? 0 : height;
    _needFooterView = NO;
    _Filter = NO;
    [self show];
}
    
-(void)showWithCustomPickerView:(UIViewController *)view
      CustomViewContainerHeight:(float)height
                  CancelGesture:(BOOL)cancelGesture{
    [self initViewWithType:FAPickerTypeCustomPicker
               HeaderTitle:@""
         cancelButtonTitle:@""
        confirmButtonTitle:@""];
    _customView = view;
    _customViewHeight = height < 0 ? 0 : height;
    _needFooterView = NO;
    _Filter = NO;
    _tapBackgroundToDismiss = cancelGesture;
    [self show];
}

-(void)showWithCustomPickerView:(UIViewController *)view
                  BottomPadding:(float)bottomPadding{
    [self initViewWithType:FAPickerTypeCustomPicker
               HeaderTitle:@""
         cancelButtonTitle:@""
        confirmButtonTitle:@""];
    _customView = view;
    _needFooterView = NO;
    _Filter = NO;
    _customViewBottomPadding = bottomPadding;
    [self show];
}

-(void)showWithCustomPickerView:(UIViewController *)view
                  BottomPadding:(float)bottomPadding
                  CancelGesture:(BOOL)cancelGesture{
    [self initViewWithType:FAPickerTypeCustomPicker
               HeaderTitle:@""
         cancelButtonTitle:@""
        confirmButtonTitle:@""];
    _customView = view;
    _needFooterView = NO;
    _Filter = NO;
    _tapBackgroundToDismiss = cancelGesture;
    _customViewBottomPadding = bottomPadding;
    [self show];
}

    
#pragma mark init View
    
-(void)initViewWithType:(FAPickerType)pickerType
            HeaderTitle:(NSString *)headerTitle
      cancelButtonTitle:(NSString *)cancelButtonTitle
     confirmButtonTitle:(NSString *)confirmButtonTitle
    {
        if([self needHandleOrientation]){
            [[NSNotificationCenter defaultCenter] addObserver: self
                                                     selector:@selector(deviceOrientationDidChange:)
                                                         name:UIDeviceOrientationDidChangeNotification
                                                       object: nil];
        }
        self.pickerType = pickerType;
        self.selectedDate = [NSDate date];
        self.selectedColorPicker = UIColor.whiteColor;
        self.tapBackgroundToDismiss = YES;
        self.needFooterView = NO;
        self.allowMultipleSelection = NO;
        self.animationDuration = 0.5f;
        self.confirmButtonTitle = confirmButtonTitle;
        self.cancelButtonTitle = cancelButtonTitle;
        
        self.headerTitle = headerTitle ? headerTitle : @"";
        
        //check if color is dark or light
        const CGFloat *component = CGColorGetComponents(mainColor ? mainColor.CGColor : mainFAPickerColor.CGColor);
        CGFloat brightness = ((component[0] * 299) + (component[1] * 587) + (component[2] * 114)) / 1000;
        
        self.headerTitleColor = (brightness < 0.75) ? [UIColor whiteColor] : [UIColor blackColor];
        
        //    self.headerTitleColor = [UIColor whiteColor];
        self.headerBackgroundColor = mainColor ? mainColor : mainFAPickerColor;//[UIColor colorWithRed:56.0/255 green:185.0/255 blue:158.0/255 alpha:1];
        
        self.cancelButtonNormalColor = mainColor ? mainColor : mainFAPickerColor;//[UIColor colorWithRed:59.0/255 green:72/255.0 blue:5.0/255 alpha:1];
        self.cancelButtonHighlightedColor = selectedColor ? selectedColor : selectFAPickerColor;//[UIColor grayColor];
        self.cancelButtonBackgroundColor = [UIColor colorWithRed:236.0/255 green:240/255.0 blue:241.0/255 alpha:1];
        
        //check if color is dark or light
        self.confirmButtonNormalColor = (brightness < 0.75) ? [UIColor whiteColor] : [UIColor blackColor];
        
        //    self.confirmButtonNormalColor = [UIColor whiteColor];
        self.confirmButtonHighlightedColor = [UIColor colorWithRed:236.0/255 green:240/255.0 blue:241.0/255 alpha:1];
        self.confirmButtonBackgroundColor = mainColor ? mainColor : mainFAPickerColor;//[UIColor colorWithRed:56.0/255 green:185.0/255 blue:158.0/255 alpha:1];
        
        self.checkmarkColor = mainColor ? mainColor : mainFAPickerColor;//[UIColor colorWithRed:56.0/255 green:185.0/255 blue:158.0/255 alpha:1];
        
        self.ThirdButtonTitle = @"";
        
        _previousBounds = [UIScreen mainScreen].bounds;
        self.frame = _previousBounds;
    }
    
    @end


