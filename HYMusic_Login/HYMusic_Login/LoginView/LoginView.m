//
//  LoginView.m
//  HYMusic_Login
//
//  Created by evan on 2020/1/19.
//  Copyright © 2020 evan. All rights reserved.
//

#import "LoginView.h"
#import "LoginViewFactory.h"
#import <WHToast/WHToast.h>
#import "LoginViewModel.h"

//开发环境枚举
typedef NS_ENUM(NSInteger,TextFieldType){
    TextFieldPhone = 0,
    TextFieldImageValidation,
    TextFieldInputPassword
};
@interface LoginView()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *validationTextField;
@property (weak, nonatomic) IBOutlet UIButton *imageValidationButton;

@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *imageValidation;
@property (strong, nonatomic) NSString *imageValidationID;
@property (strong, nonatomic) NSString *password;

@end
@implementation LoginView

+ (instancetype)showLoginView{
    LoginView *loginView = [[[NSBundle mainBundle]loadNibNamed:@"HYLoginView" owner:nil options:nil] firstObject];

    [loginView.phoneTextField setTag:TextFieldPhone];
    [loginView.validationTextField setTag:TextFieldImageValidation];
    [loginView.passwordTextField setTag:TextFieldInputPassword];
    
    loginView.phoneTextField.delegate = loginView;
    loginView.passwordTextField.delegate = loginView;
    loginView.validationTextField.delegate = loginView;
    

    loginView.imageValidationID = @"";
    loginView.imageValidation = @"";
    loginView.password = @"";
    loginView.phone = @"";
    
    return loginView;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setFrame:[UIScreen mainScreen].bounds];
    NSLog(@"来了这里---awakeFromNib");
    

}
- (void)configWithData:(NSDictionary *)data{
    self.imageValidationID = data[ZYPropertyListDataKeyValidationID];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.imageValidationButton setBackgroundImage:data[ZYPropertyListDataKeyValidationImage] forState:UIControlStateNormal];
    });
}
#pragma mark --- textfieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    switch (textField.tag) {
        case TextFieldPhone:
        {
            return [LoginViewFactory validateNumber:string];
        }
            break;
        default:{
            return [LoginViewFactory validatePassword:string];

        }
            break;
    }
    return true;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *text = textField.text;
    switch (textField.tag) {
        case TextFieldPhone:
        {
            self.phone = text;
        }
        
            break;
        case TextFieldImageValidation:
        {
            self.imageValidation = text;
        }
            break;
        case TextFieldInputPassword:
        {
            self.password = text;

        }
            break;
       
        default:
            break;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

#pragma mark --- button action

- (IBAction)onOrOffPassword:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.passwordTextField.secureTextEntry = !self.passwordTextField.secureTextEntry;
}
- (IBAction)refreshValidation:(UIButton *)sender {
    [self updateImageValidation];

}
- (IBAction)registerUser:(UIButton *)sender {
    [self endEditing:true];
    if ([self.delegate respondsToSelector:@selector(showRegister)]) {
        [self.delegate showRegister];
    }
}
- (IBAction)resetPassword:(UIButton *)sender {
    [self endEditing:true];
    if ([self.delegate respondsToSelector:@selector(showReset)]) {
        [self.delegate showReset];
    }
}
- (IBAction)wxLogin:(UIButton *)sender {
    [self endEditing:true];

}
- (IBAction)qqLogin:(UIButton *)sender {
    [self endEditing:true];

}
- (IBAction)wbLogin:(UIButton *)sender {
    [self endEditing:true];

}
- (IBAction)touristsLogin:(UIButton *)sender {
    [self endEditing:true];

}
- (IBAction)login:(UIButton *)sender {
    if ([self.phone length] < 11) {
        [WHToast showMessage:ZYPhoneError duration:2.0 finishHandler:nil];
        return;
    }
    if ([self.imageValidation length] < 1) {
        [WHToast showMessage:ZYValidateError duration:2.0 finishHandler:nil];
               return;
    }
    if (([self.password length] < 6 && [self.password length] > 10)) {
        [WHToast showMessage:ZYPasswordLengthError duration:2.0 finishHandler:nil];
        return;
    }
   
    if ([self.delegate respondsToSelector:@selector(loginWithParams:)]) {
        [self.delegate loginWithParams:@{@"username":self.phone,@"password":self.password,@"CaptchaId":self.imageValidationID,@"CaptchaCode":self.imageValidation}];
    }
}
- (void)updateImageValidation{
    if ([self.delegate respondsToSelector:@selector(sendImageValidation)]) {
        [self.delegate sendImageValidation];
    }
}
@end
