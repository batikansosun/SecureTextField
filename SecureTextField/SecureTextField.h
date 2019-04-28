//
//  SecureTextField.h
//  SecureTextField
//
//  Created by Batıkan Sosun on 28.04.2019.
//  Copyright © 2019 Batıkan Sosun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecureTextField : UITextField
@property(assign,nonatomic) IBInspectable NSInteger numberOfCircle;
@property(strong,nonatomic) IBInspectable UIColor *colorFilledCircle;
@property(strong,nonatomic) IBInspectable UIColor *colorStrokeCircle;
@property(strong,nonatomic) IBInspectable UIColor *colorEmptyCircle;
@property(strong,nonatomic) IBInspectable UIColor *colorStrokeBottom;
@end

NS_ASSUME_NONNULL_END
