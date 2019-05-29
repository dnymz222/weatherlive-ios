//
//  LBAliHandler.m
//  lamabiji
//
//  Created by xueping on 2018/9/18.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "WLAliHandler.h"
#import "LBKeyMacro.h"
#import "WLAliWebController.h"
#import "WLJSWebViewController.h"

//#import "LBCartScanController.h"

@implementation WLAliHandler


+ (void)initialAlisdk {
    
    [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
        
    } failure:^(NSError *error) {
        
    }];
}



+ (void)viewController:(UIViewController*)controller
             openWithUrl:(NSString *)string
               success:(tradeSuccessCallback)successblock
                failed:(tradeFailedCallback)failedblock


{
    
    
    
    [WLAliHandler viewController:controller
                          openWithString:string
                              pageType:FishAliPageTypePage
                               success:^(AlibcTradeResult * _Nullable result) {
                                   
                                   successblock(result);
                               }
                                failed:^(NSError * _Nullable error) {
                                    failedblock(error);
                                }];
    
}


+ (void)viewController:(UIViewController *)controller
          openWithString:(NSString *)string
              pageType:(LBAliPageType)pageType
               success:(tradeSuccessCallback)successblock
                failed:(tradeFailedCallback)failedblock
{
    
    
    AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
    showParam.openType = AlibcOpenTypeNative;
    showParam.isNeedPush= YES;
    showParam.linkKey = @"taobao_scheme";
    
    //   showParam.backUrl=[NSString stringWithFormat:@"tbopen%@:https://h5.m.taobao.com",@"23467543"];
    showParam.backUrl =@"tbopen27442851";
    AlibcTradeTaokeParams *taoKeParams=[[AlibcTradeTaokeParams alloc] init];
    taoKeParams.pid = PidString ; //
//    if ([WLAliUser shareInstance].openTaobao) {
//        taoKeParams.adzoneId = @"27520650431";
//        taoKeParams.extParams = @{@"taokeAppkey":@"24863180"};
//    }
    
    
    
    //
    id<AlibcTradePage> page ;
    
    
    switch (pageType) {
        case FishAliPageTypeItemDetailPage:
            page = [AlibcTradePageFactory itemDetailPage:string];
            break;
            
        case FishAliPageTypeAddCartPage:
            page =[ AlibcTradePageFactory addCartPage:string];
            
            break;
            
        case FishAliPageTypePage:
            //string = [string stringByAppendingString:@"&nowake=1"];
            page =[AlibcTradePageFactory page:string];
            break;
            
        case FishAliPageTypeShopPage:
            page =[AlibcTradePageFactory shopPage:string];
            break;
            
        case FishAliPageTypeMyOrdersPage:
            page =[AlibcTradePageFactory myOrdersPage:0 isAllOrder:YES];
            //             openTabaoIgnore = YES;
            break;
            
            
        case FishAliPageTypeMyCartsPage:
            page = [AlibcTradePageFactory myCartsPage];
            //             openTabaoIgnore = YES;
            break;
            
        default:
            break;
    }
    
    
    
  
        [[AlibcTradeSDK sharedInstance].tradeService
         show:controller
         page:page
         showParams:showParam
         taoKeParams:taoKeParams
         trackParam:nil
         tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
             successblock(result) ;
             
             
             
             
         } tradeProcessFailedCallback:^(NSError * _Nullable error) {
             failedblock(error);
             
             
             
         }];
        
 
    
}

+ (void)jsWebOpenMyCartWithViewController:(UIViewController*)controller
                                  success:(tradeSuccessCallback)successblock
                                   failed:(tradeFailedCallback)failedblock
{
    
    [WLAliHandler viewController:controller
            openJSWeControllerByString:nil
                              pageType:FishAliPageTypeMyCartsPage
                               success:^(AlibcTradeResult *result) {
                                   
                                   successblock(result);
                               }
                                failed:^(NSError *error) {
                                    failedblock(error);
                                    
                                }];
    
    
    
}

+ (void)viewController:(UIViewController *)controller
openJSWeControllerByString:(NSString *)string
              pageType:(LBAliPageType)pageType
               success:(tradeSuccessCallback)successblock
                failed:(tradeFailedCallback)failedblock
{
    
    
    AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
    showParam.openType = AlibcOpenTypeNative;
    showParam.isNeedPush= YES;
    showParam.linkKey = @"taobao_scheme";
    
    //   showParam.backUrl=[NSString stringWithFormat:@"tbopen%@:https://h5.m.taobao.com",@"23467543"];
    showParam.backUrl =@"tbopen27442851";
    AlibcTradeTaokeParams *taoKeParams=[[AlibcTradeTaokeParams alloc] init];
    taoKeParams.pid = PidString;
  
    
    
    //
    id<AlibcTradePage> page ;
    
    
    switch (pageType) {
        case FishAliPageTypeItemDetailPage:
            page = [AlibcTradePageFactory itemDetailPage:string];
            break;
            
        case FishAliPageTypeAddCartPage:
            page =[ AlibcTradePageFactory addCartPage:string];
            
            break;
            
        case FishAliPageTypePage:
            //string = [string stringByAppendingString:@"&nowake=1"];
            page =[AlibcTradePageFactory page:string];
            break;
            
        case FishAliPageTypeShopPage:
            page =[AlibcTradePageFactory shopPage:string];
            break;
            
        case FishAliPageTypeMyOrdersPage:
            page =[AlibcTradePageFactory myOrdersPage:0 isAllOrder:YES];
            //             openTabaoIgnore = YES;
            break;
            
            
        case FishAliPageTypeMyCartsPage:
            page = [AlibcTradePageFactory myCartsPage];
            //             openTabaoIgnore = YES;
            break;
            
        default:
            break;
    }
    
    
    
    
    showParam.openType = AlibcOpenTypeH5;
    WLJSWebViewController*webController = (WLJSWebViewController*)controller;
    
    [[AlibcTradeSDK sharedInstance].tradeService show:controller webView:webController.webView page:page showParams:showParam taoKeParams:taoKeParams trackParam:nil tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
        
    } tradeProcessFailedCallback:^(NSError * _Nullable error) {
        
    }];
    
    
    
    
    
    
    
}




//+ (void)viewController:(UIViewController *)controller openJSWeControllerByString:(NSString *)string
//              pageType:(LBAliPageType)pageType
//               success:(tradeSuccessCallback)successblock
//                failed:(tradeFailedCallback)failedblock
//{
//    
//    
//    AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
//    showParam.openType = AlibcOpenTypeNative;
//    showParam.isNeedPush= YES;
//    showParam.linkKey = @"taobao_scheme";
//    
//    //   showParam.backUrl=[NSString stringWithFormat:@"tbopen%@:https://h5.m.taobao.com",@"23467543"];
//    showParam.backUrl =@"tbopen23467543";
//    AlibcTradeTaokeParams *taoKeParams=[[AlibcTradeTaokeParams alloc] init];
//    taoKeParams.pid = PidString; //
//    if ([LBUser shareInstance].openTaobao) {
//        taoKeParams.adzoneId = @"10013800042";
//        taoKeParams.extParams = @{@"taokeAppkey":@"24863180"};
//    }
//    
//    
//    
//    //
//    id<AlibcTradePage> page ;
//    
//    
//    switch (pageType) {
//        case LBAliPageTypeItemDetailPage:
//            page = [AlibcTradePageFactory itemDetailPage:string];
//            break;
//            
//        case LBAliPageTypeAddCartPage:
//            page =[ AlibcTradePageFactory addCartPage:string];
//            
//            break;
//            
//        case LBAliPageTypePage:
//            //string = [string stringByAppendingString:@"&nowake=1"];
//            page =[AlibcTradePageFactory page:string];
//            break;
//            
//        case LBAliPageTypeShopPage:
//            page =[AlibcTradePageFactory shopPage:string];
//            break;
//            
//        case LBAliPageTypeMyOrdersPage:
//            page =[AlibcTradePageFactory myOrdersPage:0 isAllOrder:YES];
//            //             openTabaoIgnore = YES;
//            break;
//            
//            
//        case LBAliPageTypeMyCartsPage:
//            page = [AlibcTradePageFactory myCartsPage];
//            //             openTabaoIgnore = YES;
//            break;
//            
//        default:
//            break;
//    }
//    
//    
//    
//    
//    
//    showParam.openType = AlibcOpenTypeH5;
//    
//    LBCartScanController *scanController ;
//    if ([controller isKindOfClass:[LBCartScanController class]]) {
//        scanController = (LBCartScanController *)controller;
//    }
//    else {
//        scanController = [[LBCartScanController alloc] init];
//        [controller.navigationController pushViewController:scanController animated:YES];
//    }
//    [[AlibcTradeSDK sharedInstance].tradeService show:controller webView:scanController.webView page:page showParams:showParam taoKeParams:taoKeParams trackParam:nil tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
//        
//    } tradeProcessFailedCallback:^(NSError * _Nullable error) {
//        
//    }];
//    
//    
//    
//    
//    
//    
//    
//}


+ (void)openMyCartFromViewController:(UIViewController*)controller
                             success:(tradeSuccessCallback)successblock
                              failed:(tradeFailedCallback)failedblock
{
    
    
    [WLAliHandler viewController:controller
                          openWithString:nil
                              pageType:FishAliPageTypeMyCartsPage
     
                               success:^(AlibcTradeResult * _Nullable result) {
                                   successblock(result);
                                   
                               }
                                failed:^(NSError * _Nullable error) {
                                    failedblock(error);
                                }];
    
    
}

//+ (void)jsScanMyCartWithViewController:(UIViewController*)controller
//                                  success:(tradeSuccessCallback)successblock
//                                   failed:(tradeFailedCallback)failedblock
//{
//    
//    [LBAliHandler viewController:controller
//            openJSWeControllerByString:nil
//                              pageType:LBAliPageTypeMyCartsPage
//                               success:^(AlibcTradeResult *result) {
//                                   
//                                   successblock(result);
//                               }
//                                failed:^(NSError *error) {
//                                    failedblock(error);
//                                    
//                                }];
//    
//    
//    
//}




+ (void)openMyOrderFromViewController:(UIViewController *)controller
                              success:(tradeSuccessCallback)successblock
                               failed:(tradeFailedCallback)failedblock
{
    
    [WLAliHandler viewController:controller openWithString:nil
                              pageType:FishAliPageTypeMyOrdersPage
                               success:^(AlibcTradeResult * _Nullable result) {
                                   successblock(result);
                               }
                                failed:^(NSError * _Nullable error) {
                                    failedblock(error);
                                }];
    
    
}



@end
