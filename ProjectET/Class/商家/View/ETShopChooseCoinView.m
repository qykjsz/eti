//
//  ETShopChooseCoinView.m
//  ProjectET
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETShopChooseCoinView.h"
#import "ETShopChooseCoinCell.h"

@interface ETShopChooseCoinView()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ETShopChooseCoinView

 - (instancetype)initWithFrame:(CGRect)frame
 {
     if (self = [super initWithFrame:frame]) {
         UIView *contenView = [[NSBundle mainBundle]loadNibNamed:@"ETShopChooseCoinView" owner:self options:nil].lastObject;
         contenView.frame = frame;
         [self addSubview:contenView];
         [self.tableView registerNib:[UINib nibWithNibName:@"ETShopChooseCoinCell" bundle:nil] forCellReuseIdentifier:@"ETShopChooseCoinCell"];
     }
     return self;
 }


-(void)reloadChooseView:(NSMutableArray *)arr{
    [self.dataSource removeAllObjects];
    if (arr.count > 8) {
        self.constraint_height.constant = 50 * 9 + 10;
        [self.tableView setScrollEnabled:YES];
    }else {
        self.constraint_height.constant = 50 * arr.count + 10;
        [self.tableView setScrollEnabled:YES];
    }
     self.dataSource = arr;
    [self.tableView reloadData];
   
}


- (IBAction)actionOfCancle:(UIButton *)sender {
   
    [self removeFromSuperview];
}

- (void)show{
   
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

#pragma mark--------DELEGATE-------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ETShopChooseCoinCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETShopChooseCoinCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lab_title.text = self.dataSource[indexPath.row][@"name"];
    [cell.img_img sd_setImageWithURL:[NSURL URLWithString:self.dataSource[indexPath.row][@"img"]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(ETShopChooseCoinViewDelegateWithCell:)]) {
         [self.delegate ETShopChooseCoinViewDelegateWithCell:indexPath.row];
        [self actionOfCancle:[UIButton new]];
     }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
