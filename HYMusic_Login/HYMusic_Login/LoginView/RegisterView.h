//
//  RegisterView.h
//  HYMusic_Login
//
//  Created by evan on 2020/2/24.
//  Copyright © 2020 evan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol registerDelegate <NSObject>
- (void)hideRegister;
- (void)registerUserWithParams:(NSDictionary *)params;
- (void)sendSMS:(NSDictionary *)params;

@end
@interface RegisterView : UIView
+ (instancetype)showRegisterView;
- (void)configWithData:(NSDictionary *)data;
@property(nonatomic,weak)id<registerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
