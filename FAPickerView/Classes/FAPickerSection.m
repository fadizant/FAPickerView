//
//  FAPickerSection.m
//  FAPickerView
//
//  Created by Fadi Abuzant on 11/13/18.
//

#import "FAPickerSection.h"

@implementation FAPickerSection

- (instancetype)initWithTitle:(NSString *)title Items:(NSMutableArray<FAPickerItem*>*)items
{
    self = [super init];
    if (self) {
        self.title = title;
        self.items = items;
    }
    return self;
}

-(void)addItem:(FAPickerItem*)item{
    if (!self.items) {
        self.items = [NSMutableArray new];
    }
    [self.items addObject:item];
}

@end
