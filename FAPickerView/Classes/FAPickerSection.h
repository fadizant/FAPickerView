//
//  FAPickerSection.h
//  FAPickerView
//
//  Created by Fadi Abuzant on 11/13/18.
//

#import <Foundation/Foundation.h>
#import "FAPickerItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface FAPickerSection : NSObject

@property (nonatomic,retain) NSString* title;
@property (nonatomic,retain) NSMutableArray<FAPickerItem*>* items;

- (instancetype)initWithTitle:(NSString *)title Items:(NSMutableArray<FAPickerItem*>*)items;
-(void)addItem:(FAPickerItem*)item;
@end

NS_ASSUME_NONNULL_END
