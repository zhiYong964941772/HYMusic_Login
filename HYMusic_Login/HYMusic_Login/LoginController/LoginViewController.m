//
//  LoginViewController.m
//  HYMusic_Login
//
//  Created by evan on 2020/1/19.
//  Copyright © 2020 evan. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RegisterView.h"
#import "resetView.h"
#import "ChangePasswordView.h"
#import "LoginAPIManager.h"
#import "SMSAPIManager.h"
#import "RegisterAPIManager.h"
#import "ResetAPIManager.h"
#import "CHangePasswordAPIManager.h"
#import "ValidationAPIManager.h"
#import "LoginViewModel.h"
#import <WHToast.h>
@interface LoginViewController ()<loginDelegate,registerDelegate,resetDelegate,ZYAPIManagerCallBackDelegate,ChangePasswordDelegate>
@property(nonatomic ,weak)LoginView *loginView;
@property(nonatomic ,weak)RegisterView *registerView;
@property(nonatomic ,weak)resetView *resetView;
@property(nonatomic ,weak)ChangePasswordView *changePasswordView;

@property (nonatomic, strong) LoginAPIManager *loginAPIManager;
@property (nonatomic, strong) SMSAPIManager *smsAPIManager;
@property (nonatomic, strong) RegisterAPIManager *registerAPIManager;
@property (nonatomic, strong) ResetAPIManager *resetAPIManager;
@property (nonatomic, strong) CHangePasswordAPIManager *changePasswordAPIManager;
@property (nonatomic, strong) ValidationAPIManager *validationAPIManager;

@property (nonatomic, strong) LoginViewModel <ZYAPIManagerDataReformer> *loginModel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.changePasswordView = [ChangePasswordView showChangeView];
    self.registerView = [RegisterView showRegisterView];
    self.resetView = [resetView showResetView];
    self.loginView = [LoginView showLoginView];

    self.resetView.delegate = self;
    self.loginView.delegate = self;
    self.registerView.delegate = self;
    self.changePasswordView.delegate = self;
    
    [self.view addSubview:self.changePasswordView];
    [self.view addSubview:self.resetView];
    [self.view addSubview:self.registerView];
    [self.view addSubview:self.loginView];

    [self sendImageValidation];

}

#pragma mark -- loginDelegate
- (void)showRegister{
    [self.loginView setAlpha:0.0];
    [self.registerView setAlpha:1.0];
    [self.resetView setAlpha:0.0];
    [self.changePasswordView setAlpha:0.0];

}
- (void)showReset{
    [self.loginView setAlpha:0.0];
    [self.registerView setAlpha:0.0];
    [self.resetView setAlpha:1.0];
    [self.changePasswordView setAlpha:0.0];
    [self.resetView updateImageValidation];

}
- (void)loginWithParams:(NSDictionary *)params{
    [self.loginAPIManager loadDataWithParams:params];
}
#pragma mark -- resetDelegate
- (void)hideReset{
    [self.loginView setAlpha:1.0];
    [self.registerView setAlpha:0.0];
    [self.resetView setAlpha:0.0];
    [self.changePasswordView setAlpha:0.0];
    [self sendImageValidation];


}
- (void)resetWithParams:(NSDictionary *)params{
    [self.resetAPIManager loadDataWithParams:params];
}
- (void)sendImageValidation{
    [self.validationAPIManager loadData];
}
- (void)showChangeView{
    [self.loginView setAlpha:0.0];
    [self.registerView setAlpha:0.0];
    [self.resetView setAlpha:0.0];
    [self.changePasswordView setAlpha:1.0];
}
#pragma mark -- registerDelegate
- (void)hideRegister{
    [self.loginView setAlpha:1.0];
    [self.registerView setAlpha:0.0];
    [self.resetView setAlpha:0.0];
    [self.changePasswordView setAlpha:0.0];

}
- (void)registerUserWithParams:(NSDictionary *)params{
    [self.loginAPIManager loadDataWithParams:params];
    
}
- (void)sendSMS:(NSDictionary *)params{
    [self.smsAPIManager loadDataWithParams:params];
}
#pragma makr - changeViewDelegate
- (void)hideChangePassword{
    [self showReset];
}
- (void)changePasswordWithParams:(NSDictionary *)params{
    [self.changePasswordAPIManager loadDataWithParams:params];
}
#pragma mark - managerCallbackDelegate
- (void)managerCallAPIDidSuccess:(ZYAPIBaseManager *)manager{
    if ([manager isKindOfClass:[ValidationAPIManager class]]) {
        [manager fetchDataWithReformer:self.loginModel];
        [self.resetView configWithData:[manager fetchDataWithReformer:self.loginModel]];
        [self.loginView configWithData:[manager fetchDataWithReformer:self.loginModel]];
    }
    if ([manager isKindOfClass:[LoginAPIManager class]]) {
           [WHToast showSuccessWithMessage:@"登录成功" duration:2.0 finishHandler:nil];
       }
    if ([manager isKindOfClass:[ResetAPIManager class]]) {
        [self showChangeView];
        NSDictionary *dic = [manager fetchDataWithReformer:nil][@"data"];
        self.changePasswordView.token = dic[@"token"];
    }
    if ([manager isKindOfClass:[CHangePasswordAPIManager class]]) {
        [WHToast showSuccessWithMessage:@"重置密码成功" duration:2.0 finishHandler:nil];
        [self hideReset];
    }
   
}
- (void)managerCallAPIDidFailed:(ZYAPIBaseManager *)manager{
    NSString *errorMessage = manager.errorMessage;
    if ([manager isKindOfClass:[ResetAPIManager class]]) {
        errorMessage = @"验证码不正确";
        [self sendImageValidation];
       }
    
    [WHToast showErrorWithMessage:errorMessage duration:2.0 finishHandler:nil];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:true];
}
#pragma mark -- setter getter
- (LoginAPIManager *)loginAPIManager{
    if (!_loginAPIManager) {
        _loginAPIManager = [[LoginAPIManager alloc]init];
        _loginAPIManager.delegate = self;
    }
    return _loginAPIManager;
}
- (SMSAPIManager *)smsAPIManager{
    if (!_smsAPIManager) {
        _smsAPIManager = [[SMSAPIManager alloc]init];
        _smsAPIManager.delegate = self;
    }
    return _smsAPIManager;
}
- (RegisterAPIManager *)registerAPIManager{
    if (!_registerAPIManager) {
        _registerAPIManager = [[RegisterAPIManager alloc]init];
        _registerAPIManager.delegate = self;
    }
    return _registerAPIManager;
}
- (ResetAPIManager *)resetAPIManager{
    if (!_resetAPIManager) {
        _resetAPIManager = [[ResetAPIManager alloc]init];
        _resetAPIManager.delegate = self;

    }
    return _resetAPIManager;
}
- (ValidationAPIManager *)validationAPIManager{
    if (!_validationAPIManager) {
        _validationAPIManager = [[ValidationAPIManager alloc]init];
        _validationAPIManager.delegate = self;
    }
    return _validationAPIManager;
}
- (CHangePasswordAPIManager *)changePasswordAPIManager{
    if (!_changePasswordAPIManager) {
        _changePasswordAPIManager = [[CHangePasswordAPIManager alloc]init];
        _changePasswordAPIManager.delegate = self;
    }
    return _changePasswordAPIManager;
}
- (LoginViewModel<ZYAPIManagerDataReformer> *)loginModel{
    if (!_loginModel) {
        _loginModel  = [[LoginViewModel alloc]init];
    }
    return _loginModel;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
