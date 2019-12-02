//
//  ETShopChooseCoinView.h
//  ProjectET
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETShopChooseCoinViewDelegate <NSObject>

- (void)ETShopChooseCoinViewDelegateWithCell:(NSInteger)index;

@end

@interface ETShopChooseCoinView : UIView
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,weak) id <ETShopChooseCoinViewDelegate> delegate;
-(void)reloadChooseView:(NSMutableArray *)arr;

-(void)show;
@end


NS_ASSUME_NONNULL_END
