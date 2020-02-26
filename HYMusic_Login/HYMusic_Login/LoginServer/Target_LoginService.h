//
//  Target_LoginService.h
//  HYMusic_Login
//
//  Created by evan on 2020/2/25.
//  Copyright © 2020 evan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginService.h"
NS_ASSUME_NONNULL_BEGIN
extern NSString * const ZYNetWorkingLoginServiceIdentifier;
@interface Target_LoginService : NSObject
- (LoginService *)Action_LoginService:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
