//
//  STAcuuWeatherFooterView.h
//  Solunar Tides
//
//  Created by xueping on 2019/5/19.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol STAcuuWeatherFooterViewDelegate <NSObject>

- (void)AcuuWeatherFooterViewClickButtonLink;

@end

@interface STAcuuWeatherFooterView : UITableViewHeaderFooterView

@property(nonatomic,weak)id <STAcuuWeatherFooterViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
