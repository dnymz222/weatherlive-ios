//
//  WLTabBarController.m
//  Weather-live
//
//  Created by xueping on 2019/5/21.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLTabBarController.h"
#import "WLNavigationController.h"
#import "WLWeatherViewController.h"
#import "WLIndexViewController.h"
#import "WLShoppingViewController.h"
#import "WLMineViewController.h"
#import "WLCartViewController.h"
#import "ColorSizeMacro.h"
#import "WLDayWeatherViewController.h"


@interface WLTabBarController ()

@end

@implementation WLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    WLWeatherViewController *weathervc = [[WLWeatherViewController alloc] init];
    WLNavigationController *weathernav = [[WLNavigationController alloc] initWithRootViewController:weathervc];
    
    UITabBarItem *item0 = [[UITabBarItem alloc] initWithTitle:@"当前天气" image:[[UIImage imageNamed: @"tab_weather_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed: @"tab_weather_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    weathervc.tabBarItem = item0;
    
    
    WLDayWeatherViewController *dayvc = [[WLDayWeatherViewController alloc] init];
    WLNavigationController *daynav = [[WLNavigationController alloc] initWithRootViewController:dayvc];
    
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"逐日天气" image:[[UIImage imageNamed: @"tab_daily_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed: @"tab_daily_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    dayvc.tabBarItem = item1;
    

    
    
    
    
    WLIndexViewController *indexvc = [[WLIndexViewController alloc] init];
    WLNavigationController *indexnav = [[WLNavigationController alloc] initWithRootViewController:indexvc];
    
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"生活指数" image:[[UIImage imageNamed: @"tab_index_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed: @"tab_index_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    indexvc.tabBarItem = item2;
    
    
    
    //    FIshTideViewController *tidevc = [[FIshTideViewController alloc] init];
    //    FishNavigationController *tidenav = [[FishNavigationController  alloc] initWithRootViewController:tidevc];
    //    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"潮汐" image:[[UIImage imageNamed: @"tab_tide_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed: @"tab_tide_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //    tidevc.tabBarItem = item3;
    
    
    
    WLShoppingViewController *shoppingvc = [[WLShoppingViewController alloc] init];
    WLNavigationController *shopingnav = [[WLNavigationController alloc] initWithRootViewController:shoppingvc];
    
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"优惠商城" image:[[UIImage imageNamed: @"tab_shop_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed: @"tab_shop_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    shoppingvc.tabBarItem = item3;
    
    
    
    
    WLMineViewController *minevc = [[WLMineViewController alloc] init];
    WLNavigationController *minenav = [[WLNavigationController alloc] initWithRootViewController:minevc];
    
    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"我的设置" image:[[UIImage imageNamed: @"tab_mine_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed: @"tab_mine_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    minevc.tabBarItem = item4;
    
    
    self.viewControllers = @[weathernav,daynav,indexnav,shopingnav,minenav];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x666666), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11.f], NSFontAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:                                                         [NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(Themecolor),NSForegroundColorAttributeName, nil]forState:UIControlStateSelected];
    
    
    
    // Do any additional setup after loading the view.
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
