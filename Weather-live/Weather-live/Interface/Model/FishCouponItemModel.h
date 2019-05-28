//
//  LBCouponItemModel.h
//  lamabiji
//
//  Created by mc on 2018/9/14.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FishCouponItemModel : NSObject

@property(nonatomic,copy)NSString *shop_title;
//@property(nonatomic,copy)NSString *pict_url;
@property(nonatomic,copy)NSString *pict_url;
@property(nonatomic,copy)NSString *zk_final_price;
@property(nonatomic,copy)NSString *item_id;
@property(nonatomic,copy)NSString *coupon_share_url;
@property(nonatomic,assign)NSInteger volume;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *short_title;
@property(nonatomic,copy)NSString *endTime;
@property(nonatomic,copy)NSString *cateId;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,assign)NSInteger coupon_amount;
@property(nonatomic,copy)NSString *item_description;
//@property(nonatomic,assign)BOOL hasReplace;

@end
