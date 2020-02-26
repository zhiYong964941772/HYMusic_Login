//
//  resetView.m
//  HYMusic_Login
//
//  Created by evan on 2020/2/24.
//  Copyright © 2020 evan. All rights reserved.
//

#import "resetView.h"
#import "LoginViewFactory.h"
#import <WHToast.h>
#import "LoginViewModel.h"

//开发环境枚举
typedef NS_ENUM(NSInteger,TextFieldType){
    TextFieldPhone = 0,
    TextFieldValidation,
    TextFieldLetterValidation,
    TextFieldInputPassword,
    TextFieldAgainPassword
};
@interface resetView()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *letterValidationTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneValidationTextField;

@property (weak, nonatomic) IBOutlet UIButton *validationButton;
@property (weak, nonatomic) IBOutlet UIButton *letterButton;


@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *validation;
@property (strong, nonatomic) NSString *imageValidation;
@property (strong, nonatomic) NSString *imageValidationID;




@end
@implementation resetView
static NSInteger CountDown = 60;
static NSInteger CountDownTime = 60;
+ (instancetype)showResetView{
    resetView *resetView = [[[NSBundle mainBundle]loadNibNamed:@"resetView" owner:nil options:nil] firstObject];
    
    [resetView.phoneTextField setTag:TextFieldPhone];
    [resetView.phoneValidationTextField setTag:TextFieldValidation];
    [resetView.letterValidationTextField setTag:TextFieldLetterValidation];

    resetView.phoneTextField.delegate = resetView;
    resetView.phoneValidationTextField.delegate = resetView;
    resetView.letterValidationTextField.delegate = resetView;

    resetView.phone = @"";
    resetView.validation = @"";
    resetView.imageValidation = @"";
    resetView.imageValidationID = @"";
    
    return resetView;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setFrame:[UIScreen mainScreen].bounds];
    NSLog(@"来了这里---awakeFromNib");
    

}
- (void)configWithData:(NSDictionary *)data{
    self.imageValidationID = data[ZYPropertyListDataKeyValidationID];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.letterButton setBackgroundImage:data[ZYPropertyListDataKeyValidationImage] forState:UIControlStateNormal];
    });
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
       

        case TextFieldLetterValidation:
        {
            self.imageValidation = text;

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

#pragma mark -- buttonAction

- (IBAction)back:(UIButton *)sender {
    [self endEditing:true];
    if ([self.delegate respondsToSelector:@selector(hideReset)]) {
        [self.delegate hideReset];
    }
}
- (IBAction)refreshValidation:(UIButton *)sender {
    [self updateImageValidation];
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
           [self.delegate sendSMS:@{@"action":@"forgot",@"phone":self.phone}];
          }
}
- (IBAction)changePassword:(UIButton *)sender {
    [self endEditing:true];

    if ([self.phone length] < 11) {
        [WHToast showMessage:ZYPhoneError duration:2.0 finishHandler:nil];
        return;
    }
    if ([self.validation length] < 1 || [self.imageValidation length] < 1) {
        [WHToast showMessage:ZYValidateError duration:2.0 finishHandler:nil];
               return;
    }
    if ([self.delegate respondsToSelector:@selector(sendSMS:)]) {
        [self.delegate resetWithParams:@{@"CaptchaId":self.imageValidationID,@"phone":self.phone,@"CaptchaCode":self.imageValidation,@"SmsCode":self.validation}];
    }
    
}
- (void)updateImageValidation{
    if ([self.delegate respondsToSelector:@selector(sendImageValidation)]) {
        [self.delegate sendImageValidation];
    }
}
@end
