//
//  WLJSWebViewController.h
//  Weather-live
//
//  Created by xueping on 2019/5/28.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WLBridgeDelegate <JSExport>


JSExportAs(call, -(void)call:(NSString *)name params:(NSString *) params callbackId:(NSInteger)callbackId);
- (void)onload ;
- (void)documentReadyStateComplete;
- (void)webViewDidFinishLoadCompletely;
@end

@interface WLJSWebViewController : UIViewController<WLBridgeDelegate>

@property(nonatomic,copy)NSString *cartPath;

@property(nonatomic,copy)NSString *cartjs;

@property(nonatomic,strong)UIWebView *webView;


@end

NS_ASSUME_NONNULL_END
