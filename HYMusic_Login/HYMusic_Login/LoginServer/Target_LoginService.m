//
//  Target_LoginService.m
//  HYMusic_Login
//
//  Created by evan on 2020/2/25.
//  Copyright © 2020 evan. All rights reserved.
//

#import "Target_LoginService.h"
NSString *const ZYNetWorkingLoginServiceIdentifier = @"LoginService";
@implementation Target_LoginService
- (LoginService *)Action_LoginService:(NSDictionary *)params{
    return [[LoginService alloc]init];
}
@end
