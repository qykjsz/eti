//
//  ETTransferView.h
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ETTransferViewDelegate <NSObject>

- (void)ETTransferViewDelegateWithClikTag:(NSInteger)tag;

@end
@interface ETTransferView : UIView

@property (nonatomic,weak) id <ETTransferViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
