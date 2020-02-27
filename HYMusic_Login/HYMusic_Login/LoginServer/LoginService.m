//
//  LoginService.m
//  HYMusic_Login
//
//  Created by evan on 2020/2/25.
//  Copyright © 2020 evan. All rights reserved.
//

#import "LoginService.h"
#import <AFNetworking/AFNetworking.h>
@interface LoginService()
@property(nonatomic, strong)NSString *baseURL;
@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;
@property (nonatomic, strong) AFJSONRequestSerializer *jsonRequestSerializer;

@end
@implementation LoginService
#pragma mark -- server delegate
- (NSURLRequest *)requestWithParams:(NSDictionary *)params methodName:(NSString *)methodName requestType:(ZYAPIManagerRequestType)requestType{
    NSString *requestMethodType = @"POST";
    if (requestType == ZYAPIManagerRequestTypeGet) {
        requestMethodType = @"GET";
    }
    NSString *urlString = [NSString stringWithFormat:@"%@%@",self.baseURL,methodName];
    NSMutableURLRequest *request = [self.jsonRequestSerializer requestWithMethod:requestMethodType URLString:urlString parameters:params error:nil];
    return request;
    
}
- (NSDictionary *)resultWithResponseObject:(id)responseObject response:(NSURLResponse *)response request:(NSURLRequest *)request error:(NSError *__autoreleasing *)error{
    NSMutableDictionary *result = [[NSMutableDictionary alloc]init];
    if (*error ||!responseObject) {
        return result;
    }
     if ([responseObject isKindOfClass:[NSData class]]) {
            result[kCTApiProxyValidateResultKeyResponseString] = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            result[kCTApiProxyValidateResultKeyResponseObject] = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
        } else {
            //这里的kCTApiProxyValidateResultKeyResponseString是用作打印日志用的，实际使用时可以把实际类型的对象转换成string用于日志打印
    //        result[kCTApiProxyValidateResultKeyResponseString] = responseObject;
            result[kCTApiProxyValidateResultKeyResponseObject] = responseObject;
        }
        
        return result;
}
//中间事件处理 //要将请求上报到业务层，返回true，
- (BOOL)handleCommonErrorWithResponse:(ZYURLResponse *)response manager:(ZYAPIBaseManager *)manager errorType:(ZYAPIManagerErrorType)errorType{
#warning 可以处理请求事件的插入操作
    
    return true;
}
#pragma mark --getter setter
- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        [_httpRequestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return _httpRequestSerializer;
}
- (AFJSONRequestSerializer *)jsonRequestSerializer
{
    if (_jsonRequestSerializer == nil) {
        _jsonRequestSerializer = [AFJSONRequestSerializer serializer];
        [_jsonRequestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return _jsonRequestSerializer;
}

- (NSString *)baseURL{
    NSString *url = @"https://app.huayingmusic.com/api/v1";
    switch (self.apiEnvironment) {
        case ZYServiceAPIEnvironmentDevelop:
            url = @"http://192.168.0.50:8000/api/v1";
            break;
        case ZYServiceAPIEnvironmentReleaseTest:
            url = @"https://app.huayingmusic.com/api/v1";
        default:
            break;
    }
    return url;
}
- (ZYServiceAPIEnvironment)apiEnvironment{
    return ZYServiceAPIEnvironmentReleaseTest;
}
@synthesize apiEnvironment;

@end
