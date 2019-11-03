//
//  WLMineViewController.m
//  Weather-live
//
//  Created by xueping on 2019/5/21.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLMineViewController.h"
#import "ColorSizeMacro.h"
#import "Masonry.h"
#import "WLAliWebController.h"

//#include <AlibabaAuthSDK/ALBBSession.h>
//#import <AlibabaAuthSDK/ALBBSDK.h>

#import "WLNetworkFirstHandler.h"
//#import "WLXunquanConfigModel.h"
#import "YYModel.h"
//#import "WLJSWebViewController.h"

@interface WLMineViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,copy)NSArray *dataArray;

//@property(nonatomic,strong)WLXunquanConfigModel *config;

@end

@implementation WLMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.navigationItem.title = NSLocalizedString(@"mine", nil);
    
    self.dataArray = @[NSLocalizedString(@"rate on the App Store", nil),NSLocalizedString(@"share to friends", nil),NSLocalizedString(@"privacy", nil),NSLocalizedString(@"version", nil)];
    
    
    [self.view addSubview:self.tableView];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
        
    }];
    

   
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
    
    
}

//
//- (void)requestConfig {
//    [WLNetworkFirstHandler configWithparamater:nil success:^(NSURLResponse *response, id data) {
//
//        WLXunquanConfigModel *config  = [WLXunquanConfigModel yy_modelWithJSON:data];
//        if (config) {
//            self.config = config;
//            dispatch_async(dispatch_get_main_queue(), ^{
//                   [self.tableView reloadData];
//            });
//
//        }
//
//
//    } failed:^(NSError *error) {
//
//    }];
//
//}


- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.delegate  =self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    return _tableView;
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.textColor = UIColorFromRGB(0x666666);
        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13.f];
        cell.detailTextLabel.textColor = UIColorFromRGB(0xfc4b36);
        
        
        
    }
    
 
    NSString *string = self.dataArray[indexPath.row];
    cell.textLabel.text  = string;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.detailTextLabel.text = @"";
    
        if (3 == indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            NSDictionary *infoDictionary  = [[NSBundle mainBundle] infoDictionary];
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            cell.detailTextLabel.text = app_Version;
            
        } else if (4 == indexPath.row) {
            
         
        }
   
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

        if (0 == indexPath.row) {
            NSString *urlStr = [NSString

                                stringWithFormat:@"https://itunes.apple.com/us/app/itunes-u/id%@?action=write-review&mt=8",

                                @"1451403745"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];

        } else if (1 == indexPath.row) {

            [self activityShare];
        } else if(2 == indexPath.row) {

            WLAliWebController *aliwebvc = [[WLAliWebController alloc] init];
            
            aliwebvc.urlString = NSLocalizedString(@"privacy url", nil);
            [self.navigationController pushViewController:aliwebvc animated:YES];

        } else if(4 == indexPath.row) {
            
//            NSUInteger size = [[SDImageCache sharedImageCache] getSize];
//            if (size > 1024  ) {
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"清空缓存" message:@"确定要清空缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//                alertView.tag = 1;
//                [alertView show];
//
//            }
            
        }

        
    
 
}

- (void)activityShare{
    //appid 1451403745
    // 1、设置分享的内容，并将内容添加到数组中
    NSString *shareText = @"天气预报-生活指数";
    UIImage *shareImage = [UIImage imageNamed:@"tianqi"];
    NSURL *shareUrl = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1451403745?mt=8"];
    NSArray *activityItemsArray = @[shareText,shareImage,shareUrl];
    
    // 自定义的CustomActivity，继承自UIActivity
    //    CustomActivity *customActivity = [[CustomActivity alloc]initWithTitle:shareText ActivityImage:[UIImage imageNamed:@"custom.png"] URL:shareUrl ActivityType:@"Custom"];
    //    NSArray *activityArray = @[customActivity];
    
    // 2、初始化控制器，添加分享内容至控制器
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItemsArray applicationActivities:nil];
    
    activityVC.excludedActivityTypes=@[UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList ];
    
    
    activityVC.modalInPopover = YES;
    // 3、设置回调
    //    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
    // ios8.0 之后用此方法回调
    UIActivityViewControllerCompletionWithItemsHandler itemsBlock = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        //NSLog(@"activityType == %@",activityType);
        if (completed == YES) {
            NSLog(@"completed");
        }else{
            NSLog(@"cancel");
        }
    };
    activityVC.completionWithItemsHandler = itemsBlock;
    //    }
    
    //    else{
    //        // ios8.0 之前用此方法回调
    //        UIActivityViewControllerCompletionHandler handlerBlock = ^(UIActivityType __nullable activityType, BOOL completed){
    //            NSLog(@"activityType == %@",activityType);
    //            if (completed == YES) {
    //                NSLog(@"completed");
    //            }else{
    //                NSLog(@"cancel");
    //            }
    //        };
    //        activityVC.completionHandler = handlerBlock;
    //    }
    // 4、调用控制器
    [self presentViewController:activityVC animated:YES completion:nil];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    

        if (1 == buttonIndex) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self.tableView reloadData];
//                    });
//                    
//                }];
            });
            
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
