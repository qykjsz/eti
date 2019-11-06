//
//  HTTPTool.m
//  KMDance
//
//  Created by KM on 17/5/172017.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "HTTPTool.h"

@implementation HTTPTool

+ (NetworkStatus)currentNetStatus {
    
    Reachability *reachability = [Reachability reachabilityWithHostName:@"yao.kangmei.com.cn"];
    
    return [reachability currentReachabilityStatus];
}


+ (void)baseRequestWithURLString:(NSString *)URLString
                      parameters:(id)parameters
                            type:(XMHTTPMethodType)type
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError * error))failure
{
    
    [XMCenter sendRequest:^(XMRequest *request) {
        request.url = URLString;
        request.parameters = parameters;
        request.httpMethod = type;
//        request.requestSerializerType = kXMRequestSerializerJSON;
    } onSuccess:^(id responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } onFailure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
