//
//  LBDetailShopCell.h
//  lamabiji
//
//  Created by xueping on 2018/10/2.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FishSellerModel;

@interface FishDetailShopCell : UITableViewCell


- (void)configWithModel:(FishSellerModel *)sellerModel;

@end

NS_ASSUME_NONNULL_END
