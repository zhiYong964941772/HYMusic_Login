//
//  Target_Login.m
//  HYMusic_Login
//
//  Created by evan on 2020/2/24.
//  Copyright © 2020 evan. All rights reserved.
//

#import "Target_Login.h"
#import "LoginViewController.h"
@implementation Target_Login
- (UIViewController *)Action_viewController:(NSDictionary *)params{
    LoginViewController *viewController = [[LoginViewController alloc]init];
    return viewController;
}
@end
