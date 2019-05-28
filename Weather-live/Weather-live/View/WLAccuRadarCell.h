//
//  WLAccuRadarCell.h
//  Weather-live
//
//  Created by xueping on 2019/5/25.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface WLAccuRadarCell : UITableViewCell


- (void)configRadarArray:(NSArray*)radarArray time:(NSInteger)timeinterval;


@end

NS_ASSUME_NONNULL_END
