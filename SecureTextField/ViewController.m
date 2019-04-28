//
//  ViewController.m
//  SecureTextField
//
//  Created by Batıkan Sosun on 25.04.2019.
//  Copyright © 2019 Batıkan Sosun. All rights reserved.
//

#import "ViewController.h"
#import "SecureTextField.h"


@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet SecureTextField *texttfieldWithSB;
@property(strong, nonatomic) SecureTextField *textfieldSecure;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.textfieldSecure = [[SecureTextField alloc] initWithFrame:CGRectMake(62, 150, 250, 30)];
    
    _textfieldSecure.colorFilledCircle = [UIColor redColor];
    _textfieldSecure.colorStrokeBottom = [UIColor redColor];
    _textfieldSecure.numberOfCircle = 6;
    _textfieldSecure.delegate = self;
    [self.view addSubview:_textfieldSecure];
    
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}


@end
