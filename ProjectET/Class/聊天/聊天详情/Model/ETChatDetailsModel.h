//
//  ETChatDetailsModel.h
//  ProjectET
//
//  Created by mac on 2020/1/6.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETChatDetailsDataModel,ETChatDetailsChatModel;
NS_ASSUME_NONNULL_BEGIN

@interface ETChatDetailsModel : NSObject

@property (nonatomic,strong) ETChatDetailsDataModel *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;


@end

@interface ETChatDetailsDataModel : NSObject

@property (nonatomic,strong) NSString *pages;

@property (nonatomic,strong) NSMutableArray <ETChatDetailsChatModel *> *chat;


@end

@interface ETChatDetailsChatModel : NSObject

@property (nonatomic,strong) NSString *Id;

@property (nonatomic,strong) NSString *fromwho;

@property (nonatomic,strong) NSString *towho;

@property (nonatomic,strong) NSString *text;

@property (nonatomic,strong) NSString *time;

@property (nonatomic,strong) NSString *tophoto;

@property (nonatomic,strong) NSString *fromphoto;

@property (nonatomic,strong) NSString *fromname;

@property (nonatomic,strong) NSString *toname;

@property (nonatomic,strong) NSString *togroup;

@property (nonatomic,strong) NSString *photo;

@end

NS_ASSUME_NONNULL_END
