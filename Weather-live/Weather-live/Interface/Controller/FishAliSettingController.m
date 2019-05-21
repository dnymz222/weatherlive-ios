//
//  LBSettingController.m
//  lamabiji
//
//  Created by mc on 2018/9/14.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "FishAliSettingController.h"
#import "ColorSizeMacro.h"
#import "SDImageCache.h"
#include <AlibabaAuthSDK/ALBBSession.h>
#import <AlibabaAuthSDK/ALBBSDK.h>
#import "FishAliHandler.h"
#import "FishAliUser.h"
//#import "FishSettingCell.h"
#import "LBKeyMacro.h"


@interface FishAliSettingController () <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property(nonatomic ,weak)UITableView *tableView;
@property(nonatomic,copy)NSArray *dataArray;
//@property(nonatomic,copy)NSArray *imageArray;

@end

@implementation FishAliSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title =@"我的购物";
    
//    NSInteger showtimes = [[NSUserDefaults standardUserDefaults] integerForKey:showapptimeskey];
//    if (showtimes > [LBUser shareInstance].showscore) {
        _dataArray = @[@"我的订单",@"我的购物车",@"淘宝授权",@"清除缓存"];
//
//        _imageArray = @[@"order",@"cart_setting",@"taobao",@"empty"];
//    } else {
//        _dataArray = @[@"我的订单",@"我的购物车",@"淘宝授权",@"清除缓存"];
//    
//        _imageArray = @[@"order",@"cart_setting",@"taobao",@"empty"];
//    }
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:tableview];
    
    _tableView = tableview;
    
    _tableView.delegate = self ;
    _tableView.dataSource = self ;
    
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
    [self.tableView reloadData];
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44  ;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section?15:30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return nil;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"AlimineCellIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"AlimineCellIdentifier"];
        
        cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.f];
        cell.detailTextLabel.textColor = UIColorFromRGB(0xfc4b36);
        
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
        cell.textLabel.textColor = UIColorFromRGB(0x666666);
        
    }
    
    if (indexPath.section ==3) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (1 == indexPath.section) {
      
        
    } else if (indexPath.section ==2) {
        
        if ([[ALBBSession sharedInstance]  isLogin]) {
            
            cell.detailTextLabel.text = @"取消授权";
        } else {
            cell.detailTextLabel.text = @"去授权";
        }
        
        
    } else if (indexPath.section == 3) {
        
        NSUInteger size = [[SDImageCache sharedImageCache] getSize];
        if (size < 1024*1024) {
            cell.detailTextLabel.text = @"已清空";
        } else {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"缓存：%0.2fM",size/(1024.f*1024.f)];
        }
        
    }
    
  
    
    
    
    cell.textLabel.text= _dataArray[indexPath.section];
    

    
    return cell;
    
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
            
            [FishAliHandler openMyOrderFromViewController:self success:^(AlibcTradeResult * _Nullable result) {
                
            } failed:^(NSError * _Nullable error) {
                
            }];
            
            break;
            
        case 1:
            
            //
//            if ([LBUser shareInstance].cartjs) {
//                [LBAliHandler jsScanMyCartWithViewController:self success:^(AlibcTradeResult *result) {
//
//                } failed:^(NSError *error) {
//
//                }];
//            } else {
        {
            
                [FishAliHandler openMyCartFromViewController:self success:^(AlibcTradeResult * _Nullable result) {
                    
                } failed:^(NSError * _Nullable error) {
                    
                }];
        }
                
//            }
            
            
            break;
            
        case 2:
            
        {
            
            if ([[ALBBSession sharedInstance]  isLogin]) {
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"退出登录" message:@"确定要退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertView.tag = 0;
                [alertView show];
                
            } else{
                
                [[ALBBSDK sharedInstance] auth:self successCallback:^(ALBBSession *session) {
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                    });
                    
                } failureCallback:^(ALBBSession *session, NSError *error) {
                    
                }];
            }
            
        }
            break;
        case 3:
        {
            
            
            
            NSUInteger size = [[SDImageCache sharedImageCache] getSize];
            if (size > 1024*1024  ) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"清空缓存" message:@"确定要清空缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertView.tag = 1;
                [alertView show];
                
            }
            
        }
            break;
    case 4:
            
        {
            NSString *urlStr = [NSString
                                
                                stringWithFormat:@"https://itunes.apple.com/us/app/itunes-u/id%@?action=write-review&mt=8",
                                
                                @"1374113361"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        }
        
        
            
            break;
            

     
        default:
            break;
    }
    
    

    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //[alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    if (alertView.tag) {
        if (1 == buttonIndex) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                    });
                    
                }];
            });
            
        }
        
    } else {
        if (1 == buttonIndex) {
            [[ALBBSDK sharedInstance] logout];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
        }
        
    }
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
