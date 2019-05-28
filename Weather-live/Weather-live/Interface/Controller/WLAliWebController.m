//
//  LBAliWebController.m
//  lamabiji
//
//  Created by xueping on 2018/9/17.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "WLAliWebController.h"
#import "Masonry.h"
#import "ColorSizeMacro.h"

@interface WLAliWebController ()<UIWebViewDelegate>

@end

@implementation WLAliWebController

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
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
     CGFloat bootomspace = KIsiPhoneX ?34 :0;
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-bootomspace);
        
    }];
    
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.view);
        make.width.equalTo(@5);
    }];
    
    if (self.urlString) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
        [self.webView loadRequest:request];
    }
    
    

    // Do any additional setup after loading the view.
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if([request.URL.absoluteString hasPrefix:@"tbopen://"]) {
        
        return NO;
        
        
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    
    
    
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    
    
}

- (void)close:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

- (void)goback:(UIButton *)button {
    
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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
