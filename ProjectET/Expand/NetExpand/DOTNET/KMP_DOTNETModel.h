//
//  KMP_DOTNETModel.h
//  KMPharmacy
//
//  Created by mac on 2018/5/11.
//  Copyright © 2018年 Kangmei Pharmaceutical Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KMP_DOTNETModelData;

@interface KMP_DOTNETModel : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, copy  ) NSString  *msg;

@property (nonatomic, strong) KMP_DOTNETModelData  *data;

@end

@interface KMP_DOTNETModelData : NSObject

@property (nonatomic, copy) NSString *accesstoken;

@end
