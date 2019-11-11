//
//  ETTransferDetailViewController.h
//  ProjectET
//
//  Created by hufeng on 2019/11/7.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETTransferDetailViewController : UIViewController\

//glod 复制    [string]    是    币种
//id    [string]    是    交易记录id

@property (nonatomic,strong) NSString *glod;

@property (nonatomic,strong) NSString *Id;

@end

NS_ASSUME_NONNULL_END
