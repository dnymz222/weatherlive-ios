//
//  TodayViewController.m
//  widget
//
//  Created by xueping on 2019/10/25.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "WLNetworkBaseHandler.h"
#import "Masonry.h"
#import "WLWigdetIndexItemView.h"
#import "ColorSizeMacro.h"
#import "YYModel.h"
#import "WLAccuIndexModel.h"
#import "LBKeyMacro.h"
#import "WLColor.h"

@interface TodayViewController () <NCWidgetProviding>

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)WLWigdetIndexItemView  *itemview1;
@property(nonatomic,strong)WLWigdetIndexItemView *itemView2;

@property(nonatomic,strong)UILabel *tipLabel;

@property(nonatomic,strong)NSUserDefaults *userDefaults;
@property(nonatomic,copy)NSString *locationKey;
@property(nonatomic,copy)NSString *locationName;

@property(nonatomic,copy)NSArray *indexArray;
@property(nonatomic,copy)NSArray *dayArray;

@property(nonatomic,assign)NSInteger indexTime;
@property(nonatomic,strong)NSDateFormatter *dayfomatter;
@property(nonatomic,copy)NSString *day;

@property(nonatomic,assign)NSInteger lastIndexTime;

@property(nonatomic,copy)NSString *someDay;

@property(nonatomic,assign)NSInteger selectFirst;
@property(nonatomic,assign)NSInteger selectTwo;

@property(nonatomic,strong)UIImageView *addressIconView;

@property(nonatomic,copy)NSString *jsonArray;






@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UILabel *displayLbl = [[UILabel alloc] initWithFrame:CGRectMake(30, 50, 200, 30)];
//      displayLbl.text = @"我就是Widget啦";
//      displayLbl.textColor = [UIColor whiteColor];
//      [self.view addSubview:displayLbl];
    
    // Do any additional setup after loading the view.
    
    self.dayfomatter = [[NSDateFormatter  alloc] init];
       [self.dayfomatter   setDateFormat:@"MM-dd"];
    
    self.userDefaults = [[NSUserDefaults alloc] initWithSuiteName:Appgroupkey];
    
    self.locationKey = [self.userDefaults valueForKey:AppgroupLoctionkeyKey];
    self.locationName = [self.userDefaults valueForKey:AppgroupLoctionNameKey];
    
    
    
  
    [self.view addSubview:self.addressIconView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.itemview1];
    [self.view addSubview:self.itemView2];
    [self.view addSubview:self.tipLabel];
    [self.addressIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view).offset(10);
        make.width.equalTo(@16);
        make.height.equalTo(@16);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(28);
        make.top.right.equalTo(self.view);
        make.height.equalTo(@16);
    }];
    [self.itemview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.right.equalTo(self.view.mas_centerX);
        make.height.equalTo(@94);
    }];
    [self.itemView2 mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.equalTo(self.view);
          make.top.equalTo(self.titleLabel.mas_bottom);
          make.left.equalTo(self.view.mas_centerX);
          make.height.equalTo(@94);
      }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@280);
        make.height.equalTo(@60);
    }];
    
    
    
    
    
    self.day = [self.userDefaults valueForKey:AppgroupOldDayKey]?:@"";
    self.indexTime = [self.userDefaults integerForKey:AppgroupIndexTimeKey]?:0;
    self.lastIndexTime = [self.userDefaults integerForKey:AppgroupLastIndexTimekey]?:0;
    
    if (self.locationKey) {
        
        
        NSString *oldkey = [self.userDefaults   valueForKey:AppgroupOldKey]?:@"";
        BOOL newkey = ![self.locationKey isEqualToString:oldkey];
        [self requestFromNewkey:newkey];
        
        self.titleLabel.text = self.locationName;
        self.tipLabel.hidden = YES;
        
        
        
    } else {
        
       
//        [self requestFromNewkey:NO];
        self.tipLabel.hidden = NO;
        self.itemview1.hidden = YES;
        self.itemView2.hidden = YES;
        self.tipLabel.text = NSLocalizedString(@"address tip", nil);
        
        
        
    }
    
    UITapGestureRecognizer *tap  =[[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    [tap addTarget:self action:@selector(tapIn)];
}


- (void)requestFromNewkey:(BOOL)newkey {
    
    if (newkey) {
        
        
        [self requestIndex];
        
        
    } else {
        
        NSDate *date = [NSDate date];
        NSInteger now = [date timeIntervalSince1970];
        NSString *nowday = [self.dayfomatter stringFromDate:date];
        BOOL sameday  =[nowday isEqualToString:self.day];
        if (sameday && self.indexTime) {
            if (now-_lastIndexTime > 6*3600) {
                   [self requestIndex];
            } else{
                
               NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:Appgroupkey];
               containerURL = [containerURL URLByAppendingPathComponent:@"Library/Caches/widget"];
                
                NSError *error;
                self.jsonArray = [NSString stringWithContentsOfURL:containerURL encoding:NSUTF8StringEncoding error:&error];
                if (self.jsonArray) {
                    
                    
                    
                    [self hanldeWithData:self.jsonArray fromrequest:NO];
                }
                
                
                
               
            }
            
        } else {
            if (now- _lastIndexTime > 600) {
                
            
                   [self requestIndex];
                
            } else {
                
                    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:Appgroupkey];
                             containerURL = [containerURL URLByAppendingPathComponent:@"Library/Caches/widget"];
                              
                             NSError *error;
                             self.jsonArray = [NSString stringWithContentsOfURL:containerURL encoding:NSUTF8StringEncoding error:&error];
                
                              if (self.jsonArray) {
                                  
                                  
                                  
                                  [self hanldeWithData:self.jsonArray fromrequest:NO];
                              }
            }
        }
        
    }
}


- (void)tapIn {
    
    NSURL *url = [NSURL URLWithString:@"weatherlive://"];
    
    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
        
        NSLog(@"isSuccessed %d",success);
    }];
    
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:13.f];
        _titleLabel.textColor = [WLColor headercolor];
        //_titleLabel.text  = @"杭州市";
    }
    
    return _titleLabel;
}

- (UIImageView *)addressIconView {
    if (!_addressIconView) {
        _addressIconView = [[ UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"dizhi"];
        [_addressIconView setImage:image];
        _addressIconView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    
    return _addressIconView;
}

- (WLWigdetIndexItemView *)itemview1 {
    if (!_itemview1) {
        _itemview1 = [[WLWigdetIndexItemView alloc] init];
        _itemview1.backgroundColor = [UIColor clearColor];
//        _itemview1.hidden = YES;
    }
    
    return _itemview1;
}

- (WLWigdetIndexItemView *)itemView2 {
    if (!_itemView2) {
        _itemView2 = [[WLWigdetIndexItemView alloc] init];
        _itemView2.backgroundColor = [UIColor clearColor];
//        _itemView2.hidden = YES;
    }
    
    return _itemView2;
}


- (void)requestIndex {
    
    
    NSString   *latitude = [NSString stringWithFormat:@"%0.4f",30.03f];
    NSString  *longtitude = [NSString stringWithFormat:@"%0.4f",120.28f];
    
    
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
      
        
        self.jsonArray = [self arraytojson:data];
        
        [self hanldeWithData:data fromrequest:YES];
       
        
       
    
        
        
    } failed:^(NSError *error) {
        
        self.lastIndexTime =[[NSDate date] timeIntervalSince1970];
        
     
        
    }];
}


- (void)hanldeWithData:(id)data fromrequest:(BOOL)request{
    
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
                        [self reloadData];
                    });
                    
                    WLAccuIndexModel *model  =[dataArray firstObject];
                    self.indexTime = model.EpochDateTime;
                    
                    self.day = [self.dayfomatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.indexTime]];
                    self.lastIndexTime = [[NSDate date] timeIntervalSince1970];
                    
                    if (request) {
                        [self saveDataByNSFileManager];
                    }
                    
                    
                    
                }
                
                
                
                
            });
            
}


- (void)reloadData{
    
    self.day = [self.dayfomatter  stringFromDate:[NSDate date]];
    
    NSString *day = self.day;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Day=%@",day];
    NSArray *dataArray =[self.indexArray filteredArrayUsingPredicate:predicate];
    
    
    self.selectFirst = [self.userDefaults  integerForKey:AppgroupIndiciesSelect1Key]?:-100;
    self.selectTwo = [self.userDefaults integerForKey:AppgroupIndiciesSelect2Key]?:-100;
    
    if (-100 == self.selectFirst  && -100 == self.selectTwo) {
        
        self.itemview1.hidden = YES;
        self.itemView2.hidden = YES;
        
        self.tipLabel.hidden = NO;
        self.tipLabel.text = NSLocalizedString(@"select note", nil);
        
        
        
    } else if (-100 != self.selectFirst && -100 != self.selectTwo ){
        self.tipLabel.hidden  = YES;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ID=%ld",self.selectFirst];
        NSArray *fileterArray =[dataArray filteredArrayUsingPredicate:predicate];
        if (fileterArray.count) {
                   WLAccuIndexModel *model = [fileterArray firstObject];
                   self.itemview1.hidden = NO;
                   [self.itemview1 configIndexModel:model];
                   
        }
        
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"ID=%ld",self.selectTwo];
        NSArray *fileterArray2 =[dataArray filteredArrayUsingPredicate:predicate2];
        if (fileterArray2.count) {
                   WLAccuIndexModel *model = [fileterArray2 firstObject];
                   
                   [self.itemView2 configIndexModel:model];
                   self.itemView2.hidden = NO;
               }
        
        
        
    } else {
        
        self.tipLabel.hidden = YES;
        
        NSInteger selectId = 0;
        if (-100 == self.selectFirst) {
            
            selectId = self.selectTwo;
        } else {
            
            selectId = self.selectFirst;
        }
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ID=%ld",selectId];
        NSArray *fileterArray =[dataArray filteredArrayUsingPredicate:predicate];
        if (fileterArray.count) {
            WLAccuIndexModel *model = [fileterArray firstObject];
            self.itemview1.hidden = NO;
            [self.itemview1 configIndexModel:model];
            self.itemView2.hidden = YES;
        }
        
        
        
    }
    
    
    
    
    
}


- (UILabel *)tipLabel   {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = [UIFont systemFontOfSize:15.f];
        _tipLabel.textColor = UIColorFromRGB(Themecolor);
        _tipLabel.hidden = YES;
    }
    
    return _tipLabel;
}



- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    
    

    completionHandler(NCUpdateResultNewData);
}







- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize API_AVAILABLE(ios(10.0)){
    
    if (@available(iOS 10.0, *)) {
        if(activeDisplayMode == NCWidgetDisplayModeCompact) {
            // 尺寸只设置高度即可，因为宽度是固定的，设置了也不会有效果
            self.preferredContentSize = CGSizeMake(0, 110);
        } else {
            self.preferredContentSize = CGSizeMake(0, 110);
        }
    } else {
        
    }
}

-(BOOL)saveDataByNSFileManager
{
    
    NSError *error;
  
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:Appgroupkey];
    containerURL = [containerURL URLByAppendingPathComponent:@"Library/Caches/widget"];
    if (@available(iOS 11.0, *)) {
        
        BOOL result =[self.jsonArray writeToURL:containerURL atomically:YES encoding:NSUTF8StringEncoding error:&error];
        
        
        if (result)
        {
//            NSLog(@"result is success\n\n\n\n");
            [self.userDefaults setObject:self.day forKey:AppgroupOldDayKey];
            [self.userDefaults setObject:self.locationKey forKey:AppgroupOldKey];
            [self.userDefaults setInteger:self.lastIndexTime forKey:AppgroupLastIndexTimekey];
            [self.userDefaults setInteger:self.indexTime forKey:AppgroupIndexTimeKey];
            
            
        } else {
            
//            NSLog(@"%@,result is failed:%@\n\n\n\n",self.jsonArray,error);
        }
        
        return result;
    } else {
        
        BOOL result =[self.jsonArray writeToURL:containerURL atomically:YES encoding:NSUTF8StringEncoding error:&error];
        
        
        if (result)
        {
//            NSLog(@"result is success\n\n\n\n");
            [self.userDefaults setObject:self.day forKey:AppgroupOldDayKey];
            [self.userDefaults setObject:self.locationKey forKey:AppgroupOldKey];
            [self.userDefaults setInteger:self.lastIndexTime forKey:AppgroupLastIndexTimekey];
            [self.userDefaults setInteger:self.indexTime forKey:AppgroupIndexTimeKey];
            
            
        } else {
            
//            NSLog(@"result is failed\n\n\n\n");
        }
        return result;
        // Fallback on earlier versions
    }
}

- (NSString *)arraytojson:(id)data {
    
     NSError *error = nil;

     NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                           options:kNilOptions
                                                             error:&error];

     NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
    
    return jsonString;
 
}



- (void)dealloc {
    
    
//    [self saveDataByNSFileManager];
    
    
}



@end
