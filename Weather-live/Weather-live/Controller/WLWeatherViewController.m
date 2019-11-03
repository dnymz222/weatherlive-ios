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
#import "WLNetworkFirstHandler.h"
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

#import "WLAccuLocationModel.h"

#import "FishMapSelectPositionViewController.h"
#import "WLAddressListViewController.h"
#import "WLXinzhiAqiModel.h"
#import "WLXinzhiAqiCell.h"
#import "WXPErrorTipView.h"

#import "WLAliWebController.h"
#if __IPHONE_10_3
#import <StoreKit/StoreKit.h>
#endif

#import "WLAccuIndexModel.h"
#import "WLIndexCell.h"
#import "WLIndexSelectViewController.h"




typedef NS_ENUM(NSInteger ,WLWeatherSectionType) {
    WLWeatherSectionTypeCurrent=0,
    WLWeatherSectionTypeHour,
    WLWeatherSectionTypeAqi,
//    WLWeatherSectionTypeBanner,
//    WLWeatherSectionTypeRadar,
//    WLWeatherSectionTypeAlarms,
    WLWeatherSectionTypeIndices,
    
    
    
};




@interface WLWeatherViewController ()<CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,STAcuuWeatherFooterViewDelegate,FishMapSelectPositionViewControllerDelegate,WXPErrorTipViewDelegate,SKStoreProductViewControllerDelegate,UIAlertViewDelegate,WLAddressListViewControllerDelegate>

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

//@property(nonatomic,strong)NSMutableArray *bannerArray;
//
//@property(nonatomic,assign)BOOL ShowBanner;

@property(nonatomic,strong)NSDateFormatter   *formatter;


@property(nonatomic,copy)NSArray *indexArray;
@property(nonatomic,copy)NSArray *dayArray;

@property(nonatomic,assign)NSInteger indexTime;
@property(nonatomic,strong)NSDateFormatter *dayfomatter;
@property(nonatomic,copy)NSString *day;

@property(nonatomic,assign)NSInteger lastIndexTime;

@property(nonatomic,copy)NSString *someDay;


@property(nonatomic,strong)NSUserDefaults *userDefaults;





@end

@implementation WLWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
     self.sectionArray = [NSMutableArray array];
//    self.bannerArray = [NSMutableArray array];
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
    
    self.dayfomatter = [[NSDateFormatter  alloc] init];
       [self.dayfomatter   setDateFormat:@"MM-dd"];
    
    self.userDefaults = [[NSUserDefaults alloc] initWithSuiteName:Appgroupkey];
    
    
    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    
    
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:locationkey_key]) {
        
        double latitude  = [[NSUserDefaults standardUserDefaults] doubleForKey:latitudekey];
        double longtitude = [[NSUserDefaults standardUserDefaults] doubleForKey:longtitudekey];
        
        CLLocation  *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longtitude];
        STLocationModel *model = [[STLocationModel alloc] initWithClLocation:location];
        [WLWeatherLocationHandler sharehanlder].locationModel = model;
        self.locationKey = [[NSUserDefaults standardUserDefaults] valueForKey:locationkey_key];
        NSString *localizedName = [[NSUserDefaults standardUserDefaults] valueForKey:localizenamekey];
        self.navigationItem.title = localizedName;
        WLAccuLocationModel *acuulocation = [[WLAccuLocationModel alloc] init];
        acuulocation.LocalizedName = localizedName;
        acuulocation.Key = self.locationKey;
        [WLWeatherLocationHandler sharehanlder].accuLoctionModel = acuulocation;
        [self requestWeatherFromNewkey:YES];
        if (![self.userDefaults valueForKey:AppgroupLoctionkeyKey]) {
            [self.userDefaults setObject:self.locationKey forKey:AppgroupLoctionkeyKey];
            [self.userDefaults setObject:localizedName forKey:AppgroupLoctionNameKey];
        }
        
        
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
    
    
    
    
    
    

    if (@available(iOS 10.0, *)) {
       if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasAllowNetworkKey"]) {
        [self networkStatusListen];
       }
    }

    

    
//    [self requestBanner];
    
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"showbanner"]) {
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showbanner"];
//        self.ShowBanner = NO;
//    } else {
//        self.ShowBanner = YES;
//    }

     
     
     
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterbackGrouund:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self checkData];
        
    });
    
    
    
    NSInteger times = [[NSUserDefaults standardUserDefaults] integerForKey:showapptimeskey]?:0;
    if (times < 100) {
        times  = times +1;
        [[NSUserDefaults standardUserDefaults] setInteger:times forKey:showapptimeskey];
    }
    
    if (times > 6) {
        if (![[NSUserDefaults standardUserDefaults] boolForKey:hasShowscoreKey]) {
            
#if __IPHONE_10_3
            [self loadAppStoreController];
#endif
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:hasShowscoreKey];
        }
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveIndeicesChangeNote) name:AppgroupIndiciesChangedKey object:nil];
    
    // Do any additional setup after loading the view.
}

#if __IPHONE_10_3


- (void)loadAppStoreController{
    
    if (@available(iOS 10.3, *)) {
        [SKStoreReviewController requestReview];
    } else {
        // Fallback on earlier versions
    }


}
#endif



- (void)receiveIndeicesChangeNote {
    
    [self.tableView reloadData];
    
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
    
//    if (!self.radarArray) {
//        [self requestRadar];
//    }
    
    if (!self.aqiModel) {
        [self requestAqi];
    }
    
    if (!self.indexArray) {
        [self requestIndex];
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
    
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"showbanner"]) {
//        self.ShowBanner = YES;
//    }
    
//    [self requestBanner];
    
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
    
//    FishMapSelectPositionViewController *mapController = [[FishMapSelectPositionViewController alloc] init];
//    mapController.delegate = self;
//    [self.navigationController pushViewController:mapController animated:YES];
    
    
    WLAddressListViewController *addressListController = [[WLAddressListViewController alloc] init];
    addressListController.delegate  = self;
    
    [self.navigationController pushViewController:addressListController animated:YES];
    
    
    
}

- (void)addresslistSelectlocation:(STLocationModel *)loction

{
    
    CLLocation *loc = loction.location;
    
    [[NSUserDefaults standardUserDefaults] setDouble:loc.coordinate.latitude forKey:latitudekey ];
    
    [[NSUserDefaults standardUserDefaults] setDouble:loc.coordinate.longitude forKey:longtitudekey];
    
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
   // [self requestBanner];
    
    if ([WLWeatherLocationHandler sharehanlder].locationModel) {
        [self requestLocationKey];
    }
    

    
    
    
}

#endif



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
                alert.tag = 0;
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
    if ( buttonIndex ) {
        
        if (0 == alertView.tag) {

            
                NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                //此处可以做一下版本适配，至于为何要做版本适配，大家应该很清楚
                [[UIApplication sharedApplication] openURL:url];
            

            
        } else {
            
            [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
            if (buttonIndex) {
                NSString *urlStr = [NSString
                                    
                                    stringWithFormat:@"https://itunes.apple.com/us/app/itunes-u/id%@?action=write-review&mt=8",
                                    
                                    @"1451403745"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
                
            }
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
    NSInteger total = [WLNetwork cacluteTotalWithLat:latitude lon:longtitude time:timestamp];
    
    NSDictionary *dict = @{@"lat":latitude,
                           @"lng":longtitude,
                           @"time":[NSString stringWithFormat:@"%ld",timestamp],
                           @"total":[NSString stringWithFormat:@"%ld",total],
                           @"language":NSLocalizedString(@"language", nil)
                           };
    
    [WLNetworkFirstHandler acuuloctationKeyWithparamater:dict success:^(NSURLResponse *response, id data) {
        
        
        WLAccuLocationModel *acuulocatoion =[WLAccuLocationModel yy_modelWithJSON:data];
        
        if (acuulocatoion ) {
            
            
            if (!self.locationKey) {
                [WXPErrorTipView removeErrorviewInView:self.view];
                
            }
            
            BOOL newkey = ![self.locationKey isEqualToString:acuulocatoion.Key];
            
            self.acculoction  = acuulocatoion;
            self.locationKey = self.acculoction.Key;
            [WLWeatherLocationHandler sharehanlder].accuLoctionModel = self.acculoction;
            
            if (newkey) {
                [[NSUserDefaults standardUserDefaults] setObject:self.locationKey forKey:locationkey_key];
                [[NSUserDefaults standardUserDefaults] setObject:self.acculoction.LocalizedName forKey:localizenamekey];
                self.navigationItem.title = self.acculoction.LocalizedName;
                [[NSNotificationCenter defaultCenter] postNotificationName:loctionkeygetkey object:nil];
                [self.userDefaults setObject:self.locationKey forKey:AppgroupLoctionkeyKey];
                [self.userDefaults setObject:self.acculoction.LocalizedName  forKey:AppgroupLoctionNameKey];
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
    
//    [self requestBanner];

    if (!self.locationKey) {
         [self requestLocationKey];
    } else {
        
        [self requestWeatherFromNewkey:YES];
    }
    
}

- (void)requestWeatherFromNewkey:(BOOL)newkey {
    
    NSInteger nowtime =[[ NSDate date] timeIntervalSince1970];
    
    self.day = [self.dayfomatter stringFromDate:[NSDate date]];
    
 
    if (newkey) {
        
        self.fialedTimes = 0;
        [self requestCurrent];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self requestHourly];
        });
        
     
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self requestAqi];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self requestIndex];
            
        });
        
        
    } else {
        
        if (nowtime -self.failedLimitTime > 600) {
            self.fialedTimes = 0;
        }
        
        
        
        if (self.fialedTimes > 5) {
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
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self requestAqi];
            });
        }
        
        
        
//        if (!self.indexTime) {
//
//        } else {
            NSDate *date = [NSDate date];
            NSInteger now = [date timeIntervalSince1970];
            NSString *nowday = [self.dayfomatter stringFromDate:date];
            BOOL sameday  =[nowday isEqualToString:self.day];
            if (sameday && self.indexTime) {
                if (now-_lastIndexTime > 6*3600) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       [self requestIndex];
                    });
                }
                
            } else {
                if (now- _lastIndexTime > 600) {
                    
                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       [self requestIndex];
                    });
                }
            }
            
//        }
        
    }
 
    
//    if (nowtime - self.radarTime > 900  && (nowtime -self.lastRadarTime > 300)) {
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self requestRadar];
//        });
//    }
   
    
    
    
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self requestAlarms];
//    });
    
    

}

- (void)requestCurrent {
    
    NSString   *latitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.latitude];
    NSString  *longtitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.longitude];
    
    
    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
    NSInteger total = [WLNetwork cacluteTotalWithLat:latitude lon:longtitude time:timestamp];
    
    NSDictionary *dict = @{@"lat":latitude,
                           @"lng":longtitude,
                           @"time":[NSString stringWithFormat:@"%ld",timestamp],
                           @"total":[NSString stringWithFormat:@"%ld",total],
                           @"locationkey":self.locationKey,
                           @"language":NSLocalizedString(@"language", nil)
                           };
    
    [WLNetworkFirstHandler accuCurrentWithparamater:dict success:^(NSURLResponse *response, id data) {
        
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
    NSInteger total = [WLNetwork cacluteTotalWithLat:latitude lon:longtitude time:timestamp];
    
    NSDictionary *dict = @{@"lat":latitude,
                           @"lng":longtitude,
                           @"time":[NSString stringWithFormat:@"%ld",timestamp],
                           @"total":[NSString stringWithFormat:@"%ld",total],
                           @"locationkey":self.locationKey,
                           @"metric":NSLocalizedString(@"is metric", nil),
                           @"language":NSLocalizedString(@"language", nil)
                           };
    
    [WLNetworkFirstHandler accuHourlyWithparamater:dict success:^(NSURLResponse *response, id data) {
        
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

//- (void)requestRadar {
//
//    NSString   *latitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.latitude];
//    NSString  *longtitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.longitude];
//
//
//    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
//    NSInteger total = [WLNetwork cacluteTotalWithLat:latitude lon:longtitude time:timestamp];
//
//    NSDictionary *dict = @{@"lat":latitude,
//                           @"lng":longtitude,
//                           @"time":[NSString stringWithFormat:@"%ld",timestamp],
//                           @"total":[NSString stringWithFormat:@"%ld",total],
//                           @"locationkey":self.locationKey,
//                           @"language":NSLocalizedString(@"language", nil),
//                           @"image":@"480x480"
//
//                           };
//
//    [WLNetworkFirstHandler accuRadarWithparamater:dict success:^(NSURLResponse *response, id data) {
//          self.lastRadarTime = [[NSDate date] timeIntervalSince1970];
//        NSDictionary *dataDict = (NSDictionary *)data;
//        NSDictionary *Satellite = [dataDict valueForKey:@"Satellite"];
//        if (Satellite) {
//            NSArray *images = [Satellite valueForKey:@"Images"];
//            NSArray *array = [NSArray yy_modelArrayWithClass:[WLAccuuRadarModel class] json:images];
//            if (array && array.count) {
//                self.radarArray = array;
//                [WXPErrorTipView removeErrorviewInView:self.view];
//
//                WLAccuuRadarModel *lastmodel  = [self.radarArray lastObject];
//                NSString *string = [lastmodel.Date stringByReplacingOccurrencesOfString:@"T" withString:@" "];
//                string = [string stringByReplacingOccurrencesOfString:@"+" withString:@" +"];
//                NSDate *date = [self.formatter dateFromString:string];
//                self.radarTime = [date timeIntervalSince1970];
//
//
//            __block NSInteger count = 0;
//            __weak typeof(self) wself = self;
//            for (WLAccuuRadarModel *model in self.radarArray) {
//
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:[NSURL URLWithString:model.Url] options:SDWebImageDownloaderHighPriority|SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//
//                    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//                        count =  count +1;
//                        if (count > wself.radarArray.count -1) {
//                            [wself.tableView reloadData];
//                        }
//                    }];
//                });
//            }
//            }
//
//
//        }
//
//
//    } failed:^(NSError *error) {
//        self.lastRadarTime = [[NSDate date] timeIntervalSince1970];
//        self.fialedTimes = self.fialedTimes +1;
//        [self checkeFialed];
//
//    }];
//}

- (void)requestAqi{
//#if DEBUG
//    return;
//#endif
//    
    NSString   *latitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.latitude];
    NSString  *longtitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.longitude];
    
    
    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
    NSInteger total = [WLNetwork cacluteTotalWithLat:latitude lon:longtitude time:timestamp];
    
    NSDictionary *dict = @{@"lat":latitude,
                           @"lng":longtitude,
                           @"time":[NSString stringWithFormat:@"%ld",timestamp],
                           @"total":[NSString stringWithFormat:@"%ld",total],
                           @"locationkey":self.locationKey,
                           @"language":NSLocalizedString(@"language", nil),
                           };
    
    [WLNetworkFirstHandler xinzhiAqiWithparamater:dict success:^(NSURLResponse *response, id data) {
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
    
//    if (self.cuurrentModel && self.hourArray && self.aqiModel &&  self.bannerArray.count && self.ShowBanner ) {
//        [self.sectionArray addObject:@(WLWeatherSectionTypeBanner)];
//    }
//
//    if (self.radarArray && self.radarArray.count) {
//        [self.sectionArray addObject:@(WLWeatherSectionTypeRadar)];
//    }
//
//    if (self.alarmsArray ) {
//        [self.sectionArray addObject:@(WLWeatherSectionTypeAlarms)];
//
//    }
//
    
    if (self.indexArray && self.indexArray.count) {
        [self.sectionArray addObject:@(WLWeatherSectionTypeIndices)];
    }
    
    
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
   
        return 1;
   
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WLWeatherSectionType type =(WLWeatherSectionType)[self.sectionArray[indexPath.section] integerValue];
    if (WLWeatherSectionTypeCurrent == type) {
        return 156;
    } else if (WLWeatherSectionTypeHour == type) {
        return 166;
    } 
    else if (WLWeatherSectionTypeAqi == type) {
        
        return 80;
    }
    else {
        return 94;
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
       
    }
    
//    else if (WLWeatherSectionTypeRadar == type) {
//        WLAccuRadarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"radar"];
//        if (cell == nil) {
//            cell = [[WLAccuRadarCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"radar"];
//        }
//
//        [cell configRadarArray:self.radarArray time:self.radarTime];
//
//        return cell;
//
//    }
    else if (WLWeatherSectionTypeAqi == type) {
        
        WLXinzhiAqiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aqi"];
        if (cell == nil) {
            cell = [[WLXinzhiAqiCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"aqi"];
        }
        [cell configAqiModel:self.aqiModel];
        return cell;
    }
//    else if (WLWeatherSectionTypeBanner == type) {
//        LBBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"banner"];
//        if (cell == nil) {
//            cell = [[LBBannerCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"banner"];
//            cell.delegate = self;
//        }
//
//        [cell configImageArray:[self.bannerArray valueForKey:@"image"]];
//
//        return cell;
//    }
    
    else {
        WLIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil ) {
            
            cell = [[WLIndexCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
//        WLAccuAlarmsModel *model = self.alarmsArray[indexPath.row];
//        [cell configAlarms:model];
        
        NSString *day = self.day;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Day=%@",day];
        NSArray *dataArray =[self.indexArray filteredArrayUsingPredicate:predicate];
        
        [cell configDataArray:dataArray];
        
        
        
      
        
        
        return cell;
    }
    
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 32;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.sectionArray.count < 3) {
        return 0.001f;
    }
    if (section <self.sectionArray.count-1) {
        return 0.001f;
    }
    
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    WLWeatherSectionType type =(WLWeatherSectionType)[self.sectionArray[section] integerValue];
    
    WLAccuNormalHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    if (headerView == nil) {
        headerView = [[WLAccuNormalHeaderView alloc] initWithReuseIdentifier:@"header"];
    }
        
    if (WLWeatherSectionTypeCurrent == type) {
        headerView.titleLabel.text = NSLocalizedString(@"current weather", nil);
        headerView.button.hidden  = YES;
    } else if(WLWeatherSectionTypeHour == type) {
        headerView.titleLabel.text = [NSString stringWithFormat:NSLocalizedString(@"houly weather", nil),self.hourArray.count];
        headerView.button.hidden  = YES;
    }
//    else if(WLWeatherSectionTypeRadar == type  ){
//        headerView.titleLabel.text = NSLocalizedString(@"imagery", nil);
//    }
    else if (WLWeatherSectionTypeAqi == type) {
        headerView.titleLabel.text = NSLocalizedString(@"air quality", nil);
        headerView.button.hidden  = YES;
    }

    else if(WLWeatherSectionTypeIndices == type){
        headerView.titleLabel.text = NSLocalizedString(@"indices", nil);
        headerView.button.hidden = NO;
        [headerView.button addTarget:self action:@selector(shezhibuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
        
    return headerView;
        
        
    
    

}

- (void)shezhibuttonClick:(UIButton *)button {
    
    
       NSString *day = self.dayArray[0];
       NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Day=%@",day];
       NSArray *dataArray =[self.indexArray filteredArrayUsingPredicate:predicate];
       
    WLIndexSelectViewController *selectVc = [[WLIndexSelectViewController alloc] init];
    selectVc.dataArray = dataArray;
    [self.navigationController pushViewController:selectVc animated:YES];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger type =[ [self.sectionArray objectAtIndex:indexPath.section] integerValue];
    if (type == WLWeatherSectionTypeIndices ) {
        NSString *day = self.dayArray[0];
           NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Day=%@",day];
           NSArray *dataArray =[self.indexArray filteredArrayUsingPredicate:predicate];
           
        WLIndexSelectViewController *selectVc = [[WLIndexSelectViewController alloc] init];
        selectVc.dataArray = dataArray;
        [self.navigationController pushViewController:selectVc animated:YES];
    }
}

- (void)AcuuWeatherFooterViewClickButtonLink {
    

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.accuweather.com"]];

}


- (void)checkeFialed {
    
    if (self.fialedTimes > 3 && (!self.cuurrentModel) && (!self.aqiModel) &&(!self.radarArray) && (!self.hourArray)) {
        [WXPErrorTipView showInView:self.view delegate:self];
    }
}

//- (void)lbBannerCellClickImageAtIndex:(NSInteger)index {
//
//    WLXunquanBannerModel *banner  = self.bannerArray[index];
//
//    if (1 == banner.type) {
//          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:banner.welfareUrl]];
//    } else {
//
//
//        SKStoreProductViewController *controller  = [[SKStoreProductViewController alloc] init];
//        controller.delegate = self;
//
//        [self.navigationController  presentViewController:controller animated:YES  completion:^{
//
//            [controller loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:banner.welfareUrl} completionBlock:^(BOOL result, NSError * _Nullable error) {
//
//            }];
//
//        }];
//
//
//    }
//
//}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    
    [viewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)requestIndex {
    
    
    NSString   *latitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.latitude];
    NSString  *longtitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.longitude];
    
    
    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
    NSInteger total = [WLNetwork cacluteTotalWithLat:latitude lon:longtitude time:timestamp];
    
    NSDictionary *dict = @{@"lat":latitude,
                           @"lng":longtitude,
                           @"time":[NSString stringWithFormat:@"%ld",timestamp],
                           @"total":[NSString stringWithFormat:@"%ld",total],
                           @"locationkey":self.locationKey,
                           @"language":NSLocalizedString(@"language", nil)
                           };
    
    [WLNetworkBaseHandler requestAcuuIndexWithParamaters:dict success:^(NSURLResponse *response, id data) {
      
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSArray *dataArray = [NSArray yy_modelArrayWithClass:[WLAccuIndexModel class] json:data];
            
            if (dataArray && dataArray.count) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [WXPErrorTipView removeErrorviewInView:self.view];
//                });
                
                dataArray = [dataArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                    if (((WLAccuIndexModel *)obj1).EpochDateTime > ((WLAccuIndexModel *)obj2).EpochDateTime) {
                        return NSOrderedDescending;
                    }else {
                        return NSOrderedAscending;
                    }
                }];
                
                self.indexArray = dataArray;
                
                
                
                NSMutableArray *dayArray = [NSMutableArray array];
                NSInteger count = dataArray.count;
                for (int i = 0; i <count; i ++) {
                    WLAccuIndexModel *model = dataArray[i];
                    [model caculateDay];
                    if (0 == i) {
                        [dayArray addObject:model.Day];
                    } else {
                        WLAccuIndexModel *lastmodel = dataArray[i-1];
                        if (![model.Day isEqualToString:lastmodel.Day]) {
                            [dayArray addObject:model.Day];
                        }
                    }
                    
                }
                
                self.dayArray = dayArray.copy;
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
                
                WLAccuIndexModel *model  =[dataArray firstObject];
                self.indexTime = model.EpochDateTime;
                
                self.day = [self.dayfomatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.indexTime]];
                self.lastIndexTime = [[NSDate date] timeIntervalSince1970];
                
                
                
            }
            
            
            
            
        });
        
        
       
    
        
        
    } failed:^(NSError *error) {
        
        self.lastIndexTime =[[NSDate date] timeIntervalSince1970];
        
     
        
    }];
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
