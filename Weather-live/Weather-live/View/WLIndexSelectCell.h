//
//  WLIndexSelectCell.h
//  Weather-live
//
//  Created by xueping on 2019/10/25.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WLAccuIndexModel;

@interface WLIndexSelectCell : UITableViewCell

- (void)configWithModel:(WLAccuIndexModel *)model  first:(NSInteger)selectFirst second:(NSInteger)selectSecond;


@end

NS_ASSUME_NONNULL_END
