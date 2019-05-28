//
//  WLIndexSubViewController.h
//  Weather-live
//
//  Created by xueping on 2019/5/23.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLIndexSubViewController : UIViewController

@property(nonatomic,assign)NSInteger index;

- (void)configDataArray:(NSArray *)dataArray;

@end

NS_ASSUME_NONNULL_END
