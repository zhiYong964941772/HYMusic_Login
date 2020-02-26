//
//  LoginViewFactory.m
//  HYMusic_Login
//
//  Created by evan on 2020/2/24.
//  Copyright © 2020 evan. All rights reserved.
//

#import "LoginViewFactory.h"

@implementation LoginViewFactory
NSString * const ZYPhoneError = @"手机号码输入有误";
NSString * const ZYValidateError = @"验证码输入有误";

NSString * const ZYPasswordLengthError = @"密码不能为空";
NSString * const ZYPasswordContrastError = @"两次密码输入不一致";
NSString * const ZYPasswordError = @"密码输入有误";

NSString * const ZYLoginError = @"登录失败";
NSString * const ZYRegisterError = @"注册失败";
NSString * const ZYResetError = @"重置密码失败";
NSString * const ZYDefaultError = @"网络出错";
+ (BOOL)valiMobile:(NSString *)mobile{
        if (mobile.length != 11){
            //判断手机号码是否为11位
            return NO;
            }else{
                //使用正则表达式的方法来判断手机号


            /**
             * 手机号码:
             * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
             * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
             * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
             * 电信号段: 133,149,153,170,173,177,180,181,189
             */

            NSString *MOBILE = @"^1(3[0-9]|4[579]|5[0-35-9]|16[6]|7[0135678]|8[0-9]|19[89])\\d{8}$";
            
            /**
             * 中国移动：China Mobile
             * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188,198
             */

            NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478]|9[8])\\d{8}$";

            /**
             * 中国联通：China Unicom
             * 130,131,132,145,155,156,170,171,175,176,185,186
             */

            NSString *CU = @"^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$";

            /**
             * 中国电信：China Telecom
             * 133,149,153,170,173,177,180,181,189，199
             */
            NSString *CT = @"^1(3[3]|4[9]|53|7[037]|8[019]|9[9])\\d{8}$";



            NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];

            NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];

            NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];

            NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];



            if (([regextestmobile evaluateWithObject:mobile] == YES)

                || ([regextestcm evaluateWithObject:mobile] == YES)

                || ([regextestct evaluateWithObject:mobile] == YES)

                || ([regextestcu evaluateWithObject:mobile] == YES))
                {
                return YES;
            }else{
                return NO;
            }
        }
}
//只能输入数字
+ (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
//判断是否是汉字
+(BOOL)validateTextLength:(NSString *)text{
//    int strlength = 0;
//    for (int i=0; i< [text length]; i++) {
//        int a = [text characterAtIndex:i];
//        if( a > 0x4e00 && a < 0x9fff) { //判断是否为中文
//            strlength += 2;
//        }
//    }
    if ([text length] >=10) {
        return false;
    }
    return true;
}
//只能输入英文或者数字
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

+(BOOL)validatePassword:(NSString *)text{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
      NSString *filtered = [[text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
      return [text isEqualToString:filtered];
}
@end
