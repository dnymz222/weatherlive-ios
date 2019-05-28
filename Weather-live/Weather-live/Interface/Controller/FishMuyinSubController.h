//
//  LBMuyinSubController.h
//  lamabiji
//
//  Created by mc on 2018/9/12.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "WMPageController.h"


@interface FishMuyinSubController : UIViewController

@property(nonatomic,copy)NSString *url;

//@property(nonatomic,assign)BOOL first;

//@property(nonatomic,copy)NSArray *cateItemArray;
//@property(nonatomic,copy)NSArray *bannerArray;

@property(nonatomic,assign)NSInteger index;



- (void)reloadData;

@end
