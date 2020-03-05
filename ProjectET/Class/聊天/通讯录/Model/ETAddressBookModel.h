//
//  ETAddressBookModel.h
//  ProjectET
//
//  Created by mac on 2020/1/3.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETAddressBookDataModel;
NS_ASSUME_NONNULL_BEGIN

@interface ETAddressBookModel : NSObject

@property (nonatomic,strong) NSMutableArray <ETAddressBookDataModel *> *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface ETAddressBookDataModel : NSObject

@property (nonatomic,strong) NSString *address;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *photo;

@property (nonatomic,strong) NSString *code;

@property (nonatomic,strong) NSString *introduce;

@end

NS_ASSUME_NONNULL_END
