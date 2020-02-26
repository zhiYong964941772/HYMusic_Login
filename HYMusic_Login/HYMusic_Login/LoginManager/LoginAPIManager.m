//
//  LoginAPIManager.m
//  HYMusic_Login
//
//  Created by evan on 2020/2/25.
//  Copyright © 2020 evan. All rights reserved.
//

#import "LoginAPIManager.h"
#import "Target_LoginService.h"
@interface LoginAPIManager() <ZYAPIManagerValidator,ZYAPIManagerParamSource,ZYAPIManagerInterceptor>
@end
@implementation LoginAPIManager
- (instancetype)init{
    self = [super init];
    if (self) {
        self.paramSource = self;
        self.validator = self;
        self.cachePolicy = ZYAPIManagerCachePolicyMemory;
        self.interceptor = self;
    }
    return self;
}
#pragma mark -- ZYAPIManager
- (NSString *)methodName{
    return @"/auth/login";
}
- (NSString *)serviceIdentifier{
    return ZYNetWorkingLoginServiceIdentifier;
}
- (ZYAPIManagerRequestType)requestType{
    return ZYAPIManagerRequestTypePost;
}
#pragma mark - ZYAPIManagerParamSource - 参数来源
//参数来源
- (NSDictionary *)paramsForApi:(ZYAPIBaseManager *)manager
{
    return nil;
}
#pragma mark - ZYAPIManagerValidator -默认错误事件
- (ZYAPIManagerErrorType)manager:(ZYAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data{
    return ZYAPIManagerErrorTypeNotError;//默认无错
}
- (ZYAPIManagerErrorType)manager:(ZYAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data{
    return ZYAPIManagerErrorTypeNotError;
}
#pragma mark - ZYAPIManagerInterceptor -拦截
- (BOOL)manager:(ZYAPIBaseManager *_Nonnull)manager beforePerformSuccessWithResponse:(ZYURLResponse *_Nonnull)response{
    return true;
}
- (void)manager:(ZYAPIBaseManager *_Nonnull)manager afterPerformSuccessWithResponse:(ZYURLResponse *_Nonnull)response{
    
}

- (BOOL)manager:(ZYAPIBaseManager *_Nonnull)manager beforePerformFailWithResponse:(ZYURLResponse *_Nonnull)response{
    return true;
}
- (void)manager:(ZYAPIBaseManager *_Nonnull)manager afterPerformFailWithResponse:(ZYURLResponse *_Nonnull)response{
    
}

- (BOOL)manager:(ZYAPIBaseManager *_Nonnull)manager shouldCallAPIWithParams:(NSDictionary *_Nullable)params{
    return true;

}
- (void)manager:(ZYAPIBaseManager *_Nonnull)manager afterCallingAPIWithParams:(NSDictionary *_Nullable)params{
    
}
- (void)manager:(ZYAPIBaseManager *_Nonnull)manager didReceiveResponse:(ZYURLResponse *_Nullable)response{
    
}
@end
