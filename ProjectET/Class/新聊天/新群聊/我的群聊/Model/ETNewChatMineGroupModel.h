//
//  ETNewChatMineGroupModel.h
//  ProjectET
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETNewChatMineGroupDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface ETNewChatMineGroupModel : NSObject

@property (nonatomic,strong) NSMutableArray <ETNewChatMineGroupDataModel *> *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface ETNewChatMineGroupDataModel : NSObject

@property (nonatomic,strong) NSString *ID;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *photo;

@property (nonatomic,strong) NSString *number;

@end

NS_ASSUME_NONNULL_END
