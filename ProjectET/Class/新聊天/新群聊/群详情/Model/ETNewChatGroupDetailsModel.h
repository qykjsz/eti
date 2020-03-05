//
//  ETNewChatGroupDetailsModel.h
//  ProjectET
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETNewChatGroupDetailsDataModel;
NS_ASSUME_NONNULL_BEGIN

@interface ETNewChatGroupDetailsModel : NSObject

@property (nonatomic,strong) NSMutableArray <ETNewChatGroupDetailsDataModel *> *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface ETNewChatGroupDetailsDataModel : NSObject

@property (nonatomic,strong) NSString *ID;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *photo;

@property (nonatomic,strong) NSString *type;


@end

NS_ASSUME_NONNULL_END
