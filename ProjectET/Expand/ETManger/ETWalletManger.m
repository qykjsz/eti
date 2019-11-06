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
    
    NSMutableArray *arr = WALLET_ARR;
    if (arr.count != 0) {
        return arr[0];
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

@end
