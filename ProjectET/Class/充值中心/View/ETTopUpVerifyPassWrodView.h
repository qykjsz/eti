//
//  ETTopUpVerifyPassWrodView.h
//  ProjectET
//
//  Created by mac on 2019/12/12.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETTopUpVerifyPassWrodViewDelegate <NSObject>

- (void)ETTopUpVerifyPassWrodViewDelegateCancel;

- (void)ETTopUpVerifyPassWrodViewDelegateComfirm;


@end


@interface ETTopUpVerifyPassWrodView : UIView

@property (nonatomic,strong) void (^Success)(void);

@property (nonatomic,strong) void (^failure)(void);

@property (nonatomic,weak) id <ETTopUpVerifyPassWrodViewDelegate> delegate;

@property (nonatomic, strong)UILabel *lab_num;

@end

NS_ASSUME_NONNULL_END
