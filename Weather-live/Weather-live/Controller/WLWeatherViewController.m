//
//  WLWeatherViewController.m
//  Weather-live
//
//  Created by xueping on 2019/5/21.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLWeatherViewController.h"
#import "Masonry.h"
#import "ColorSizeMacro.h"
#import "LBKeyMacro.h"
#import "STLocationModel.h"
#if __IPHONE_10_0
#import<CoreTelephony/CTCellularData.h>
#endif
#import "FishNetworkFirstHandler.h"
#import "WLWeatherLocationHandler.h"
#import <CoreLocation/CoreLocation.h>
#import "STAcuuWeatherDailyModel.h"
#import "STAcuuWeatherDailyCell.h"
#import "YYModel.h"
#import "STAcuuWeatherHeaderView.h"
#import "STAcuuWeatherFooterView.h"
#import "STAcuuHeaderLineModel.h"
#import "WLAccuCurrentCell.h"
#import "WLAccuCurrentModel.h"
#import "WLAccuHourlyModel.h"
#import "WLAccuHourlyCell.h"
#import "WLAccuNormalHeaderView.h"
#import "WLAccuAlarmsModel.h"
#import "WLAccuAlarmsCell.h"
#import "WLAccuLocationModel.h"
#import "WLAccuRadarCell.h"
#import "WLAccuuRadarModel.h"
#import "SDWebImageDownloader.h"
#import "SDWebImageManager.h"
#import "FishMapSelectPositionViewController.h"
#import "WLXinzhiAqiModel.h"
#import "WLXinzhiAqiCell.h"
#import "WXPErrorTipView.h"
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "WLXunquanBannerModel.h"
#import "LBBannerCell.h"
#import "FishAliHandler.h"
#import "WLAliWebController.h"



typedef NS_ENUM(NSInteger ,WLWeatherSectionType) {
    WLWeatherSectionTypeCurrent=0,
    WLWeatherSectionTypeHour,
    WLWeatherSectionTypeAqi,
    WLWeatherSectionTypeBanner,
    WLWeatherSectionTypeRadar,
    WLWeatherSectionTypeAlarms,
    
    
};




@interface WLWeatherViewController ()<CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,STAcuuWeatherFooterViewDelegate,FishMapSelectPositionViewControllerDelegate,WXPErrorTipViewDelegate,LBBannerCellDelegate>

@property(nonatomic,strong)STLocationModel *location;

@property(nonatomic,strong)CLLocationManager*loctionmanager;

@property(nonatomic,copy)NSString *locationKey;

//@property(nonatomic,strong)NSMutableArray *dataArray;


@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)WLAccuCurrentModel *cuurrentModel;

@property(nonatomic,copy)NSArray *hourArray;

@property(nonatomic,assign)NSInteger sectionCount;

@property(nonatomic,strong)NSMutableArray *sectionArray;

@property(nonatomic,strong)NSArray *alarmsArray;

@property(nonatomic,strong)WLAccuLocationModel *acculoction;

@property(nonatomic,strong)NSArray *radarArray;

@property(nonatomic,assign)NSInteger radarTime;
@property(nonatomic,assign)NSInteger lastRadarTime;

@property(nonatomic,strong)WLXinzhiAqiModel *aqiModel;
@property(nonatomic,assign)NSInteger currentTime;
@property(nonatomic,assign)NSInteger lastCurrentTime;

@property(nonatomic,assign)NSInteger hourlyTime;
@property(nonatomic,assign)NSInteger lasthourRequestTime;

@property(nonatomic,assign)NSInteger aqiTime;
@property(nonatomic,assign)NSInteger lastAqiTime;

@property(nonatomic,strong)NSTimer *timer;


@property(nonatomic,assign)NSInteger fialedTimes;


@property(nonatomic,assign)NSInteger failedLimitTime;

@property(nonatomic,strong)NSArray *bannerArray;

@property(nonatomic,assign)BOOL ShowBanner;

@property(nonatomic,strong)NSDateFormatter   *formatter;





@end

@implementation WLWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
     self.sectionArray = [NSMutableArray array];
//    self.dataArray = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    self.currentTime = 0;
    self.radarTime = 0;
    self.hourlyTime = 0;
    self.lasthourRequestTime = 0;
    self.aqiTime = 0;
    self.failedLimitTime = 0;
    
    
    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    
    
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:locationkey]) {
        
        double latitude  = [[NSUserDefaults standardUserDefaults] doubleForKey:latitudekey];
        double longtitude = [[NSUserDefaults standardUserDefaults] doubleForKey:longtitudekey];
        
        CLLocation  *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longtitude];
        STLocationModel *model = [[STLocationModel alloc] initWithClLocation:location];
        [WLWeatherLocationHandler sharehanlder].locationModel = model;
        self.locationKey = [[NSUserDefaults standardUserDefaults] valueForKey:locationkey];
        NSString *localizedName = [[NSUserDefaults standardUserDefaults] valueForKey:localizenamekey];
        self.navigationItem.title = localizedName;
        WLAccuLocationModel *acuulocation = [[WLAccuLocationModel alloc] init];
        acuulocation.LocalizedName = localizedName;
        acuulocation.Key = self.locationKey;
        [WLWeatherLocationHandler sharehanlder].accuLoctionModel = acuulocation;
        [self requestWeatherFromNewkey:YES];

        
        
        
        
        
    } else {
        
        self.locationKey = @"";
        
        [self locationrefresh];
    }
    
    
    UIButton *mapbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    mapbutton.bounds = CGRectMake(0, 0, 44, 44);
    UIImage *cartImage = [UIImage imageNamed:@"map"];
    [mapbutton setImage:cartImage forState:UIControlStateNormal];
    [mapbutton addTarget:self action:@selector(mapbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mapbutton];
    
    
    UIButton *refreshbutton  = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshbutton.bounds = CGRectMake(0, 0, 44, 44);
    UIImage *searchImage = [UIImage imageNamed:@"refresh"];
    [refreshbutton setImage:searchImage forState:UIControlStateNormal];
    [refreshbutton addTarget:self action:@selector(refreshbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:refreshbutton];
    
    
    
    
    
    
#if __IPHONE_10_0
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasAllowNetworkKey"]) {
        [self networkStatusListen];
    }

    
#endif
    
    [self requestBanner];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"showbanner"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showbanner"];
        self.ShowBanner = NO;
    } else {
        self.ShowBanner = YES;
    }

     
     
     
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterbackGrouund:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self checkData];
        
    });
    
    // Do any additional setup after loading the view.
}

- (void)checkData {
    
    if (!self.locationKey) {
        return;
    }
    
    if (!self.cuurrentModel) {
        [self requestCurrent];
    }
    
    if (!self.hourArray) {
        [self requestHourly];
    }
    
    if (!self.radarArray) {
        [self requestRadar];
    }
    
    if (!self.aqiModel) {
        [self requestAqi];
    }
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if (self.cuurrentModel || self.aqiModel) {
        [self requestWeatherFromNewkey:NO];
    }
    
}


- (void)becomeActive:(NSNotification *)note {
    
    if (self.cuurrentModel||self.aqiModel) {
        [self requestWeatherFromNewkey:NO];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"showbanner"]) {
        self.ShowBanner = YES;
    }
    
    [self requestBanner];
    
    [self addTimer];
}

- (void)enterbackGrouund:(NSNotification *)note {
    
    [self removeTimer];
}
     
     

- (void)timecalcute {
    
    if (self.locationKey) {
        if (!self.tabBarController.selectedIndex) {
            [self requestWeatherFromNewkey:NO];
        }
    }
}


- (void)addTimer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(timecalcute) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)removeTimer {
    if (_timer) {
        [_timer invalidate];
    }
    _timer = nil;
}



- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    
    return _tableView;
}

- (CLLocationManager *)loctionmanager
{
    if (_loctionmanager == nil) {
        _loctionmanager =[[CLLocationManager alloc]init ];
        _loctionmanager.delegate =self;
        //self.loctionmanager =_loctionmanager;
    }
    
    
    return _loctionmanager;
}


- (void)mapbuttonClick:(UIButton *)button {
    
    
//    STMapSelectPositionViewController *mapselectController = [[STMapSelectPositionViewController alloc] init];
//    mapselectController.delegate = self;
//    [self.navigationController pushViewController:mapselectController animated:YES];
    
    FishMapSelectPositionViewController *mapController = [[FishMapSelectPositionViewController alloc] init];
    mapController.delegate = self;
    [self.navigationController pushViewController:mapController animated:YES];
    
    
    
    
    
}

- (void)mapSelectPositionViewControllerDidSelected:(STLocationModel *)loction {
    
    
    [WLWeatherLocationHandler sharehanlder].locationModel = loction;
    
    [self requestLocationKey];
    
    
}

- (void)refreshbuttonClick:(UIButton *)button {
    
    
    [self locationrefresh];
}



#if __IPHONE_10_0
- (void)networkStatusListen{
    //2.根据权限执行相应的交互
    CTCellularData *cellularData = [[CTCellularData alloc] init];
    
    if (cellularData.restrictedState == kCTCellularDataRestricted ||
        cellularData.restrictedState == kCTCellularDataRestrictedStateUnknown) {
        /*
         此函数会在网络权限改变时再次调用
         */
        cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
            switch (state) {
                case kCTCellularDataRestricted:
                    
                    //                    [self reloadAlldata];
                    //                    [self requestWeather];
                    
                    break;
                case kCTCellularDataNotRestricted:
                    
                    
                    // [self reloadAlldata];
                    //                    [self requestWeather];
                    [self reloadRequest];
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasAllowNetworkKey"];
                    
                    break;
                case kCTCellularDataRestrictedStateUnknown:
                    
                    //                    [self reloadAlldata];
                    //                    [self requestWeather];
                    
                    
                    break;
                    
                default:
                    break;
            }
        };
    }
    
    
}


-(void)reloadRequest {
    
    
//    [self ];
    [self requestBanner];
    
    if ([WLWeatherLocationHandler sharehanlder].locationModel) {
        [self requestLocationKey];
    }
    
    [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
}

#endif


- (void)requestConfig {
    
    
    [FishNetworkFirstHandler configWithparamater:@{} success:^(NSURLResponse *response, id data) {
        
        
       
        
        
        
    } failed:^(NSError *error) {
        
    }];
    
    
    
}

- (void)locationrefresh
{
    
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if ([CLLocationManager locationServicesEnabled]) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >8.0) {
            
            [self.loctionmanager requestWhenInUseAuthorization];
            
            
        }
        
        
        [self.loctionmanager startUpdatingLocation];
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"refreshed"]) {
            if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status ) {
                UIAlertView *alert =[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"note", nil) message:NSLocalizedString(@"location service", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", nil) otherButtonTitles:NSLocalizedString(@"go to setting", nil),nil];
                
                [alert show];
                
                
            }
            
        }
        else{
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"refreshed"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        
        
    }
    //    else {
    //        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提醒" message:@"请在‘设置—隐私-位置’界面打开定位" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    //
    //        [alert show];
    //
    //    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex  {
    
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    if (buttonIndex ) {
        
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
            //此处可以做一下版本适配，至于为何要做版本适配，大家应该很清楚
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}


#pragma mark cllocationmanagerdelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *loc = [locations lastObject];
    
    
    
    [[NSUserDefaults standardUserDefaults] setDouble:loc.coordinate.latitude forKey:latitudekey ];
    
    [[NSUserDefaults standardUserDefaults] setDouble:loc.coordinate.longitude forKey:longtitudekey];

    
    
    STLocationModel *model = [[STLocationModel alloc] initWithClLocation:loc];
    
    [WLWeatherLocationHandler sharehanlder].locationModel  = model;
    
    [self requestLocationKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:locationchangednoteKey object:nil];
    
    
    
    
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:refreshkey]) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:refreshkey];
    }
    
    
    
    
    [manager stopUpdatingLocation];
}






- (void)requestLocationKey {
    
    NSString   *latitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.latitude];
    NSString  *longtitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.longitude];
    
    
    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
    NSInteger total = [FishNetwork cacluteTotalWithLat:latitude lon:longtitude time:timestamp];
    
    NSDictionary *dict = @{@"lat":latitude,
                           @"lng":longtitude,
                           @"time":[NSString stringWithFormat:@"%ld",timestamp],
                           @"total":[NSString stringWithFormat:@"%ld",total],
                           @"language":@"zh-cn"
                           };
    
    [FishNetworkFirstHandler acuuloctationKeyWithparamater:dict success:^(NSURLResponse *response, id data) {
        
        
        self.acculoction =[WLAccuLocationModel yy_modelWithJSON:data];
        
        if (self.acculoction ) {
            
            if (!self.locationKey) {
                [WXPErrorTipView removeErrorviewInView:self.view];
            }
            
            BOOL newkey = ![self.acculoction.Key isEqualToString:self.locationKey];
            
            
            self.locationKey = self.acculoction.Key;
            [WLWeatherLocationHandler sharehanlder].accuLoctionModel = self.acculoction;
            
            if (newkey) {
                [[NSUserDefaults standardUserDefaults] setObject:self.locationKey forKey:locationkey];
                [[NSUserDefaults standardUserDefaults] setObject:self.acculoction.LocalizedName forKey:localizenamekey];
                self.navigationItem.title = self.acculoction.LocalizedName;
                [[NSNotificationCenter defaultCenter] postNotificationName:loctionkeygetkey object:nil];
            }
           
           
            [self requestWeatherFromNewkey:newkey];
            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self requestAlarms];
//            });
           
        }
        
        
    } failed:^(NSError *error) {
        
        if (!self.locationKey) {
            [WXPErrorTipView showInView:self.view delegate:self];
            
        }
    }];
    
}

- (void)errorviewTapinView:(WXPErrorTipView *)errorView {
    
    [self requestBanner];
    [[AlibcTradeSDK sharedInstance]asyncInitWithSuccess:^{
        
    } failure:^(NSError *error) {
        
    }];
    if (!self.locationKey) {
         [self requestLocationKey];
    } else {
        
        [self requestWeatherFromNewkey:YES];
    }
    
}

- (void)requestWeatherFromNewkey:(BOOL)newkey {
    
    NSInteger nowtime =[[ NSDate date] timeIntervalSince1970];
    if (newkey) {
        
        self.fialedTimes = 0;
        [self requestCurrent];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self requestHourly];
        });
        
     
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self requestAqi];
        });
        
        
    } else {
        
        if (nowtime -self.failedLimitTime > 600) {
            self.fialedTimes = 0;
        }
        
        
        
        if (self.fialedTimes > 10) {
            self.failedLimitTime = [[NSDate date] timeIntervalSince1970];
            return;
        }
        
        if (nowtime - self.currentTime > 900 && (nowtime-self.lastCurrentTime >300) ) {
            [self requestCurrent];
        }
        
        
        if (nowtime -self.hourlyTime> 900 && (nowtime-self.lasthourRequestTime>300)) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self requestHourly];
            });
        }
        
        
        if (nowtime-self.aqiTime > 3600  && (nowtime-self.lastAqiTime > 300)) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self requestAqi];
            });
        }
        
    }
 
    
    if (nowtime - self.radarTime > 900  && (nowtime -self.lastRadarTime > 300)) {
       
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self requestRadar];
        });
    }
   
    
    
    
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self requestAlarms];
//    });
    
    

}

- (void)requestCurrent {
    
    NSString   *latitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.latitude];
    NSString  *longtitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.longitude];
    
    
    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
    NSInteger total = [FishNetwork cacluteTotalWithLat:latitude lon:longtitude time:timestamp];
    
    NSDictionary *dict = @{@"lat":latitude,
                           @"lng":longtitude,
                           @"time":[NSString stringWithFormat:@"%ld",timestamp],
                           @"total":[NSString stringWithFormat:@"%ld",total],
                           @"locationkey":self.locationKey,
                           @"language":@"zh-cn"
                           };
    
    [FishNetworkFirstHandler accuCurrentWithparamater:dict success:^(NSURLResponse *response, id data) {
        
        self.lastCurrentTime = [[NSDate date] timeIntervalSince1970];
        NSArray *dataArray = (NSArray *)data;
        
        WLAccuCurrentModel *model = [WLAccuCurrentModel yy_modelWithJSON:dataArray[0]];
        if (model.WeatherIcon ) {
            self.currentTime = model.EpochTime;
            
            self.cuurrentModel = model;
            dispatch_async(dispatch_get_main_queue(), ^{
                 [self.tableView reloadData];
            });
           
        }
        
    } failed:^(NSError *error) {
        self.fialedTimes = self.fialedTimes +1;
        [self checkeFialed];
        self.lastCurrentTime = [[NSDate date] timeIntervalSince1970];
        
    }];
}

- (void)requestHourly {
    
    NSString   *latitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.latitude];
    NSString  *longtitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.longitude];
    
    
    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
    NSInteger total = [FishNetwork cacluteTotalWithLat:latitude lon:longtitude time:timestamp];
    
    NSDictionary *dict = @{@"lat":latitude,
                           @"lng":longtitude,
                           @"time":[NSString stringWithFormat:@"%ld",timestamp],
                           @"total":[NSString stringWithFormat:@"%ld",total],
                           @"locationkey":self.locationKey,
                           @"language":@"zh-cn"
                           };
    
    [FishNetworkFirstHandler accuHourlyWithparamater:dict success:^(NSURLResponse *response, id data) {
        
        NSArray *array = [NSArray yy_modelArrayWithClass:[WLAccuHourlyModel class] json:data];
        self.lasthourRequestTime =[[NSDate date] timeIntervalSince1970];
        
        if (array && array.count) {
            [WXPErrorTipView removeErrorviewInView:self.view];
            self.hourArray = array;
            WLAccuHourlyModel *model  = self.hourArray[0];
            
            
            self.hourlyTime = model.EpochDateTime;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                 [self.tableView reloadData];
            });
           
        }
        
    } failed:^(NSError *error) {
        
        self.lasthourRequestTime =[[NSDate date] timeIntervalSince1970];
        self.fialedTimes  = self.fialedTimes +1;
        [self checkeFialed];
    }];;
}

- (void)requestRadar {
    
    NSString   *latitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.latitude];
    NSString  *longtitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.longitude];
    
    
    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
    NSInteger total = [FishNetwork cacluteTotalWithLat:latitude lon:longtitude time:timestamp];
    
    NSDictionary *dict = @{@"lat":latitude,
                           @"lng":longtitude,
                           @"time":[NSString stringWithFormat:@"%ld",timestamp],
                           @"total":[NSString stringWithFormat:@"%ld",total],
                           @"locationkey":self.locationKey,
                           @"language":@"zh-cn",
                           @"image":@"480x480"
                           
                           };
    
    [FishNetworkFirstHandler accuRadarWithparamater:dict success:^(NSURLResponse *response, id data) {
          self.lastRadarTime = [[NSDate date] timeIntervalSince1970];
        NSDictionary *dataDict = (NSDictionary *)data;
        NSDictionary *Satellite = [dataDict valueForKey:@"Satellite"];
        if (Satellite) {
            NSArray *images = [Satellite valueForKey:@"Images"];
            NSArray *array = [NSArray yy_modelArrayWithClass:[WLAccuuRadarModel class] json:images];
            if (array && array.count) {
                self.radarArray = array;
                [WXPErrorTipView removeErrorviewInView:self.view];
                
                WLAccuuRadarModel *lastmodel  = [self.radarArray lastObject];
                NSString *string = [lastmodel.Date stringByReplacingOccurrencesOfString:@"T" withString:@" "];
                string = [string stringByReplacingOccurrencesOfString:@"+" withString:@" +"];
                NSDate *date = [self.formatter dateFromString:string];
                self.radarTime = [date timeIntervalSince1970];
              
                
            __block NSInteger count = 0;
            __weak typeof(self) wself = self;
            for (WLAccuuRadarModel *model in self.radarArray) {
               
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:[NSURL URLWithString:model.Url] options:SDWebImageDownloaderHighPriority|SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                        
                    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                        count =  count +1;
                        if (count > wself.radarArray.count -1) {
                            [wself.tableView reloadData];
                        }
                    }];
                });
            }
            }
            
            
        }
        
        
    } failed:^(NSError *error) {
        self.lastRadarTime = [[NSDate date] timeIntervalSince1970];
        self.fialedTimes = self.fialedTimes +1;
        [self checkeFialed];
        
    }];
}

- (void)requestAqi{
    
    NSString   *latitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.latitude];
    NSString  *longtitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.longitude];
    
    
    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
    NSInteger total = [FishNetwork cacluteTotalWithLat:latitude lon:longtitude time:timestamp];
    
    NSDictionary *dict = @{@"lat":latitude,
                           @"lng":longtitude,
                           @"time":[NSString stringWithFormat:@"%ld",timestamp],
                           @"total":[NSString stringWithFormat:@"%ld",total],
                           @"locationkey":self.locationKey,
                           @"language":@"zh-cn"
                           };
    
    [FishNetworkFirstHandler xinzhiAqiWithparamater:dict success:^(NSURLResponse *response, id data) {
        self.lastAqiTime = [[NSDate date] timeIntervalSince1970];
        NSDictionary *dataDict = (NSDictionary *)data;
        NSDictionary *airDict= [dataDict valueForKey:@"air"];
        if (airDict) {
            NSDictionary *city = [airDict valueForKey:@"city"];
            
             WLXinzhiAqiModel    *aqiModel = [WLXinzhiAqiModel yy_modelWithJSON:city];
            if (aqiModel ) {
                [WXPErrorTipView removeErrorviewInView:self.view];
                
                NSString *string = [aqiModel.last_update stringByReplacingOccurrencesOfString:@"T" withString:@" "];
                string = [string stringByReplacingOccurrencesOfString:@"+" withString:@" +"];
                NSDate *date = [self.formatter dateFromString:string];
                self.aqiTime  = [date timeIntervalSince1970];
                
                [aqiModel calcaulteType];
                self.aqiModel = aqiModel;
                [self.tableView reloadData];
            }
         
            
        }
        
        
    } failed:^(NSError *error) {
        self.lastAqiTime = [[NSDate date] timeIntervalSince1970];
        self.fialedTimes  = self.fialedTimes +1;
        [self checkeFialed];
    }];;
    
}

- (void)requestBanner {
    
    [FishNetworkFirstHandler xunquanbannerWithparamater:nil success:^(NSURLResponse *response, id data) {
        
        NSArray *bannerArry = [NSArray yy_modelArrayWithClass:[WLXunquanBannerModel class] json:data];
        if (bannerArry && bannerArry.count) {
            self.bannerArray = bannerArry;
            [self.tableView reloadData];
        }
        
    } failed:^(NSError *error) {
        
        
    }];
}


- (void)requestAlarms {
    
    NSString   *latitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.latitude];
    NSString  *longtitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.longitude];
    
    
    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
    NSInteger total = [FishNetwork cacluteTotalWithLat:latitude lon:longtitude time:timestamp];
    
    NSDictionary *dict = @{@"lat":latitude,
                           @"lng":longtitude,
                           @"time":[NSString stringWithFormat:@"%ld",timestamp],
                           @"total":[NSString stringWithFormat:@"%ld",total],
                           @"locationkey":self.locationKey,
                           @"language":@"zh-cn"
                           };
    
    [FishNetworkFirstHandler accuAlarmsWithparamater:dict success:^(NSURLResponse *response, id data) {
        
        self.alarmsArray  = [NSArray yy_modelArrayWithClass:[WLAccuAlarmsModel class] json:data];
        if (self.alarmsArray ) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        
    } failed:^(NSError *error) {
        
    }];
}

//- (void)requestWeather {
//
//    NSString   *latitude = [NSString stringWithFormat:@"%0.4f",[STSolunarTidesHandler sharehanlder].locationModel.location.coordinate.latitude];
//    NSString  *longtitude = [NSString stringWithFormat:@"%0.4f",[STSolunarTidesHandler sharehanlder].locationModel.location.coordinate.longitude];
//
//
//    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
//    NSInteger total = [FishNetwork cacluteTotalWithLat:latitude lon:longtitude time:timestamp];
//
//    NSDictionary *dict = @{@"lat":latitude,
//                           @"lng":longtitude,
//                           @"time":[NSString stringWithFormat:@"%ld",timestamp],
//                           @"total":[NSString stringWithFormat:@"%ld",total],
//                           @"locationkey":self.locationKey,
//                           @"language":@"zh-cn"
//                           };
//
//    [FishNetworkFirstHandler acuuWeatherWithparamater:dict success:^(NSURLResponse *response, id data) {
//
//        NSDictionary *dataDict  =(NSDictionary *)data;
//        NSArray *array = [NSArray yy_modelArrayWithClass:[STAcuuWeatherDailyModel class] json:dataDict[@"DailyForecasts"]];
//        if (array.count) {
//            [self.dataArray removeAllObjects];
//            [self.dataArray addObjectsFromArray:array];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                 [self.tableView reloadData];
//            });
//
//        }
//
//
//    } failed:^(NSError *error) {
//
//    }];
//
//
//
//
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    [self.sectionArray removeAllObjects];
    if (self.cuurrentModel) {
        [self.sectionArray addObject:@(WLWeatherSectionTypeCurrent)];
    }
    if (self.hourArray) {
        [self.sectionArray   addObject:@(WLWeatherSectionTypeHour)];
    }
    if (self.aqiModel) {
        [self.sectionArray addObject:@(WLWeatherSectionTypeAqi)];
    }
    
    if (self.cuurrentModel && self.hourArray && self.aqiModel && self.bannerArray && self.ShowBanner ) {
        [self.sectionArray addObject:@(WLWeatherSectionTypeBanner)];
    }
    
    if (self.radarArray && self.radarArray.count) {
        [self.sectionArray addObject:@(WLWeatherSectionTypeRadar)];
    }
    
//    if (self.alarmsArray ) {
//        [self.sectionArray addObject:@(WLWeatherSectionTypeAlarms)];
//
//    }
//
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
     WLWeatherSectionType type =(WLWeatherSectionType)[self.sectionArray[section] integerValue];
    if (WLWeatherSectionTypeAlarms == type) {
        return self.alarmsArray.count;
    } else {
        return 1;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WLWeatherSectionType type =(WLWeatherSectionType)[self.sectionArray[indexPath.section] integerValue];
    if (WLWeatherSectionTypeCurrent == type) {
        return 156;
    } else if (WLWeatherSectionTypeHour == type) {
        return 140;
    } else if (WLWeatherSectionTypeRadar == type) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        return width + 56;
    } else if (WLWeatherSectionTypeBanner == type) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        return width/440.f*180.f;
    }
    
    else if (WLWeatherSectionTypeAqi == type) {
        
        return 80;
    }
    else {
        return 90;
    }
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WLWeatherSectionType type =(WLWeatherSectionType)[self.sectionArray[indexPath.section] integerValue];
    if (WLWeatherSectionTypeCurrent == type) {
        WLAccuCurrentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"current"];
        if (cell == nil) {
            cell = [[WLAccuCurrentCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"current"];
        }
        [cell configCurrentModel:self.cuurrentModel];
        return cell;
    } else if (WLWeatherSectionTypeHour == type) {
        
        
        WLAccuHourlyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hour"];
        if (cell == nil) {
            cell  = [[WLAccuHourlyCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"hour"];
        }
        [cell configHourArray:self.hourArray];
        return cell;
       
    } else if (WLWeatherSectionTypeRadar == type) {
        WLAccuRadarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"radar"];
        if (cell == nil) {
            cell = [[WLAccuRadarCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"radar"];
        }
        
        [cell configRadarArray:self.radarArray time:self.radarTime];
        
        return cell;
        
    } else if (WLWeatherSectionTypeAqi == type) {
        
        WLXinzhiAqiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aqi"];
        if (cell == nil) {
            cell = [[WLXinzhiAqiCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"aqi"];
        }
        [cell configAqiModel:self.aqiModel];
        return cell;
    } else if (WLWeatherSectionTypeBanner == type) {
        LBBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"banner"];
        if (cell == nil) {
            cell = [[LBBannerCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"banner"];
            cell.delegate = self;
        }
        
        [cell configImageArray:[self.bannerArray valueForKey:@"imageUrl"]];
        
        return cell;
    }
    
    else {
        WLAccuAlarmsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil ) {
            
            cell = [[WLAccuAlarmsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        WLAccuAlarmsModel *model = self.alarmsArray[indexPath.row];
        [cell configAlarms:model];
        
        
        return cell;
    }
    
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 28;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.sectionArray.count < 3) {
        return 0.001f;
    }
    if (section <self.sectionArray.count-1) {
        return 0.001f;
    }
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    WLWeatherSectionType type =(WLWeatherSectionType)[self.sectionArray[section] integerValue];
    
    WLAccuNormalHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (headerView == nil) {
        headerView = [[WLAccuNormalHeaderView alloc] initWithReuseIdentifier:@"header"];
    }
        
    if (WLWeatherSectionTypeCurrent == type) {
        headerView.titleLabel.text = @"实况天气";
    } else if(WLWeatherSectionTypeHour == type) {
            headerView.titleLabel.text =@"24小时预报";
    } else if(WLWeatherSectionTypeRadar == type  ){
        headerView.titleLabel.text =@"气象雷达";
    } else if (WLWeatherSectionTypeAqi == type) {
        headerView.titleLabel.text = @"空气质量";
    } else if (WLWeatherSectionTypeBanner == type) {
        headerView.titleLabel.text = @"广告";
    }
    
    else {
        headerView.titleLabel.text =self.alarmsArray.count?@"天气预警":@"天气预警(无)";
    }
        
    return headerView;
        
        
    
    

}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.sectionArray.count <3) {
        return nil;
    }
    if (section < self.sectionArray.count -1) {
        return nil;
    }
    
    STAcuuWeatherFooterView *footrView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
    if (footrView == nil) {
        footrView = [[STAcuuWeatherFooterView alloc] initWithReuseIdentifier:@"footer"];
        footrView.delegate = self;
    }
    
    return footrView;
}

- (void)AcuuWeatherFooterViewClickButtonLink {
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://www.accuweather.com"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.accuweather.com"]];
    }
}


- (void)checkeFialed {
    
    if (self.fialedTimes > 3 && (!self.cuurrentModel) && (!self.aqiModel) &&(!self.radarArray) && (!self.hourArray)) {
        [WXPErrorTipView showInView:self.view delegate:self];
    }
}

- (void)lbBannerCellClickImageAtIndex:(NSInteger)index {
    
    WLXunquanBannerModel *banner  = self.bannerArray[index];
    if (2 == banner.type) {
        [FishAliHandler viewController:self openWithUrl:banner.bannerUrl success:^(AlibcTradeResult * _Nonnull result) {
            
            
            
        } failed:^(NSError * _Nonnull error) {
            
        }];
    } else if(1 == banner.type) {
        WLAliWebController *webvc = [[WLAliWebController alloc] init];
        webvc.urlString = banner.bannerUrl;
        
        [self.navigationController pushViewController:webvc animated:YES];
        
    } else {
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:banner.title]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:banner.title]];
        } else {
            WLAliWebController *webvc = [[WLAliWebController alloc] init];
            webvc.urlString = banner.bannerUrl;
            
            [self.navigationController pushViewController:webvc animated:YES];
            
        }
        
    }
    
}

- (void)dealloc {
    
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
