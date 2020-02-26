//
//  Target_ZYAppContext.m
//  HYMusic_Login
//
//  Created by evan on 2020/1/19.
//  Copyright © 2020 evan. All rights reserved.
//

#import "Target_ZYAppContext.h"

@implementation Target_ZYAppContext
- (BOOL)Action_isReachable:(NSDictionary *)params
{
    return YES;
}

- (BOOL)Action_shouldPrintNetworkingLog:(NSDictionary *)params
{
    return YES;
}

- (NSInteger)Action_cacheResponseCountLimit:(NSDictionary *)params
{
    return 2;
}

@end
