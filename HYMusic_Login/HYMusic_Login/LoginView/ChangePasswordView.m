//
//  ChangePasswordView.m
//  HYMusic_Login
//
//  Created by evan on 2020/2/26.
//  Copyright © 2020 evan. All rights reserved.
//

#import "ChangePasswordView.h"
#import "LoginViewFactory.h"
#import <WHToast/WHToast.h>

//开发环境枚举
typedef NS_ENUM(NSInteger,TextFieldType){
    TextFieldInputPassword,
    TextFieldAgainPassword
};
@interface ChangePasswordView()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *againTextField;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *repeatPassword;
@end

@implementation ChangePasswordView
+ (instancetype)showChangeView{
    ChangePasswordView *changeView = [[[NSBundle mainBundle]loadNibNamed:@"ChangePassword" owner:nil options:nil] firstObject];
    [changeView.inputTextField setTag:TextFieldInputPassword];
    [changeView.againTextField setTag:TextFieldAgainPassword];
    
    changeView.inputTextField.delegate = changeView;
    changeView.againTextField.delegate = changeView;

    changeView.password = @"";
    changeView.repeatPassword = @"";
    changeView.token = @"";
     return changeView;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setFrame:[UIScreen mainScreen].bounds];
    NSLog(@"来了这里---awakeFromNib");
    

}
#pragma mark -- textFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return [LoginViewFactory validatePassword:string];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *text = textField.text;
    switch (textField.tag) {
        
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
- (IBAction)change:(UIButton *)sender {
   [self endEditing:true];
    if (([self.password length] < 6 && [self.password length] > 10)|| ([self.repeatPassword length] < 6 && [self.repeatPassword length] > 10)) {
        [WHToast showMessage:ZYPasswordLengthError duration:2.0 finishHandler:nil];
        return;
    }
    if (![self.password isEqualToString:self.repeatPassword]) {
        [WHToast showMessage:ZYPasswordContrastError duration:2.0 finishHandler:nil];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(changePasswordWithParams:)]) {
        [self.delegate changePasswordWithParams:@{@"token":self.token,@"password":self.password,@"ConfirmPassword":self.repeatPassword}];
    }
//       @{@"username":self.phone,@"password":self.password,@"confirm_password":self.repeatPassword,@"code":self.validation}
}
- (IBAction)onOrOffInput:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.inputTextField.secureTextEntry = !self.inputTextField.secureTextEntry;
}
- (IBAction)onOrOffAgain:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.againTextField.secureTextEntry = !self.againTextField.secureTextEntry;
}
- (IBAction)changeBack:(UIButton *)sender {
    [self endEditing:true];
    if ([self.delegate respondsToSelector:@selector(hideChangePassword)]) {
        [self.delegate hideChangePassword];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
