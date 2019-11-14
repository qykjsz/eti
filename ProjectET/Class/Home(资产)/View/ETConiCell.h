//
//  ETConiCell.h
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETTotalModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ETConiCell : UITableViewCell

@property (nonatomic,strong) UILabel *coninName;

@property (nonatomic,strong) UIImageView *coninImage;

@property (nonatomic,strong) UILabel *topDollor;

@property (nonatomic,strong) UILabel *bottomDollor;

@property (nonatomic,strong) glodsData *model;


@property (nonatomic,assign) BOOL isOpen;

@end

NS_ASSUME_NONNULL_END
