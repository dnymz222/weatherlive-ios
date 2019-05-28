//
//  WLAccuIndexDetailCell.h
//  Weather-live
//
//  Created by xueping on 2019/5/23.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WLAccuIndexModel;

@interface WLAccuIndexDetailCell :UICollectionViewCell


- (void)configIndexModel:(WLAccuIndexModel *)model;



@end

NS_ASSUME_NONNULL_END
