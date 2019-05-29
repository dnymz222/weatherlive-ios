//
//  WLAccuFooterReusableView.h
//  Weather-live
//
//  Created by xueping on 2019/5/29.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WLAccuFooterReusableViewDelegate <NSObject>

- (void)AcuuWeatherFooterViewClickButtonLink;

@end

@interface WLAccuFooterReusableView : UICollectionReusableView

@property(nonatomic,weak)id <WLAccuFooterReusableViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
