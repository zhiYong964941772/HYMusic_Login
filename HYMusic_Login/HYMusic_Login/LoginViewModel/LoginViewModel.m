//
//  LoginViewModel.m
//  HYMusic_Login
//
//  Created by evan on 2020/2/25.
//  Copyright © 2020 evan. All rights reserved.
//

#import "LoginViewModel.h"
#import <ZYNetworkingConfiguration.h>
#import "ResetAPIManager.h"
#import "RegisterAPIManager.h"

@interface LoginViewModel()<ZYAPIManagerDataReformer>
@end
@implementation LoginViewModel
NSString * const ZYPropertyListDataKeyValidationImage = @"ZYPropertyListDataKeyValidationImage";
NSString * const ZYPropertyListDataKeySMSValidation = @"ZYPropertyListDataKeySMSValidation";
NSString * const ZYPropertyListDataKeyValidationID = @"ZYPropertyListDataKeyValidationID";

- (NSDictionary *)manager:(ZYAPIBaseManager *)manager reformData:(NSDictionary *)data{
    NSDictionary *dic = data[@"data"];
    NSDictionary *resultData = @{
        ZYPropertyListDataKeyValidationImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"image"]]]],
        ZYPropertyListDataKeyValidationID:dic[@"id"]
    };

   
   
    return resultData;
}
@end
