//
//  WLDayWeatherViewController.m
//  Weather-live
//
//  Created by xueping on 2019/5/24.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLDayWeatherViewController.h"
#import "Masonry.h"
#import "ColorSizeMacro.h"
#import "LBKeyMacro.h"
#import "STLocationModel.h"
#import "WLNetworkFirstHandler.h"
#import "WLWeatherLocationHandler.h"
#import <CoreLocation/CoreLocation.h>
#import "STAcuuWeatherDailyModel.h"
#import "STAcuuWeatherDailyCell.h"
#import "YYModel.h"
#import "STAcuuWeatherHeaderView.h"
#import "STAcuuWeatherFooterView.h"
#import "FishToast.h"
#import "WXPErrorTipView.h"



@interface WLDayWeatherViewController ()<UITableViewDelegate,UITableViewDataSource,STAcuuWeatherFooterViewDelegate,WXPErrorTipViewDelegate>

@property(nonatomic,strong)NSMutableArray *dataArray;


@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSString *locationKey;
@property(nonatomic,assign)NSInteger dayTime;
@property(nonatomic,copy)NSString *day;

@property(nonatomic,strong)NSDateFormatter *dayFomatter;
@property(nonatomic,assign)NSInteger lastDayTime;

@end

@implementation WLDayWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.dataArray = [NSMutableArray array];
    self.dayTime = 0;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    if ([WLWeatherLocationHandler sharehanlder].accuLoctionModel) {
        self.locationKey = [WLWeatherLocationHandler sharehanlder].accuLoctionModel.Key;
        self.navigationItem.title = [WLWeatherLocationHandler sharehanlder].accuLoctionModel.LocalizedName;
        [self requestWeather];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivelocationkeyChanged:) name:loctionkeygetkey object:nil];
    
    self.dayFomatter = [[NSDateFormatter alloc] init];
    [self.dayFomatter setDateFormat:@"yyyy-MM-dd"];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (!self.dayTime) {
        
    } else {
        
        
        NSDate *date = [NSDate date];
        NSInteger now  = [date timeIntervalSince1970];
        
        NSString *nowday = [self.dayFomatter stringFromDate:date];
        
        BOOL sameday = [nowday isEqualToString:self.day];
        if (sameday) {
            if (now - self.lastDayTime > 6*3600) {
                [self requestWeather];
            }
            
        } else {
            if (now - self.lastDayTime > 3600) {
                [self requestWeather];
            }
        }
        
       
        
        
    }
    
}







- (void)receivelocationkeyChanged:(NSNotification *)note {
    
    self.locationKey = [WLWeatherLocationHandler sharehanlder].accuLoctionModel.Key;
    self.navigationItem.title = [WLWeatherLocationHandler sharehanlder].accuLoctionModel.LocalizedName;
    [self requestWeather];
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

- (void)requestWeather {
    
    NSString   *latitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.latitude];
    NSString  *longtitude = [NSString stringWithFormat:@"%0.4f",[WLWeatherLocationHandler sharehanlder].locationModel.location.coordinate.longitude];
    
    
    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
    NSInteger total = [WLNetwork cacluteTotalWithLat:latitude lon:longtitude time:timestamp];
    
    NSDictionary *dict = @{@"lat":latitude,
                           @"lng":longtitude,
                           @"time":[NSString stringWithFormat:@"%ld",timestamp],
                           @"total":[NSString stringWithFormat:@"%ld",total],
                           @"locationkey":self.locationKey,
                           @"language":@"zh-cn"
                           };
    
    [WLNetworkFirstHandler acuuWeatherWithparamater:dict success:^(NSURLResponse *response, id data) {
        
        NSDictionary *dataDict  =(NSDictionary *)data;
        NSArray *array = [NSArray yy_modelArrayWithClass:[STAcuuWeatherDailyModel class] json:dataDict[@"DailyForecasts"]];
        if (array.count) {
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:array];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            STAcuuWeatherDailyModel *firstmodel = array[0];
            self.dayTime =firstmodel.EpochDate;
            self.day = [self.dayFomatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.dayTime]];
            
            self.lastDayTime = [[NSDate date] timeIntervalSince1970];
        
            [WXPErrorTipView removeErrorviewInView:self.view];
            
        }
        
        
    } failed:^(NSError *error) {
        
        self.lastDayTime = [[NSDate date] timeIntervalSince1970];
        if (!self.dayTime) {
             [WXPErrorTipView showInView:self.view delegate:self];
        } else {
            [FishToast view:self.view toastError:error];
        }
       
    }];
    
    
    
    
}

- (void)errorviewTapinView:(WXPErrorTipView *)errorView {
    
    [self requestWeather];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  
        STAcuuWeatherDailyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil ) {
            
            cell = [[STAcuuWeatherDailyCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        
        STAcuuWeatherDailyModel *model = self.dataArray[indexPath.section];
        BOOL isDay = 0 == indexPath.row;
        [cell configModel:model day:isDay];
        
        return cell;
   
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
   
    if (section <self.dataArray.count-1) {
        return 0.001f;
    }
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
 
        STAcuuWeatherHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"day"];
        if (headerView == nil) {
            headerView = [[STAcuuWeatherHeaderView alloc] initWithReuseIdentifier:@"day"];
        }
        
        STAcuuWeatherDailyModel *dailyModel = self.dataArray[section];
        
        [headerView configWithModel:dailyModel];
        
        return headerView;
  
    
    
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
   
    if (section < self.dataArray.count -1) {
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
