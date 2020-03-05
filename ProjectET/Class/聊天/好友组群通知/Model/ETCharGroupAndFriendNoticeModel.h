//
//  ETCharGroupAndFriendNoticeModel.h
//  ProjectET
//
//  Created by mac on 2020/1/6.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETCharGroupAndFriendNoticeDataModel,ETCharGroupAndFriendNoticeListModel;
NS_ASSUME_NONNULL_BEGIN

@interface ETCharGroupAndFriendNoticeModel : NSObject

@property (nonatomic,strong) ETCharGroupAndFriendNoticeDataModel *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface ETCharGroupAndFriendNoticeDataModel : NSObject

@property (nonatomic,strong) NSMutableArray <ETCharGroupAndFriendNoticeListModel *> *list;

@property (nonatomic,strong) NSString *pages;

@property (nonatomic,strong) NSString *code;

@end

@interface ETCharGroupAndFriendNoticeListModel : NSObject

@property (nonatomic,strong) NSString *Id;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *qname;

@property (nonatomic,strong) NSString *state;

@property (nonatomic,strong) NSString *phone;

@property (nonatomic,strong) NSString *qcode;

@property (nonatomic,strong) NSString *operation;

@end

NS_ASSUME_NONNULL_END
