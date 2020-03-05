//
//  ETWalletModel.h
//  ProjectET
//
//  Created by hufeng on 2019/11/4.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETWalletModel : NSObject

@property (nonatomic,strong) NSString *address;

@property (nonatomic,strong) NSString *keyStore;

@property (nonatomic,strong) NSArray * mnemonicPhrase;

@property (nonatomic,strong) NSString *privateKey;

@property (nonatomic,strong) NSString *walletName;

@property (nonatomic,strong) NSString *password;

@property (nonatomic,strong) NSString *walletType;

@property (nonatomic,strong) NSString *ryToken;

@property (nonatomic,strong) NSString *ryID;

@property (nonatomic,assign) BOOL isOpenChat;

@property (nonatomic,assign) BOOL isBackUp;

@property (nonatomic,assign) bool isCurrentWallet;

@end

NS_ASSUME_NONNULL_END
