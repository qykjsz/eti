//
//  ETWalletManger.m
//  ProjectET
//
//  Created by hufeng on 2019/11/4.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETWalletManger.h"

@implementation ETWalletManger

+ (ETWalletModel *)getCurrentWallet {
    
//    bool isHaveCurrentModel = NO;
    
    NSMutableArray *arr = WALLET_ARR;
    if (arr.count != 0) {
        for (ETWalletModel *model in arr) {
            if (model.isCurrentWallet == YES) {
                return model;
            }
        }
    }
    
    /*如果删除的是当前钱包，把数组第一个置为当前钱包*/
    if (arr.count != 0) {
        ETWalletModel *model = arr[0];
        model.isCurrentWallet = YES;
        [ETWalletManger updateWallet:model];
    }
    return nil;
}

+ (ETWalletModel *)getModelIndex:(NSInteger)index {
    
    NSMutableArray *arr = WALLET_ARR;
    if (arr.count == 0) {
        return nil;
    }
    
    if (index >= arr.count) {
        return nil;
    }
    
    return arr[index];
}

+ (void)updateWallet:(ETWalletModel *)model {
    
    NSMutableArray *arr = WALLET_ARR;
    

    if (arr.count != 0) {
        for (int i = 0; i<arr.count; i++) {
            
            ETWalletModel *tempModel = arr[i];
            if ([tempModel.address isEqualToString:model.address]) {
                [arr replaceObjectAtIndex:i withObject:model];
            }
        }
        
        
        NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/WalletData.data"];
        [NSKeyedArchiver archiveRootObject:arr toFile:file];
    }
   
}

+ (void)addWallet:(ETWalletModel *)model {
    
    NSMutableArray *arr = WALLET_ARR;
    
    if (arr == nil) {
        arr = [NSMutableArray array];
    }
    
    if (arr.count != 0) {
        for (int i = 0; i<arr.count; i++) {
            
            ETWalletModel *tempModel = arr[i];
            if ([tempModel.address isEqualToString:model.address]) {
                [arr replaceObjectAtIndex:i withObject:model];
            }else {
                [arr addObject:model];
            }
        }
        
    }else {
        [arr addObject:model];
    }
    NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/WalletData.data"];
    [NSKeyedArchiver archiveRootObject:arr toFile:file];
}

+ (void)deleWallet:(ETWalletModel *)model {
    
    NSMutableArray *arr = WALLET_ARR;
    
    
    if (arr.count != 0) {
        for (int i = 0; i<arr.count; i++) {
            
            ETWalletModel *tempModel = arr[i];
            if ([tempModel.address isEqualToString:model.address]) {
                [arr removeObjectAtIndex:i];
            }
        }
        
        
        NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/WalletData.data"];
        [NSKeyedArchiver archiveRootObject:arr toFile:file];
    }
    
}

/*
 重新排序，将isCurretnModel置为数组第一位
 */
+ (void)reloadData {
    
    
    NSMutableArray *arr = WALLET_ARR;
    
    if (arr.count != 0) {
        for (int i = 0; i<arr.count; i++) {
            
            ETWalletModel *model = arr[i];
            if (model.isCurrentWallet) {
                [arr exchangeObjectAtIndex:0 withObjectAtIndex:i];
            }
        }
        
        NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/WalletData.data"];
        [NSKeyedArchiver archiveRootObject:arr toFile:file];
    }
    
    
    
}
@end
