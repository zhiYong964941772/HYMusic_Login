//
//  LoginView.h
//  HYMusic_Login
//
//  Created by evan on 2020/1/19.
//  Copyright © 2020 evan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol loginDelegate <NSObject>
- (void)showRegister;
- (void)showReset;
- (void)sendImageValidation;
- (void)loginWithParams:(NSDictionary *)params;
- (void)qqLogin;
- (void)wxLogin;
- (void)wbLogin;
@end
@interface LoginView : UIView
+ (instancetype)showLoginView;
- (void)updateImageValidation;
- (void)configWithData:(NSDictionary *)data;

@property(nonatomic,weak)id<loginDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
