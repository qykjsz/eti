//
//  ETMycontactListModel.h
//  ProjectET
//
//  Created by hufeng on 2019/11/11.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class contactData;
NS_ASSUME_NONNULL_BEGIN

@interface ETMycontactListModel : NSObject

@property (nonatomic,strong) NSMutableArray <contactData *> *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface contactData : NSObject

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *remarks;

@property (nonatomic,strong) NSString *wallettype;

@property (nonatomic,strong) NSString *address;

@property (nonatomic,strong) NSString *time;

@end

NS_ASSUME_NONNULL_END
