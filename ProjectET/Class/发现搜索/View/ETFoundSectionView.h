//
//  ETFoundSectionView.h
//  ProjectET
//
//  Created by hufeng on 2019/11/16.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface ETFoundSectionView : UIView
@property (weak, nonatomic) IBOutlet UILabel *topLb;
@property (weak, nonatomic) IBOutlet UILabel *bottomLb;

@property (nonatomic,strong) void(^foundWebViewblock)(NSString *str);

@end

NS_ASSUME_NONNULL_END
