//
//  ETNewChatAddressBookModel.h
//  ProjectET
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETNewChatAddressBookDataModel;
NS_ASSUME_NONNULL_BEGIN

@interface ETNewChatAddressBookModel : NSObject

@property (nonatomic,strong) NSDictionary  *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface ETNewChatAddressBookDataModel : NSObject

@property (nonatomic,strong) NSDictionary  *ID;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *photo;

@end


NS_ASSUME_NONNULL_END
