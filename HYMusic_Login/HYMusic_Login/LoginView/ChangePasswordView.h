//
//  ChangePasswordView.h
//  HYMusic_Login
//
//  Created by evan on 2020/2/26.
//  Copyright © 2020 evan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ChangePasswordDelegate <NSObject>
- (void)hideChangePassword;
- (void)changePasswordWithParams:(NSDictionary *)params;
@end
@interface ChangePasswordView : UIView
+ (instancetype)showChangeView;
@property(nonatomic,weak)id<ChangePasswordDelegate>delegate;
@property(nonatomic,strong)NSString *token;
@end

NS_ASSUME_NONNULL_END
