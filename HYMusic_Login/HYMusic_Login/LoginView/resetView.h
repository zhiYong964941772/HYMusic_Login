//
//  resetView.h
//  HYMusic_Login
//
//  Created by evan on 2020/2/24.
//  Copyright © 2020 evan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginViewModel;
NS_ASSUME_NONNULL_BEGIN
@protocol resetDelegate <NSObject>
- (void)hideReset;
- (void)sendSMS:(NSDictionary *)params;
- (void)resetWithParams:(NSDictionary *)params;
- (void)sendImageValidation;

@end
@interface resetView : UIView
+ (instancetype)showResetView;
- (void)configWithData:(NSDictionary *)data;
- (void)updateImageValidation;
@property(nonatomic,weak)id<resetDelegate>delegate;
@property(nonatomic,strong)LoginViewModel *resetModel;

@end

NS_ASSUME_NONNULL_END
