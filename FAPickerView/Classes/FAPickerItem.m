//
//  FAPickerItem.m
//  FAPickerView
//
//  Created by Fadi Abuzant on 11/13/18.
//

#import "FAPickerItem.h"

@implementation FAPickerItem

- (instancetype)initWithID:(NSString*)ID
                     Title:(NSString*)title
{
    self = [super init];
    if (self) {
        _Id = ID;
        _title = title;
    }
    return self;
}

- (instancetype)initWithID:(NSString*)ID
                     Title:(NSString*)title
                TitleColor:(UIColor*)titleColor
{
    self = [super init];
    if (self) {
        _Id = ID;
        _title = title;
        _titleColor = titleColor;
    }
    return self;
}

- (instancetype)initWithID:(NSString*)ID
                     Title:(NSString*)title
                     Image:(UIImage*)image
{
    self = [super init];
    if (self) {
        _Id = ID;
        _title = title;
        _image = image;
    }
    return self;
}

- (instancetype)initWithID:(NSString*)ID
                     Title:(NSString*)title
                  ImageURL:(NSString*)URL
                     Thumb:(UIImage*)thumb
{
    self = [super init];
    if (self) {
        _Id = ID;
        _title = title;
        _imageURL = URL;
        _Thumb = thumb;
    }
    return self;
}

- (instancetype)initWithID:(NSString*)ID
                     Title:(NSString*)title
                  ImageURL:(NSString*)URL
                     Thumb:(UIImage*)thumb
                WidthRatio:(float)widthRatio
{
    self = [super init];
    if (self) {
        _Id = ID;
        _title = title;
        _imageURL = URL;
        _Thumb = thumb;
        _widthRatio = widthRatio;
    }
    return self;
}

- (instancetype)initWithID:(NSString*)ID
                     Title:(NSString*)title
                  ImageURL:(NSString*)URL
                     Thumb:(UIImage*)thumb
                    Circle:(BOOL)isCircle
{
    self = [super init];
    if (self) {
        _Id = ID;
        _title = title;
        _imageURL = URL;
        _Thumb = thumb;
        _circleImage = isCircle;
    }
    return self;
}

- (instancetype)initWithID:(NSString*)ID
                     Title:(NSString*)title
                ImageColor:(UIColor*)imageColor
                    Circle:(BOOL)isCircle
{
    self = [super init];
    if (self) {
        _Id = ID;
        _title = title;
        _imageColor = imageColor;
        _circleImage = isCircle;
    }
    return self;
}

- (instancetype)initWithID:(NSString*)ID
                     Title:(NSString*)title
                TitleColor:(UIColor*)titleColor
                ImageColor:(UIColor*)imageColor
                    Circle:(BOOL)isCircle
{
    self = [super init];
    if (self) {
        _Id = ID;
        _title = title;
        _titleColor = titleColor;
        _imageColor = imageColor;
        _circleImage = isCircle;
    }
    return self;
}
@end
