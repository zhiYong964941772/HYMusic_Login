//
//  CTMediator+HYLogin.h
//  HYMusic_Login
//
//  Created by evan on 2020/3/2.
//  Copyright © 2020 evan. All rights reserved.
//


#import <CTMediator/CTMediator.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (HYLogin)
- (void)qqLogin;
- (void)wxLogin;
- (void)wbLogin;
@end

NS_ASSUME_NONNULL_END
