//
//  HTTPTool+KMP_DOTNETRequest.m
//  KMPharmacy
//
//  Created by mac on 2018/5/11.
//  Copyright © 2018年 Kangmei Pharmaceutical Co.,Ltd. All rights reserved.
//

#import "HTTPTool+KMP_DOTNETRequest.h"

@implementation HTTPTool (KMP_DOTNETRequest)

+ (void)requestDotNetWithURLString:(NSString *)URLString
                        parameters:(id)parameters
                              type:(XMHTTPMethodType)type
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError * error))failure
{
    
    
 

     //   NSString *accesstoken = [[NSUserDefaults standardUserDefaults] valueForKey:@"accesstoken"];
//        [SVProgressHUD showWithStatus:@"正在加载"];
        [self requestWithAccessToken:@""
                           URLString:URLString
                          parameters:parameters
                                type:type
                             success:^(id responseObject) {
                                 [SVProgressHUD dismiss];
                                 if (success) {
                                     success(responseObject);
                                 }
                             } failure:^(NSError *error) {
                                 [SVProgressHUD dismiss];
                                 if (failure) {
                                     failure(error);
                                 }
                             }];

    
}

+ (void)requestWithAccessToken:(NSString *)accessToken
                     URLString:(NSString *)URLString
                    parameters:(id)parameters
                          type:(XMHTTPMethodType)type
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError * error))failure {
    

    
    [XMCenter sendRequest:^(XMRequest *request) {
        request.url = [NSString stringWithFormat:@"%@%@",APP_DOMAIN,URLString];
        request.parameters = parameters;
        request.httpMethod = type;
        request.requestSerializerType = kXMRequestSerializerJSON;
        request.responseSerializerType = kXMResponseSerializerJSON;
    } onSuccess:^(id responseObject) {
        
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
//        if (baseModel.code != 200) {
//            NSLog(@"\n===========\n%@\n response data :\n%@\n===========",[NSString stringWithFormat:@"%@%@",APP_DOMAIN,URLString],responseObject);
//            //登录信息异常，走failure
//            if (failure) {
//                NSError * error = [[NSError alloc] initWithDomain:@"TOKEN_FAILURE" code:-2 userInfo:@{NSLocalizedDescriptionKey:baseModel.msg,NSLocalizedFailureReasonErrorKey:@"Token无效或为空",NSLocalizedRecoverySuggestionErrorKey:@"重新登录"}];
//                failure(error);
//                [SVProgressHUD showInfoWithStatus:@"服务器繁忙"];
//            }
//            return ;
//        }
        
//        if (baseModel.code == 400) {
//            NSError * error = [[NSError alloc] initWithDomain:@"TOKEN_FAILURE" code:baseModel.code userInfo:@{NSLocalizedDescriptionKey:baseModel.msg,NSLocalizedFailureReasonErrorKey:@"Token无效或为空",NSLocalizedRecoverySuggestionErrorKey:@"重新登录"}];
//            failure(error);
//            [SVProgressHUD showInfoWithStatus:@"服务器繁忙"];
//        }
//        if (baseModel.code != 0) {
//            NSLog(@"\n===========\n%@\n response data :\n%@\n===========",[NSString stringWithFormat:@"%@%@",APP_DOMAIN,URLString],responseObject);
//            //数据异常失败，走failure方法
//            if (failure) {
//                NSError * error = [[NSError alloc] initWithDomain:@"FAILURE" code:baseModel.code userInfo:@{NSLocalizedDescriptionKey:baseModel.message,NSLocalizedFailureReasonErrorKey:baseModel.message,NSLocalizedRecoverySuggestionErrorKey:baseModel.message}];
//                failure(error);
//            }
//            return ;
//        }
        
//        if (baseModel.code == 200) {
            //成功
            
            if (success) {
                success(responseObject);
            }
//        }
        
    } onFailure:^(NSError *error) {
        
        if (failure) {
            NSError * tmpError = [[NSError alloc] initWithDomain:@"FAILURE" code:-2333 userInfo:@{NSLocalizedDescriptionKey:ErrorText,NSLocalizedFailureReasonErrorKey:@".net后台接口报错",NSLocalizedRecoverySuggestionErrorKey:@".net后台接口报错"}];
            failure(tmpError);
            [SVProgressHUD showInfoWithStatus:@"服务器繁忙"];
        }
        
    }];
}



+ (void)requestGameDotNetWithURLString:(NSString *)URLString
                        parameters:(id)parameters
                              type:(XMHTTPMethodType)type
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError * error))failure
{
    
    
        URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

     //   NSString *accesstoken = [[NSUserDefaults standardUserDefaults] valueForKey:@"accesstoken"];
//        [SVProgressHUD showWithStatus:@"正在加载"];
        [self requestGameWithAccessToken:@""
                           URLString:URLString
                          parameters:parameters
                                type:type
                             success:^(id responseObject) {
                                 [SVProgressHUD dismiss];
                                 if (success) {
                                     success(responseObject);
                                 }
                             } failure:^(NSError *error) {
                                 [SVProgressHUD dismiss];
                                 if (failure) {
                                     failure(error);
                                 }
                             }];

    
}


+ (void)requestGameWithAccessToken:(NSString *)accessToken
                     URLString:(NSString *)URLString
                    parameters:(id)parameters
                          type:(XMHTTPMethodType)type
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError * error))failure {
    

    
    [XMCenter sendRequest:^(XMRequest *request) {
        request.url = URLString;
        request.parameters = parameters;
        request.httpMethod = type;
        request.requestSerializerType = kXMRequestSerializerJSON;
        request.responseSerializerType = kXMResponseSerializerJSON;
    } onSuccess:^(id responseObject) {
        
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
            if (success) {
                success(responseObject);
            }
    } onFailure:^(NSError *error) {
        
        if (failure) {
            NSError * tmpError = [[NSError alloc] initWithDomain:@"FAILURE" code:-2333 userInfo:@{NSLocalizedDescriptionKey:ErrorText,NSLocalizedFailureReasonErrorKey:@".net后台接口报错",NSLocalizedRecoverySuggestionErrorKey:@".net后台接口报错"}];
            failure(tmpError);
            [SVProgressHUD showInfoWithStatus:@"服务器繁忙"];
        }
        
    }];
}





@end
