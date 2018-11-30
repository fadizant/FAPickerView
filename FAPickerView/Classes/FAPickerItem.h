//
//  FAPickerItem.h
//  FAPickerView
//
//  Created by Fadi Abuzant on 11/13/18.
//

#import <Foundation/Foundation.h>

@interface FAPickerItem : NSObject

@property (nonatomic,retain) NSString* Id;
@property (nonatomic,retain) NSString* title;
@property (nonatomic,retain) UIColor* titleColor;
@property (nonatomic,retain) UIColor* imageColor;
@property (nonatomic,retain) UIImage* image;
@property (nonatomic,retain) NSString* imageURL;
@property (nonatomic,retain) UIImage* Thumb;
@property (nonatomic) float widthRatio;
@property (nonatomic) BOOL circleImage;
@property (nonatomic) BOOL selected;

- (instancetype)initWithID:(NSString*)ID
                     Title:(NSString*)title;

- (instancetype)initWithID:(NSString*)ID
                     Title:(NSString*)title
                TitleColor:(UIColor*)titleColor;

- (instancetype)initWithID:(NSString*)ID
                     Title:(NSString*)title
                     Image:(UIImage*)image;

- (instancetype)initWithID:(NSString*)ID
                     Title:(NSString*)title
                  ImageURL:(NSString*)URL
                     Thumb:(UIImage*)thumb;

- (instancetype)initWithID:(NSString*)ID
                     Title:(NSString*)title
                  ImageURL:(NSString*)URL
                     Thumb:(UIImage*)thumb
                WidthRatio:(float)widthRatio;

- (instancetype)initWithID:(NSString*)ID
                     Title:(NSString*)title
                  ImageURL:(NSString*)URL
                     Thumb:(UIImage*)thumb
                    Circle:(BOOL)isCircle;

- (instancetype)initWithID:(NSString*)ID
                     Title:(NSString*)title
                ImageColor:(UIColor*)imageColor
                    Circle:(BOOL)isCircle;

- (instancetype)initWithID:(NSString*)ID
                     Title:(NSString*)title
                TitleColor:(UIColor*)titleColor
                ImageColor:(UIColor*)imageColor
                    Circle:(BOOL)isCircle;

@end
