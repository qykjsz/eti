//
//  ETRecordDetailViewController.h
//  ProjectET
//
//  Created by hufeng on 2019/11/1.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HoverPageViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface ETRecordDetailViewController : HoverChildViewController

//交易类型 1.转入 2.转入 3.全部
@property (nonatomic,strong) NSString *type;

@end

NS_ASSUME_NONNULL_END
