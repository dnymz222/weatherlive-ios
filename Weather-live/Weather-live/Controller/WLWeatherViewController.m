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
#import "STSolunarTidesHandler.h"
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


typedef NS_ENUM(NSInteger ,WLWeatherSectionType) {
    WLWeatherSectionTypeCurrent=0,
    WLWeatherSectionTypeHour,
    WLWeatherSectionTypeDay1,
    WLWeatherSectionTypeDay2,
    WLWeatherSectionTypeDay3,
    WLWeatherSectionTypeDay4,
    WLWeatherSectionTypeDay5,
};




@interface WLWeatherViewController ()<CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,STAcuuWeatherFooterViewDelegate>

@property(nonatomic,strong)STLocationModel *location;

@property(nonatomic,strong)CLLocationManager*loctionmanager;

@property(nonatomic,copy)NSString *locationKey;

@property(nonatomic,strong)NSMutableArray *dataArray;


@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)WLAccuCurrentModel *cuurrentModel;

@property(nonatomic,copy)NSArray *hourArray;

@property(nonatomic,assign)NSInteger sectionCount;

@property(nonatomic,strong)NSMutableArray *sectionArray;



@end

@implementation WLWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.dataArray = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    
    self.sectionArray = [NSMutableArray array];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    
    
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:refreshkey]) {
        
        double latitude  = [[NSUserDefaults standardUserDefaults] doubleForKey:latitudekey];
        double longtitude = [[NSUserDefaults standardUserDefaults] doubleForKey:longtitudekey];
        
        CLLocation  *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longtitude];
        STLocationModel *model = [[STLocationModel alloc] initWithClLocation:location];
        [STSolunarTidesHandler sharehanlder].locationModel = model;
        [[STSolunarTidesHandler sharehanlder].locationModel reverseGeocodeCompleted:^(NSString * _Nonnull name) {
            
            self.navigationItem.title = name;
        }];
        
        [self requestLocationKey];
        
        
        
        
        
        
        
    } else {
        
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
    
    [self requestConfig];
    
    
    
    
    
    
    // Do any additional setup after loading the view.
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
    
    
    [self requestConfig];
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
    // [[NSUserDefaults standardUserDefaults] setDouble:loc.altitude forKey:altitudekey];
    
    
    STLocationModel *model = [[STLocationModel alloc] initWithClLocation:loc];
    
    [STSolunarTidesHandler sharehanlder].locationModel  = model;
    
    [[STSolunarTidesHandler sharehanlder].locationModel reverseGeocodeCompleted:^(NSString * _Nonnull name) {
        self.navigationItem.title = name;
    }];
    
    [self requestLocationKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:locationchangednoteKey object:nil];
    
    
    
    
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:refreshkey]) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:refreshkey];
    }
    
    
    
    
    [manager stopUpdatingLocation];
}




- (void)requestLocationKey {
    
    NSString   *latitude = [NSString stringWithFormat:@"%0.4f",[STSolunarTidesHandler sharehanlder].locationModel.location.coordinate.latitude];
    NSString  *longtitude = [NSString stringWithFormat:@"%0.4f",[STSolunarTidesHandler sharehanlder].locationModel.location.coordinate.longitude];
    
    
    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
    NSInteger total = [FishNetwork cacluteTotalWithLat:latitude lon:longtitude time:timestamp];
    
    NSDictionary *dict = @{@"lat":latitude,
                           @"lng":longtitude,
                           @"time":[NSString stringWithFormat:@"%ld",timestamp],
                           @"total":[NSString stringWithFormat:@"%ld",total]
                           };
    
    [FishNetworkFirstHandler acuuloctationKeyWithparamater:dict success:^(NSURLResponse *response, id data) {
        
        
        self.locationKey =[(NSDictionary *)data valueForKey:@"Key"];
        
        if (self.locationKey ) {
            
            [self requestCurrent];
            [self requestHourly];
            
            [self requestWeather];
        }
        
        
    } failed:^(NSError *error) {
        
        
    }];
    
    
    
    
    
}

- (void)requestCurrent {
    
    NSString   *latitude = [NSString stringWithFormat:@"%0.4f",[STSolunarTidesHandler sharehanlder].locationModel.location.coordinate.latitude];
    NSString  *longtitude = [NSString stringWithFormat:@"%0.4f",[STSolunarTidesHandler sharehanlder].locationModel.location.coordinate.longitude];
    
    
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
        
        
        NSArray *dataArray = (NSArray *)data;
        
        WLAccuCurrentModel *model = [WLAccuCurrentModel yy_modelWithJSON:dataArray[0]];
        if (model.WeatherIcon ) {
            
            self.cuurrentModel = model;
            [self.tableView reloadData];
        }
        
    } failed:^(NSError *error) {
        
    }];
}

- (void)requestHourly {
    
    NSString   *latitude = [NSString stringWithFormat:@"%0.4f",[STSolunarTidesHandler sharehanlder].locationModel.location.coordinate.latitude];
    NSString  *longtitude = [NSString stringWithFormat:@"%0.4f",[STSolunarTidesHandler sharehanlder].locationModel.location.coordinate.longitude];
    
    
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
        
        self.hourArray = [NSArray yy_modelArrayWithClass:[WLAccuHourlyModel class] json:data];
        if (self.hourArray) {
            [self.tableView reloadData];
        }
        
    } failed:^(NSError *error) {
        
    }];;
}

- (void)requestWeather {
    
    NSString   *latitude = [NSString stringWithFormat:@"%0.4f",[STSolunarTidesHandler sharehanlder].locationModel.location.coordinate.latitude];
    NSString  *longtitude = [NSString stringWithFormat:@"%0.4f",[STSolunarTidesHandler sharehanlder].locationModel.location.coordinate.longitude];
    
    
    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
    NSInteger total = [FishNetwork cacluteTotalWithLat:latitude lon:longtitude time:timestamp];
    
    NSDictionary *dict = @{@"lat":latitude,
                           @"lng":longtitude,
                           @"time":[NSString stringWithFormat:@"%ld",timestamp],
                           @"total":[NSString stringWithFormat:@"%ld",total],
                           @"locationkey":self.locationKey,
                           @"language":@"zh-cn"
                           };
    
    [FishNetworkFirstHandler acuuWeatherWithparamater:dict success:^(NSURLResponse *response, id data) {
        
        NSDictionary *dataDict  =(NSDictionary *)data;
        NSArray *array = [NSArray yy_modelArrayWithClass:[STAcuuWeatherDailyModel class] json:dataDict[@"DailyForecasts"]];
        if (array.count) {
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:array];
            [self.tableView reloadData];
        }
        
        
    } failed:^(NSError *error) {
        
    }];
    
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    [self.sectionArray removeAllObjects];
    if (self.cuurrentModel) {
        [self.sectionArray addObject:@(WLWeatherSectionTypeCurrent)];
    }
    if (self.hourArray) {
        [self.sectionArray   addObject:@(WLWeatherSectionTypeHour)];
    }
    
    if (self.dataArray && 5 == self.dataArray.count) {
        [self.sectionArray addObject:@(WLWeatherSectionTypeDay1)];
        [self.sectionArray addObject:@(WLWeatherSectionTypeDay2)];
        [self.sectionArray addObject:@(WLWeatherSectionTypeDay3)];
        [self.sectionArray addObject:@(WLWeatherSectionTypeDay4)];
        [self.sectionArray addObject:@(WLWeatherSectionTypeDay5)];
    }
    
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger type = [self.sectionArray[section] integerValue];
    if (type < 2) {
        return 1;
    } else {
        return 2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WLWeatherSectionType type =(WLWeatherSectionType)[self.sectionArray[indexPath.section] integerValue];
    if (WLWeatherSectionTypeCurrent == type) {
        return 150;
    } else if (WLWeatherSectionTypeHour == type) {
        return 100;
    } else {
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
       
    } else {
        STAcuuWeatherDailyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil ) {
            
            cell = [[STAcuuWeatherDailyCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        
        STAcuuWeatherDailyModel *model = self.dataArray[type-2];
        BOOL isDay = 0 == indexPath.row;
        [cell configModel:model day:isDay];
        
        return cell;
    }
    
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    WLWeatherSectionType type =(WLWeatherSectionType)[self.sectionArray[section] integerValue];
    if (WLWeatherSectionTypeCurrent == type) {
        return 44;
    } else if (WLWeatherSectionTypeHour == type) {
        return 44;
    } else {
        return 60;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (!self.dataArray.count) {
        return 0.001f;
    }
    if (section <self.sectionArray.count-1) {
        return 0.001f;
    }
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    WLWeatherSectionType type =(WLWeatherSectionType)[self.sectionArray[section] integerValue];
    if (WLWeatherSectionTypeCurrent == type || WLWeatherSectionTypeHour == type ) {
        WLAccuNormalHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
        if (headerView == nil) {
            headerView = [[WLAccuNormalHeaderView alloc] initWithReuseIdentifier:@"header"];
        }
        
        if (WLWeatherSectionTypeCurrent == type) {
            headerView.titleLabel.text = [NSString stringWithFormat:@"实况天气(%@发布)",self.cuurrentModel.LocalObservationDateTime];
        } else {
            headerView.titleLabel.text =@"12小时预报";
        }
        
        return headerView;
        
        
    } else {
        STAcuuWeatherHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"day"];
        if (headerView == nil) {
            headerView = [[STAcuuWeatherHeaderView alloc] initWithReuseIdentifier:@"day"];
        }
        
        STAcuuWeatherDailyModel *dailyModel = self.dataArray[type-2];
        
        [headerView configWithModel:dailyModel];
        
        return headerView;
    }
    

}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (!self.dataArray.count) {
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





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
