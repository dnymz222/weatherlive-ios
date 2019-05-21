//
//  LBAliHandler.h
//  lamabiji
//
//  Created by xueping on 2018/9/18.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,LBAliPageType)
{
    
    FishAliPageTypeItemDetailPage=0, //通过ID打开详情页
    FishAliPageTypeAddCartPage,  //添加商品到我的购物车
    FishAliPageTypePage,         //通过url打开详情页
    FishAliPageTypeShopPage,    //打开店铺
    FishAliPageTypeMyOrdersPage, //打开我的订单
    FishAliPageTypeMyCartsPage,  //打开我的购物车
};

typedef  void (^tradeSuccessCallback)(AlibcTradeResult * result);

typedef void(^tradeFailedCallback)(NSError *error);

@interface FishAliHandler : NSObject



+ (void)viewController:(UIViewController*)controller
             openWithUrl:(NSString *)string
               success:(tradeSuccessCallback)successblock
                failed:(tradeFailedCallback)failedblock;


+ (void)viewController:(UIViewController*)controller
          openWithString:(NSString *)string
              pageType:(LBAliPageType)pageType
               success:(tradeSuccessCallback)successblock
                failed:(tradeFailedCallback)failedblock;


+ (void)openMyCartFromViewController:(UIViewController*)controller
                             success:(tradeSuccessCallback)successblock
                              failed:(tradeFailedCallback)failedblock;
//
//+ (void)jsScanMyCartWithViewController:(UIViewController*)controller
//                                  success:(tradeSuccessCallback)successblock
//                                   failed:(tradeFailedCallback)failedblock;

+ (void)openMyOrderFromViewController:(UIViewController*)controller
                              success:(tradeSuccessCallback)successblock
                               failed:(tradeFailedCallback)failedblock;






@end

NS_ASSUME_NONNULL_END
