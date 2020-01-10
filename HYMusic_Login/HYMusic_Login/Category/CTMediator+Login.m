//
//  CTMediator+Login.m
//  HYMusic_Login_Category
//
//  Created by evan on 2020/1/10.
//  Copyright © 2020 evan. All rights reserved.
//

#import "CTMediator+Login.h"


@implementation CTMediator (Login)
- (UIViewController *)A_aViewController{
    return [self performTarget:@"A" action:@"viewController" params:nil shouldCacheTarget:false];
}
@end
