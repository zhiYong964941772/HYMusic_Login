//
//  LoginViewFactory.h
//  HYMusic_Login
//
//  Created by evan on 2020/2/24.
//  Copyright © 2020 evan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewFactory : NSObject
+(BOOL)valiMobile:(NSString*)mobile;
+(BOOL)validateNumber:(NSString*)number;
+(BOOL)validateTextLength:(NSString*)text;
+(BOOL)validatePassword:(NSString*)text;
// tip message

extern NSString * _Nonnull const ZYPhoneError;
extern NSString * _Nonnull const ZYValidateError;
extern NSString * _Nonnull const ZYPasswordError;
extern NSString * _Nonnull const ZYPasswordLengthError ;
extern NSString * _Nonnull const ZYPasswordContrastError;
extern NSString * _Nonnull const ZYPasswordError;
extern NSString * _Nonnull const ZYLoginError;
extern NSString * _Nonnull const ZYRegisterError;
extern NSString * _Nonnull const ZYResetError;
extern NSString * _Nonnull const ZYDefaultError;


@end

NS_ASSUME_NONNULL_END
