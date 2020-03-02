//
//  CTMediator+HYLogin.m
//  HYMusic_Login
//
//  Created by evan on 2020/3/2.
//  Copyright © 2020 evan. All rights reserved.
//

#import "CTMediator+HYLogin.h"



@implementation CTMediator (HYLogin)
- (void)qqLogin{
    [self performTarget:@"Authorization" action:@"qqLogin" params:nil shouldCacheTarget:false];

}
- (void)wxLogin{
    [self performTarget:@"Authorization" action:@"wxLogin" params:nil shouldCacheTarget:false];

}
- (void)wbLogin{
    [self performTarget:@"Authorization" action:@"wbLogin" params:nil shouldCacheTarget:false];
}
@end
