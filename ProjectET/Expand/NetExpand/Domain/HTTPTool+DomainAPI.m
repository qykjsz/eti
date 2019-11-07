//
//  HTTPTool+DomainAPI.m
//  KMPharmacy
//
//  Created by mac on 2018/5/7.
//  Copyright © 2018年 Kangmei Pharmaceutical Co.,Ltd. All rights reserved.
//

#import "HTTPTool+DomainAPI.h"

@implementation HTTPTool (DomainAPI)

+ (void)getDomain {
    
#ifdef DEBUG
    NSLog(@"************************DEBUG************************");
    [[NSUserDefaults standardUserDefaults] setValue:@"https://et2.etac.io/api/" forKey:@"AppDomain"];
    
    
#elif RELEASE
    NSLog(@"************************RELEASE************************");
    
    [[NSUserDefaults standardUserDefaults] setValue:@"https://et2.etac.io/api/" forKey:@"AppDomain"];//.net
   
    
#endif
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [XMCenter setupConfig:^(XMConfig *config) {
//        config.generalServer = @"general server address";
//        config.generalHeaders = @{@"general-header": @"general header value"};
//        config.generalParameters = @{@"general-parameter": @"general parameter value"};
//        config.generalUserInfo = nil;
        config.callbackQueue = dispatch_get_main_queue();
        config.engine = [XMEngine sharedEngine];
#ifdef DEBUG
        config.consoleLog = YES;
#elif TEST
        config.consoleLog = YES;
#elif PRERELEASE
        config.consoleLog = YES;
#elif RELEASE
        config.consoleLog = NO;
#endif
    }];
}



@end
