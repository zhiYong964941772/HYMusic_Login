//
//  Target_ZYAppContext.h
//  HYMusic_Login
//
//  Created by evan on 2020/1/19.
//  Copyright © 2020 evan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_ZYAppContext : NSObject
- (BOOL)Action_shouldPrintNetworkingLog:(NSDictionary *)params;
- (BOOL)Action_isReachable:(NSDictionary *)params;
- (NSInteger)Action_cacheResponseCountLimit:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
