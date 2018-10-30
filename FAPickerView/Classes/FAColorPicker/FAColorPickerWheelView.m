//
//  FAColorPickerWheelView.h
//
//  Created by Fadi Abuzant on 3/4/18.
//  Copyright © 2018 fadizant. All rights reserved.

#import "FAColorPickerWheelView.h"
#import "FAColorPicker+UIColor.h"
#import "FAColorPicker.h"
#import "FAColorPickerStore.h"

@interface FAColorPickerWheelGradientView : UIView

@property (nonatomic, assign) CGGradientRef gradient;
@property (nonatomic, strong) UIColor* color1;
@property (nonatomic, strong) UIColor* color2;

@end

@implementation FAColorPickerWheelGradientView

- (void) setColor1:(UIColor*)color
{
    if (_color1 != color)
    {
        _color1 = [color copy];
        [self setupGradient];
        [self setNeedsDisplay];
    }
}

- (void) setColor2:(UIColor*)color
{
    if (_color2 != color)
    {
        _color2 = [color copy];
        [self setupGradient];
        [self setNeedsDisplay];
    }
}

- (void) setupGradient
{
    if (_color1 == nil || _color2 == nil)
    {
        return;
    }

	const CGFloat* c1 = CGColorGetComponents(_color1.CGColor);
	const CGFloat* c2 = CGColorGetComponents(_color2.CGColor);

	CGFloat colors[] = { c1[0], c1[1], c1[2], 1.0f, c2[0], c2[1], c2[2], 1.0f };
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();

    if (self.gradient != NULL)
    {
        CGGradientRelease(self.gradient);
    }

	self.gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors) / (sizeof(colors[0]) * 4));
	CGColorSpaceRelease(rgb);
}

- (void) drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGRect clippingRect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
	CGPoint endPoints[] = { CGPointMake(0.0f, 0.0f), CGPointMake(self.frame.size.width, 0.0f) };

	CGContextSaveGState(context);
	CGContextClipToRect(context, clippingRect);
	CGContextDrawLinearGradient(context, self.gradient, endPoints[0], endPoints[1], 0.0f);
	CGContextRestoreGState(context);
}

- (void) dealloc
{
    if (self.gradient != NULL)
    {
        CGGradientRelease(self.gradient);
    }
}

@end

CGFloat const FAColorPickerWheelViewGradientViewHeight = 40.0f;
CGFloat const FAColorPickerWheelViewGradientTopMargin = 20.0f;
CGFloat const FAColorPickerWheelViewDefaultMargin = 10.0f;
CGFloat const FAColorPickerWheelLabelWidth = 60.0f;
CGFloat const FAColorPickerWheelLabelHeight = 30.0f;
CGFloat const FAColorPickerWheelTextFieldWidth = 84.0f;
CGFloat const FAColorPickerWheelViewBrightnessIndicatorWidth = 16.0f;
CGFloat const FAColorPickerWheelViewBrightnessIndicatorHeight = 48.0f;
CGFloat const FAColorPickerWheelViewCrossHairshWidthAndHeight = 38.0f;

@interface FAColorPickerWheelView () <UITextFieldDelegate>

@property (nonatomic, strong) FAColorPickerWheelGradientView* brightnessView;
@property (nonatomic, strong) UIImageView* brightnessIndicator;
@property (nonatomic, strong) FAColorPickerWheelGradientView* saturationView;
@property (nonatomic, strong) UIImageView* saturationIndicator;
@property (nonatomic, strong) UIImageView* hueImage;
@property (nonatomic, strong) UIView* colorBubble;
@property (nonatomic, assign) CGFloat brightness;
@property (nonatomic, assign) CGFloat hue;
@property (nonatomic, assign) CGFloat saturation;
@property (nonatomic, strong) UILabel* rgbLabel;
@property (nonatomic, strong) UITextField* rgbTextField;
@property (nonatomic, strong) UIView* colorPreviewView;
@property (nonatomic, weak) UIView* focusView;

@end

@implementation FAColorPickerWheelView

- (id) initWithFrame:(CGRect)f
{
    if ((self = [super initWithFrame:f]) == nil) { return nil; }

    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self createViews];
    self.color = [UIColor redColor];

    return self;
}

- (void) createViews
{
    UIColor* borderColor = [UIColor colorWithWhite:0.0f alpha:0.1f];

    _rgbLabel = [[UILabel alloc] init];
    _rgbLabel.text = @"RGB: #";
    _rgbLabel.textAlignment = NSTextAlignmentCenter;
    _rgbLabel.textColor = UIColor.blackColor;
    _rgbLabel.shadowColor = UIColor.whiteColor;
    _rgbLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _rgbLabel.font = [FAColorPickerFont fontWithSize:16.0f];
    _rgbLabel.backgroundColor = UIColor.whiteColor;
    [self addSubview:_rgbLabel];

    _rgbTextField = [[UITextField alloc] init];
    _rgbTextField.textColor = UIColor.blackColor;
    _rgbTextField.backgroundColor = UIColor.whiteColor;
    _rgbTextField.layer.borderColor = borderColor.CGColor;
    _rgbTextField.layer.borderWidth = 1.0f;
    _rgbTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 9.0f, 1.0f)];
    _rgbTextField.leftViewMode = UITextFieldViewModeAlways;
    _rgbTextField.font = [UIFont fontWithName:@"Courier" size:18.0f];
    _rgbTextField.returnKeyType = UIReturnKeyDone;
    _rgbTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _rgbTextField.delegate = self;
    [_rgbTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_rgbTextField];

    _colorPreviewView = [[UIView alloc] init];
    _colorPreviewView.layer.borderWidth = 1.0f;
    _colorPreviewView.layer.borderColor = FAColorPickerBorderColor.CGColor;
    [self addSubview:_colorPreviewView];

    _hueImage = [[UIImageView alloc] initWithImage:[FAColorPickerStore imageNamedFromPodResources:@"colormap"]];
    _hueImage.layer.borderWidth = 1.0f;
    _hueImage.layer.borderColor = borderColor.CGColor;
    [self addSubview:_hueImage];

    _brightnessView = [self createBarViewWithBorderColor:borderColor];
    _brightnessIndicator = [self createIndicator];

    if (FAColorPickerShowSaturationBar)
    {
        _saturationView = [self createBarViewWithBorderColor:borderColor];
        _saturationIndicator = [self createIndicator];
    }

    _colorBubble = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, FAColorPickerWheelViewCrossHairshWidthAndHeight, FAColorPickerWheelViewCrossHairshWidthAndHeight)];
    UIColor* bubbleBorderColor = [UIColor colorWithWhite:0.9 alpha:0.8];
    _colorBubble.layer.cornerRadius = FAColorPickerWheelViewCrossHairshWidthAndHeight * 0.5f;
    _colorBubble.layer.borderColor = bubbleBorderColor.CGColor;
    _colorBubble.layer.borderWidth = 2;
    _colorBubble.layer.shadowColor = [UIColor blackColor].CGColor;
    _colorBubble.layer.shadowOffset = CGSizeZero;
    _colorBubble.layer.shadowRadius = 1;
    _colorBubble.layer.shadowOpacity = 0.5f;
    _colorBubble.layer.shouldRasterize = YES;
    _colorBubble.layer.rasterizationScale = UIScreen.mainScreen.scale;
    [self addSubview:_colorBubble];
}

- (FAColorPickerWheelGradientView*) createBarViewWithBorderColor:(UIColor*)borderColor
{
    FAColorPickerWheelGradientView* v = [[FAColorPickerWheelGradientView alloc] init];
    v.layer.borderWidth = 1.0f;
    v.layer.borderColor = borderColor.CGColor;
    [self addSubview:v];

    return v;
}

- (UIImageView*) createIndicator
{
    UIImageView* indicator = [[UIImageView alloc] initWithFrame:CGRectMake(FAColorPickerWheelViewDefaultMargin, self.brightnessView.center.y,
                                                                         FAColorPickerWheelViewBrightnessIndicatorWidth, FAColorPickerWheelViewBrightnessIndicatorHeight)];
    
    indicator.image = [FAColorPickerStore imageNamedFromPodResources:@"brightnessguide"];
    indicator.layer.shadowColor = [UIColor blackColor].CGColor;
    indicator.layer.shadowOffset = CGSizeZero;
    indicator.layer.shadowRadius = 1;
    indicator.layer.shadowOpacity = 0.8f;
    indicator.layer.shouldRasterize = YES;
    indicator.layer.rasterizationScale = UIScreen.mainScreen.scale;
    [self addSubview:indicator];

    return indicator;
}

- (void) layoutSubviews
{
    [super layoutSubviews];

    self.rgbLabel.frame = CGRectMake(FAColorPickerWheelViewDefaultMargin, FAColorPickerWheelViewDefaultMargin, FAColorPickerWheelLabelWidth, FAColorPickerWheelLabelHeight);

    self.rgbTextField.frame = CGRectMake(FAColorPickerWheelViewDefaultMargin + FAColorPickerWheelLabelWidth,
                                         FAColorPickerWheelViewDefaultMargin,
                                         FAColorPickerWheelTextFieldWidth,
                                         FAColorPickerWheelLabelHeight);

    CGFloat previewX = FAColorPickerWheelViewDefaultMargin + FAColorPickerWheelLabelWidth + FAColorPickerWheelViewDefaultMargin + FAColorPickerWheelTextFieldWidth;
    self.colorPreviewView.frame = CGRectMake(previewX, FAColorPickerWheelViewDefaultMargin, self.frame.size.width - FAColorPickerWheelViewDefaultMargin - previewX, FAColorPickerWheelLabelHeight);

    CGFloat hueHeight;
    if (self.saturationView == nil)
    {
        hueHeight = CGRectGetHeight(self.frame) - FAColorPickerWheelViewGradientViewHeight - FAColorPickerWheelViewGradientTopMargin - FAColorPickerWheelViewDefaultMargin - FAColorPickerWheelViewDefaultMargin - FAColorPickerWheelLabelHeight;
    }
    else
    {
        hueHeight = CGRectGetHeight(self.frame) - FAColorPickerWheelViewGradientViewHeight - FAColorPickerWheelViewGradientViewHeight - FAColorPickerWheelViewDefaultMargin - FAColorPickerWheelViewDefaultMargin - FAColorPickerWheelViewGradientTopMargin - FAColorPickerWheelViewDefaultMargin - FAColorPickerWheelLabelHeight;
    }

    self.hueImage.frame = CGRectMake(FAColorPickerWheelViewDefaultMargin,
                                     _hideColorInfo ? FAColorPickerWheelViewDefaultMargin : FAColorPickerWheelViewDefaultMargin + FAColorPickerWheelViewDefaultMargin + FAColorPickerWheelLabelHeight,
                                     CGRectGetWidth(self.frame) - (FAColorPickerWheelViewDefaultMargin * 2),
                                     hueHeight + (_hideColorInfo ? FAColorPickerWheelViewDefaultMargin + FAColorPickerWheelLabelHeight : 0));
    
    self.saturationView.frame = CGRectMake(FAColorPickerWheelViewDefaultMargin,
                                         CGRectGetMaxY(self.hueImage.frame) + FAColorPickerWheelViewDefaultMargin,
                                         CGRectGetWidth(self.frame) - (FAColorPickerWheelViewDefaultMargin * 2),
                                         FAColorPickerWheelViewGradientViewHeight);

    CGFloat brightnessY = (self.saturationView == nil ? CGRectGetMaxY(self.hueImage.frame) + FAColorPickerWheelViewDefaultMargin : CGRectGetMaxY(self.saturationView.frame) + FAColorPickerWheelViewDefaultMargin);
    self.brightnessView.frame = CGRectMake(FAColorPickerWheelViewDefaultMargin,
                                           brightnessY,
                                           CGRectGetWidth(self.frame) - (FAColorPickerWheelViewDefaultMargin * 2),
                                           FAColorPickerWheelViewGradientViewHeight);

    [self updateIndicatorsPosition];
    [self updateColorBubblePosition];
}

- (void) textFieldChanged:(id)sender
{
    NSString* text = [self.rgbTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (text.length == 6)
    {
        UIColor* color = [UIColor colorWithHexString:text];
        if (color != nil)
        {
            [self setColor:color];
        }
    }
}

- (BOOL) textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    return ([textField.text stringByReplacingCharactersInRange:range withString:string].length <= 6);
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return NO;
}

- (void) setColor:(UIColor*)newColor
{
    if (![_color isEqual:newColor])
    {
        [newColor getHue:&_hue saturation:&_saturation brightness:&_brightness alpha:NULL];
        CGColorSpaceModel colorSpaceModel = newColor.colorSpaceModel;
        if (colorSpaceModel == kCGColorSpaceModelMonochrome && newColor != nil)
        {
            const CGFloat* c = CGColorGetComponents(newColor.CGColor);
            _color = [UIColor colorWithHue:0 saturation:0 brightness:c[0] alpha:1.0];
        }
        else
        {
            _color = [newColor copy];
        }
        
        if (self.colorChangedBlock != nil)
        {
            self.colorChangedBlock(self.color);
        }

        self.colorPreviewView.backgroundColor = newColor;
        NSString* hex = newColor.hexStringFromColorNoAlpha;
        if ([hex caseInsensitiveCompare:self.rgbTextField.text] != NSOrderedSame)
        {
            self.rgbTextField.text = hex;
        }

        [self updateIndicatorsColor];
        [self updateIndicatorsPosition];
        [self updateColorBubblePosition];
    }
}

- (void) updateIndicatorsPosition
{
    [self.color getHue:nil saturation:&_saturation brightness:&_brightness alpha:nil];
    
    CGPoint brightnessPosition;
    brightnessPosition.x = (1.0f - self.brightness) * self.brightnessView.frame.size.width + self.brightnessView.frame.origin.x;
    brightnessPosition.y = self.brightnessView.center.y;
    
    self.brightnessIndicator.center = brightnessPosition;

    CGPoint saturationPosition;
    saturationPosition.x = (1.0f - self.saturation) * self.saturationView.frame.size.width + self.saturationView.frame.origin.x;
    saturationPosition.y = self.saturationView.center.y;

    self.saturationIndicator.center = saturationPosition;
}

- (void) setColorBubblePosition:(CGPoint)p
{
    self.colorBubble.center = p;
}

- (void) updateColorBubblePosition
{
    CGPoint hueSatPosition;
    
    hueSatPosition.x = (self.hue * self.hueImage.frame.size.width) + self.hueImage.frame.origin.x;
    hueSatPosition.y = (1.0f - self.saturation) * self.hueImage.frame.size.height + self.hueImage.frame.origin.y;
    [self setColorBubblePosition:hueSatPosition];
    [self updateIndicatorsColor];
}

- (void) updateIndicatorsColor
{
    UIColor* brightnessColor1 = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:1.0f alpha:1.0f];
    UIColor* brightnessColor2 = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.0f alpha:1.0f];
    self.colorBubble.backgroundColor = brightnessColor1;
	[self.brightnessView setColor1:brightnessColor1];
	[self.brightnessView setColor2:brightnessColor2];

    UIColor* saturationColor1 = [UIColor colorWithHue:self.hue saturation:0.0f brightness:1.0f alpha:1.0f];
    UIColor* saturationColor2 = [UIColor colorWithHue:self.hue saturation:1.0f brightness:1.0f alpha:1.0f];
    [self.saturationView setColor1:saturationColor2];
    [self.saturationView setColor2:saturationColor1];
}

- (void) updateHueWithMovement:(CGPoint)position
{
	self.hue = (position.x - self.hueImage.frame.origin.x) / self.hueImage.frame.size.width;
	self.saturation = 1.0f -  (position.y - self.hueImage.frame.origin.y) / self.hueImage.frame.size.height;
    
	UIColor* topColor = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:self.brightness alpha:1.0f];
    UIColor* gradientColor = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:1.0f alpha:1.0f];
    self.colorBubble.backgroundColor = gradientColor;
    [self updateIndicatorsColor];
    [self setColor:topColor];
}

- (void) updateBrightnessWithMovement:(CGPoint)position
{
	self.brightness = 1.0f - ((position.x - self.brightnessView.frame.origin.x) / self.brightnessView.frame.size.width);
	
	UIColor* topColor = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:self.brightness alpha:1.0f];
    [self setColor:topColor];
}

- (void) updateSaturationWithMovement:(CGPoint)position
{
    self.saturation = 1.0f - ((position.x - self.saturationView.frame.origin.x) / self.saturationView.frame.size.width);

    UIColor* topColor = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:self.brightness alpha:1.0f];
    [self setColor:topColor];
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    [super touchesBegan:touches withEvent:event];

	for (UITouch* touch in touches)
    {
		[self handleTouchEvent:[touch locationInView:self]];
    }
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    [super touchesMoved:touches withEvent:event];

	for (UITouch* touch in touches)
    {
		[self handleTouchEvent:[touch locationInView:self]];
	}
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesEnded:touches withEvent:event];
	
	self.focusView = nil;
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];

    self.focusView = nil;
}

- (void) handleTouchEvent:(CGPoint)position
{
	if (self.focusView == self.hueImage || (self.focusView == nil && CGRectContainsPoint(self.hueImage.frame,position)))
    {
		position.x = MIN(MAX(CGRectGetMinX(self.hueImage.frame), position.x), CGRectGetMaxX(self.hueImage.frame) - 1);
		position.y = MIN(MAX(CGRectGetMinY(self.hueImage.frame), position.y), CGRectGetMaxY(self.hueImage.frame) - 1);
		self.focusView = self.hueImage;
		[self setColorBubblePosition:position];
		[self updateHueWithMovement:position];
	}
    else if (self.focusView == self.brightnessView || (self.focusView == nil && CGRectContainsPoint(self.brightnessView.frame, position)))
    {
        position.x = MIN(MAX(CGRectGetMinX(self.brightnessView.frame), position.x), CGRectGetMaxX(self.brightnessView.frame) - 1);
        position.y = MIN(MAX(CGRectGetMinY(self.brightnessView.frame), position.y), CGRectGetMaxY(self.brightnessView.frame) - 1);
		self.focusView = self.brightnessView;
        self.brightnessIndicator.center = CGPointMake(position.x, self.brightnessView.center.y);
		[self updateBrightnessWithMovement:position];
	}
    else if (self.saturationView != nil && (self.focusView == self.saturationView || (self.focusView == nil && CGRectContainsPoint(self.saturationView.frame, position))))
    {
        position.x = MIN(MAX(CGRectGetMinX(self.saturationView.frame), position.x), CGRectGetMaxX(self.saturationView.frame) - 1);
        position.y = MIN(MAX(CGRectGetMinY(self.saturationView.frame), position.y), CGRectGetMaxY(self.saturationView.frame) - 1);
		self.focusView = self.saturationView;
        self.saturationIndicator.center = CGPointMake(position.x, self.saturationView.center.y);
        [self updateSaturationWithMovement:position];
    }
}

@end

