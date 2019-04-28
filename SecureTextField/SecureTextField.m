//
//  SecureTextField.m
//  SecureTextField
//
//  Created by Batıkan Sosun on 28.04.2019.
//  Copyright © 2019 Batıkan Sosun. All rights reserved.
//

#import "SecureTextField.h"

static CGFloat const  kLineWidth = 1.0f;
static CGFloat const  kWidth = 7.0f;
static CGFloat const  kHeight = 7.0f;
static CGFloat const  kBeetweenSpace = 4.0f;

@interface SecureTextField()<UITextFieldDelegate>
@property(weak, nonatomic) id<UITextFieldDelegate> realDelegate;
@end

@implementation SecureTextField

#pragma mark - Init
- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate{
    self.realDelegate = delegate;
}



- (void)setUp{
    self.backgroundColor = [UIColor whiteColor];
    self.textColor = [UIColor clearColor];;
    self.tintColor = [UIColor clearColor];;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.borderStyle = UITextBorderStyleNone;
    
    [super setDelegate:self];
}

#pragma mark - Override
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return NO;
}

#pragma mark - Setters
- (void)setNumberOfCircle:(NSInteger)numberOfCircle{
    _numberOfCircle = numberOfCircle;
    if (numberOfCircle>0) {
        for (int i=0; i<numberOfCircle; i++) {
            
            float x = i== 0 ? kLineWidth : i*(kWidth + kBeetweenSpace + 2.0f*kLineWidth);
            float y = self.frame.size.height/2.0f;
            
            CAShapeLayer *layer = [self drawCircleWithWidth:kWidth height:kHeight strokeWidth:kLineWidth strokeColor:self.colorStrokeCircle filledColor:self.colorEmptyCircle position:CGPointMake(x, y)];
            
            [[self layer] addSublayer:layer];
        }
        CGRect rect = CGRectMake(0, self.frame.size.height-1.0f, self.frame.size.width, 1.0f);
        UIView *line = [[UIView alloc] initWithFrame:rect];
        line.backgroundColor = self.colorStrokeBottom;
        [self insertSubview:line atIndex:self.numberOfCircle+1];
    }
}
#pragma mark - Getters
- (UIColor *)colorFilledCircle{
    if (!_colorFilledCircle) {
        _colorFilledCircle = [UIColor grayColor];
    }
    return _colorFilledCircle;
}
- (UIColor *)colorStrokeCircle{
    if (!_colorStrokeCircle) {
        _colorStrokeCircle = [UIColor grayColor];
    }
    return _colorStrokeCircle;
}
- (UIColor *)colorEmptyCircle{
    if (!_colorEmptyCircle) {
        _colorEmptyCircle = [UIColor clearColor];
    }
    return _colorEmptyCircle;
}
- (UIColor *)colorStrokeBottom{
    if (!_colorStrokeBottom) {
        _colorStrokeBottom = [UIColor blueColor];
    }
    return _colorStrokeBottom;
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.realDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.realDelegate textFieldShouldBeginEditing:textField];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([self.realDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.realDelegate textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([self.realDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.realDelegate textFieldShouldEndEditing:textField];
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.realDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.realDelegate textFieldDidEndEditing:textField];
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if ([self.realDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        
        for (int i = 0; i<=self.numberOfCircle; i++) {
            
            float x = i== 0 ? kLineWidth : i*(kWidth + kBeetweenSpace + 2.0f*kLineWidth);
            float y = self.frame.size.height/2.0f;
            
            CAShapeLayer *circleLayer = [self drawCircleWithWidth:kWidth height:kHeight strokeWidth:kLineWidth strokeColor:self.colorStrokeCircle filledColor:nil position:CGPointMake(x, y)];
            
            if (i>=0 && i<self.numberOfCircle && [[[textField layer] sublayers] objectAtIndex:i] != nil) {
                [[textField layer] replaceSublayer:[[[textField layer] sublayers] objectAtIndex:i] with:circleLayer];
            }
        }
        
        return [self.realDelegate textFieldShouldClear:textField];
        
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([self.realDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.realDelegate textFieldShouldReturn:textField];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSUInteger newLength = textField.text.length + string.length;
    newLength = newLength - range.length;
    
    if ([self.realDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        BOOL delegateResponse = [self.realDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
        
        if (!delegateResponse) {
            return NO;
        }
        
        int i = (int)((textField.text.length + string.length) -1);
        
        float x = i== 0 ? kLineWidth : i*(kWidth + kBeetweenSpace + 2.0f*kLineWidth);
        float y = textField.frame.size.height/2.0f;
        
        CAShapeLayer *circleLayer = [self drawCircleWithWidth:kWidth height:kHeight strokeWidth:kLineWidth strokeColor:self.colorStrokeCircle filledColor:self.colorFilledCircle position:CGPointMake(x, y)];
        
        if (!range.length) {
            [circleLayer setFillColor:self.colorFilledCircle.CGColor];
            [circleLayer setStrokeColor:self.colorFilledCircle.CGColor];
        }else{
            [circleLayer setFillColor:self.colorEmptyCircle.CGColor];
            [circleLayer setStrokeColor:self.colorStrokeCircle.CGColor];
        }
        if (i>=0 && i<self.numberOfCircle && [[[textField layer] sublayers] objectAtIndex:i] != nil) {
            [[textField layer] replaceSublayer:[[[textField layer] sublayers] objectAtIndex:i] with:circleLayer];
        }
        
        return (newLength <= self.numberOfCircle) ? YES : NO;
        
    }
    return YES;
}

#pragma mark - Layer
-(CAShapeLayer *)drawCircleWithWidth:(float)width height:(float)height strokeWidth:(float)strokeWidth strokeColor:(UIColor *)strokeColor filledColor:(nullable UIColor *)filledColor position:(CGPoint )point{
    
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    
    [circleLayer setBounds:CGRectMake(point.x, point.y, width, height)];
    [circleLayer setPosition:CGPointMake(point.x+width/2.0f, point.y)];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(point.x, point.y, width, height)];
    [circleLayer setPath:[path CGPath]];
    [circleLayer setFillColor:filledColor.CGColor];
    [circleLayer setStrokeColor:strokeColor.CGColor];
    [circleLayer setLineWidth:strokeWidth];
    
    return circleLayer;
}

@end
