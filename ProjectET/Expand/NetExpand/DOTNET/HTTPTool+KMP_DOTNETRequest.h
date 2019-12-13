//
//  HTTPTool+KMP_DOTNETRequest.h
//  KMPharmacy
//
//  Created by mac on 2018/5/11.
//  Copyright © 2018年 Kangmei Pharmaceutical Co.,Ltd. All rights reserved.
//

#import "HTTPTool.h"
#import "KMP_DOTNETModel.h"

@interface HTTPTool (KMP_DOTNETRequest)

/**
 .Net后台接口（code!=0同样走失败回调，msg以error中的NSLocalizedDescriptionKey返回）
 
 @param URLString api
 @param parameters 参数
 @param type 请求类型
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestDotNetWithURLString:(NSString *)URLString
                        parameters:(id)parameters
                              type:(XMHTTPMethodType)type
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError * error))failure;


/**
 .Net后台接口（code!=0同样走失败回调，msg以error中的NSLocalizedDescriptionKey返回）
 
 @param URLString api
 @param parameters 参数
 @param type 请求类型
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestGameDotNetWithURLString:(NSString *)URLString
                        parameters:(id)parameters
                              type:(XMHTTPMethodType)type
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError * error))failure;


@end
