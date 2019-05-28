//
//  FishMapSelectPositionViewController.h
//  fishinghelper
//
//  Created by mc on 2019/2/12.
//  Copyright © 2019年 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class STLocationModel;

@protocol FishMapSelectPositionViewControllerDelegate <NSObject>

@optional

- (void)mapSelectPositionViewControllerDidSelected:(STLocationModel *)loction;

@end

@interface FishMapSelectPositionViewController : UIViewController

@property(nonatomic,weak)id <FishMapSelectPositionViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
