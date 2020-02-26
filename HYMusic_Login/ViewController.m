//
//  ViewController.m
//  HYMusic_Login
//
//  Created by evan on 2020/1/10.
//  Copyright © 2020 evan. All rights reserved.
//

#import "ViewController.h"
#import "CTMediator+Login.h"
#import "LoginViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 100, 100)];
    [btn setTitle:@"打开登录界面" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn addTarget:self action:@selector(openLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)openLogin:(UIButton *)sender{
    UIViewController *loginVC = [[CTMediator sharedInstance] showLoginViewController];
    loginVC.modalPresentationStyle = 0;
    [self presentViewController:loginVC animated:true completion:nil];
}

@end
