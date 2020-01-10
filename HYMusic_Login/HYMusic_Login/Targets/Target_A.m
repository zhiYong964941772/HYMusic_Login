//
//  Target_A.m
//  HYMusic_Login
//
//  Created by evan on 2020/1/10.
//  Copyright © 2020 evan. All rights reserved.
//

#import "Target_A.h"
#import "AViewController.h"
@implementation Target_A
- (UIViewController *)Action_viewController:(NSDictionary *)params{
    AViewController *viewController = [[AViewController alloc]init];
    return viewController;
}
@end
