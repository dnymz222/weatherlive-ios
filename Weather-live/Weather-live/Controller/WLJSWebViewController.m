//
//  WLJSWebViewController.m
//  Weather-live
//
//  Created by xueping on 2019/5/28.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLJSWebViewController.h"
#import "FishNetworkFirstHandler.h"
#import "ColorSizeMacro.h"
#import "Masonry.h"
#import "FishAliHandler.h"
#import "FishCouponItemModel.h"
#import "YYModel.h"
#import "UIColor+WXP.h"
#import "WLScanResultViewController.h"

@interface WLJSWebViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)JSContext *bcJsContext;

@property(nonatomic,copy)NSArray *itemArray;

@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,assign)NSInteger scanindex;
@property(nonatomic,assign)NSInteger totalCount;
@property(nonatomic,assign)NSInteger hasScanCount;

@property(nonatomic,strong)NSMutableArray *couponArray;
@property(nonatomic,assign)NSInteger couponCount;
@property(nonatomic,assign)NSInteger couponAmount;
@property(nonatomic,strong)UIButton *rightButton;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator ;


@property(nonatomic,assign)NSInteger hasLoad;

@end

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@implementation WLJSWebViewController



- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.webView = [[UIWebView alloc] init];
        
        self.webView.delegate = self;
    }
    
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.webView];
    self.navigationItem.title = @"准备扫描购物车,请稍候";
    
    
    
    
    CGFloat tabheight ;
    
    if (self.navigationController.viewControllers.count > 1) {
        tabheight = 0;
    } else {
        tabheight = 49;
    }
    
    CGFloat bootomspace = KIsiPhoneX ?34+ tabheight :tabheight;
    
    if ( [[[UIDevice currentDevice] systemVersion] floatValue] < 11 ) {
        bootomspace  = 0;
    }
    
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-bootomspace);
        
    }];
    
    _hasLoad = 0;
    
    _couponArray   = [NSMutableArray array];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.rightButton.hidden = YES;
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivePOpOutNote:) name:JSwebControllerPopoutKey object:nil];
    
    [FishAliHandler jsWebOpenMyCartWithViewController:self success:^(AlibcTradeResult * _Nonnull result) {
        
    } failed:^(NSError * _Nonnull error) {
        
    }];
    
//    _webView.scrollView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    
//    self.activityIndicator = [[UIActivityIndicatorView alloc] init];
//    [self.view addSubview:self.activityIndicator];
//    self.activityIndicator.bounds = CGRectMake(0, 0, 22, 22);
//    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    //    [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.center.equalTo(self.view);
    //        make.height.equalTo(@60);
    //        make.width.equalTo(@60);
    //    }];
//    if (self.navigationController.viewControllers.count >1) {
//
//        UIButton    *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.bounds = CGRectMake(0, 0, 33, 33);
//        //        button.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
//
//
//        NSAttributedString *attrs = [NSAttributedString wxp_iconFontWithCode:WXPIconfontBack Size:32.f color:UIColorFromRGB(0x666666)];
//
//        [button setAttributedTitle:attrs forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(popview) forControlEvents:UIControlEventTouchUpInside ];
//
//        self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:button],[[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator]];
//
//    } else {
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
//    }
//    [self.activityIndicator startAnimating];
    
    
//    self.cartPath  = [WXPUser shareInstance].cartpath?:@"cart.html";
//    if (![WXPUser shareInstance].cartjs) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];
//    }
    
    // Do any additional setup after loading the view.
}


- (UIButton *)rightButton  {
    
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.bounds = CGRectMake(0, 0, 56, 24);
        NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:13.f],
                               NSForegroundColorAttributeName:[UIColor whiteColor]
                               };
        NSAttributedString *attrs = [[NSAttributedString alloc] initWithString:@"去领券" attributes:dict];
        [_rightButton setAttributedTitle:attrs forState:UIControlStateNormal];
        //        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        //        UIImage *image = [UIImage imageNamed:@"coupon_check"];
        //        [_rightButton setBackgroundImage:image forState:UIControlStateNormal];
        //_rightButton.backgroundColor = UIColorFromRGB(0xcd31fe);
        _rightButton.layer.cornerRadius =12;
        _rightButton.layer.masksToBounds = YES;
        _rightButton.backgroundColor = [UIColor setGradualChangingColor:CGRectMake(0, 0, 56, 24) fromColor:UIColorFromRGB(0xfc9926) toColor:UIColorFromRGB(0xfc4b36)];
        
        [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    
    return _rightButton;
    
}

- (void)rightButtonClick {
    
//    WXPScanResultViewController *resultController = [[WXPScanResultViewController alloc] init];
//    resultController.couponArray = self.couponArray.copy;
//    [self.navigationController pushViewController:resultController animated:YES];
    WLScanResultViewController *resultController = [[WLScanResultViewController alloc] init];
    resultController.dataArray  = self.couponArray.copy;
    [self.navigationController pushViewController:resultController animated:YES];
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlstring =request.URL.absoluteString;
    if([urlstring hasPrefix:@"tbopen://"]) {
        
        return NO;
        
    }
    
    if (![urlstring containsString:self.cartPath]) {
        
//        [WXPBaichuanHanlder viewController:self openByUrl:urlstring success:^(AlibcTradeResult *result) {
//
//        } failed:^(NSError *error) {
//
//        }];
//
        [FishAliHandler viewController:self openWithUrl:urlstring success:^(AlibcTradeResult * _Nonnull result) {
            
        } failed:^(NSError * _Nonnull error) {
            
        }];
        
        
        return NO;
    }
    
    
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
    //    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
//    [self.webView.scrollView.mj_header endRefreshing];
    
    if (!webView.isLoading) {
        self.bcJsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        self.bcJsContext[@"bcJsContext"] = self;
        NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
        BOOL complete = [readyState isEqualToString:@"complete"];
        if (complete) {
            [self webViewDidFinishLoadCompletely];
        } else {
            NSString *jsString =
            @"window.onload = function() {"
            @"    bcJsContext.onload();"
            @"};"
            @"document.onreadystatechange = function () {"
            @"    if (document.readyState == \"complete\") {"
            @"        bcJsContext.documentReadyStateComplete();"
            @"    }"
            @"};";
            [webView stringByEvaluatingJavaScriptFromString:jsString];
        }
        
        
    }
    
    
    
}

- (void)onload {
    
}


- (void)documentReadyStateComplete{
    [self webViewDidFinishLoadCompletely];
}

- (void)webViewDidFinishLoadCompletely {
    
    //    return;
    
    _hasLoad  =2;
    
    //    NSString *string = [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('html')[0].innerHTML"];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.activityIndicator stopAnimating];
        
        
        if (self.cartjs) {
            
            
            if (!self.itemArray) {
                
                [self.bcJsContext evaluateScript:self.cartjs];
                
                // 2. 接收值
                JSValue *squre = [self.bcJsContext evaluateScript:@"scancart()"];
                
                NSArray *arr = squre.toArray;
                
                if (arr.count) {
                    self.itemArray = arr;
                    self.totalCount = self.itemArray.count;
                    [self.couponArray removeAllObjects];
                    [self addTimer];
                }else {
                    if (!self.couponCount) {
                        self.navigationItem.title  =@"购物车";
                    }
                    
                }
                
                
            }
            
        }
        
        
        
    });
    
    
    
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
//    [self.activityIndicator stopAnimating];

    if (!_hasLoad) {
        _hasLoad = 1;
    }
    
}

- (void)close:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)goback:(UIButton *)button {
    
    //    if ([self.webView canGoBack]) {
    //        [self.webView goBack];
    //    } else {
    
    [self.navigationController popViewControllerAnimated:YES];
    //    }
    
}

- (void)addTimer {
    
    if (!_timer)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        self.scanindex = 0;
        self.hasScanCount = 0;
        self.couponCount = 0;
        self.couponAmount = 0 ;
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}



- (void)nextPage {
    
    if (self.scanindex == self.totalCount) {
        [self removeTimer];
        
        //        NSLog(@"1234567890");
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self check];
        });
        return;
        
    }
    
    NSDictionary *dict = self.itemArray[self.scanindex];
    
    [FishNetworkFirstHandler xunquansearchCheckWithparamater:dict success:^(NSURLResponse *response, id data) {
        
        self.hasScanCount = self.hasScanCount + 1;
        
        if (data) {
            FishCouponItemModel *model = [FishCouponItemModel yy_modelWithJSON:data];
            [self.couponArray addObject:model];
            self.couponCount  =self.couponCount + 1;
            self.couponAmount = self.couponAmount + model.coupon_amount;
            [self refreshTitle];
        }
        
        
        if (self.hasScanCount  == self.totalCount ) {
            [self showRight];
        }
        
    } failed:^(NSError *error) {
        
    }];
    
  
    self.scanindex = self.scanindex + 1;
    
}

- (void)check {
    
    if (self.hasScanCount != self.totalCount) {
        
        [self showRight];
        
    }
    
}



- (void)showRight {
    
    if (self.couponCount > 0) {
        self.rightButton.hidden = NO;
    } else {
        
        self.rightButton.hidden = YES;
        self.navigationItem.title = @"没有扫描到优惠券";
    }
    
}

- (void)refreshTitle {
    
    
    self.navigationItem.title = [NSString stringWithFormat:@"%d张优惠券,可省%d元",self.couponCount,self.couponAmount];
    
}



-(void)removeTimer{
    //注销定时器
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}


- (void)receivePOpOutNote:(NSNotification*)note {
    // NSLog(@"popout");
    
    if (self.bcJsContext) {
        self.bcJsContext[@"bcJsContext"] = nil;
    }
}


- (void)dealloc {
    
    [self removeTimer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
