//
//  RegisterView.m
//  HYMusic_Login
//
//  Created by evan on 2020/2/24.
//  Copyright © 2020 evan. All rights reserved.
//

#import "RegisterView.h"
#import "LoginViewFactory.h"
#import <WHToast/WHToast.h>
//开发环境枚举
typedef NS_ENUM(NSInteger,TextFieldType){
    TextFieldPhone = 0,
    TextFieldValidation,
    TextFieldInputPassword,
    TextFieldAgainPassword
};
@interface RegisterView()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneValidationTextField;
@property (weak, nonatomic) IBOutlet UITextField *inputPassword;
@property (weak, nonatomic) IBOutlet UITextField *againPassword;
@property (weak, nonatomic) IBOutlet UIButton *validationButton;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *validation;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *repeatPassword;

@end
@implementation RegisterView
static NSInteger CountDown = 60;
static NSInteger CountDownTime = 60;

+ (instancetype)showRegisterView{
    
    RegisterView *registerView = [[[NSBundle mainBundle]loadNibNamed:@"registerView" owner:nil options:nil] firstObject];
    
    [registerView.phoneTextField setTag:TextFieldPhone];
    [registerView.phoneValidationTextField setTag:TextFieldValidation];
    [registerView.inputPassword setTag:TextFieldInputPassword];
    [registerView.againPassword setTag:TextFieldAgainPassword];

    registerView.phoneTextField.delegate = registerView;
    registerView.phoneValidationTextField.delegate = registerView;
    registerView.inputPassword.delegate = registerView;
    registerView.againPassword.delegate = registerView;
    
    registerView.phone = @"";
    registerView.validation = @"";
    registerView.password = @"";
    registerView.repeatPassword = @"";

    return registerView;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setFrame:[UIScreen mainScreen].bounds];
    NSLog(@"来了这里---awakeFromNib");
    

}
#pragma mark -- textFieldDelegate
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
        case TextFieldValidation:
        {
            self.validation = text;
        }
            break;
        case TextFieldInputPassword:
        {
            self.password = text;

        }
            break;
        case TextFieldAgainPassword:
        {
            self.repeatPassword = text;

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
#pragma mark -- 逻辑处理
-(void)timeFireMethod:(NSTimer *)countDownTimer{
//倒计时-1
    CountDown--;
//修改倒计时标签现实内容
    [self.validationButton setTitle:[NSString stringWithFormat:@"%lds后重新获取",CountDown] forState:UIControlStateNormal];
//当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(CountDown == 0){
        [countDownTimer invalidate];
        [self.validationButton setTitle:@"重新获取" forState:UIControlStateNormal];
        CountDown = CountDownTime;
        [self.validationButton setEnabled:true];

    }
}
#pragma mark -- button action
- (IBAction)back:(UIButton *)sender {
    [self endEditing:true];
    if ([self.delegate respondsToSelector:@selector(hideRegister)]) {
        [self.delegate hideRegister];
    }
}
- (IBAction)sendValidation:(UIButton *)sender {
    BOOL isSend = [LoginViewFactory valiMobile:self.phone];
    if (!isSend) {
        return;
    }
    [sender setEnabled:false];
    [sender setTitle:[NSString stringWithFormat:@"%lds",CountDownTime] forState:UIControlStateNormal];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod:) userInfo:nil repeats:YES];
    if ([self.delegate respondsToSelector:@selector(sendSMS:)]) {
        [self.delegate sendSMS:@{@"action":@"register",@"phone":self.phone}];
       }
    
}
- (IBAction)onOrOffInputPassword:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.inputPassword.secureTextEntry = !self.inputPassword.secureTextEntry;
}
- (IBAction)onOrOffAgainPassword:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.againPassword.secureTextEntry = !self.againPassword.secureTextEntry;

}
- (IBAction)registerUser:(UIButton *)sender {
    [self endEditing:true];

    if ([self.phone length] < 11) {
        [WHToast showMessage:ZYPhoneError duration:2.0 finishHandler:nil];
        return;
    }
    if ([self.validation length] < 1) {
        [WHToast showMessage:ZYValidateError duration:2.0 finishHandler:nil];
               return;
    }
    if (([self.password length] < 6 && [self.password length] > 10)|| ([self.repeatPassword length] < 6 && [self.repeatPassword length] > 10)) {
        [WHToast showMessage:ZYPasswordLengthError duration:2.0 finishHandler:nil];
        return;
    }
    if (![self.password isEqualToString:self.repeatPassword]) {
        [WHToast showMessage:ZYPasswordContrastError duration:2.0 finishHandler:nil];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(registerUserWithParams:)]) {
        [self.delegate registerUserWithParams:@{@"username":self.phone,@"password":self.password,@"confirm_password":self.repeatPassword,@"code":self.validation}];
    }
    
}

@end
