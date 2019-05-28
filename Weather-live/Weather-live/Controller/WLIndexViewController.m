//
//  WLIndexViewController.m
//  Weather-live
//
//  Created by xueping on 2019/5/21.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLIndexViewController.h"
#import "WLAccuIndexGroupModel.h"
#import "WLAccuIndexModel.h"
#import "WLWeatherLocationHandler.h"
#import "FishNetworkFirstHandler.h"
#import "STLocationModel.h"
#import "YYModel.h"
#import "WLAccuIndexModel.h"
#import "WLAccuIndexDetailCell.h"
#import "Masonry.h"
#import "ColorSizeMacro.h"
#import "WLIndexSubViewController.h"
#import "WXPErrorTipView.h"
#import "FishToast.h"

@interface WLIndexViewController ()<WXPErrorTipViewDelegate>

@property(nonatomic,copy)NSArray *dataArray;

@property(nonatomic,strong)NSDateFormatter *dayformatter;

@property(nonatomic,copy)NSArray *dayArray;

@property(nonatomic,copy)NSString *locationKey;

@property(nonatomic,assign)NSInteger indexTime;

@property(nonatomic,assign)NSInteger lastIndexTime;




@end

@implementation WLIndexViewController


- (instancetype)init {
    self = [super init];
    if (self) {
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuView.lineColor = UIColorFromRGB(Themecolor);
        self.menuView.scrollView.backgroundColor = UIColorFromRGB(0xeeeeee);
        
        self.titleSizeNormal = 13.f;
        self.titleSizeSelected = 14.f;
        self.titleColorNormal = UIColorFromRGB(0x666666);
        self.titleColorSelected= UIColorFromRGB(Themecolor);
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh:) name:requestWeatherDoneKey object:nil];
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    

    self.navigationItem.title = @"生活指数";
    
    
    
    if ([WLWeatherLocationHandler sharehanlder].accuLoctionModel) {
        self.locationKey = [WLWeatherLocationHandler sharehanlder].accuLoctionModel.Key;
        self.navigationItem.title  = [WLWeatherLocationHandler sharehanlder].accuLoctionModel.LocalizedName;
        [self requestIndex];
        
        
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLocationKeyChange:) name:loctionkeygetkey object:nil];
    
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)receiveLocationKeyChange:(NSNotification *)note{
    
    self.locationKey = [WLWeatherLocationHandler sharehanlder].accuLoctionModel.Key;
    self.navigationItem.title  = [WLWeatherLocationHandler sharehanlder].accuLoctionModel.LocalizedName;
    [self requestIndex];
}

- (void)requestIndex {
    
    
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
    
    [FishNetworkBaseHandler requestAcuuIndexWithParamaters:dict success:^(NSURLResponse *response, id data) {
      
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSArray *dataArray = [NSArray yy_modelArrayWithClass:[WLAccuIndexModel class] json:data];
            
            if (dataArray && dataArray.count) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [WXPErrorTipView removeErrorviewInView:self.view];
                });
                
                dataArray = [dataArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                    if (((WLAccuIndexModel *)obj1).EpochDateTime > ((WLAccuIndexModel *)obj2).EpochDateTime) {
                        return NSOrderedDescending;
                    }else {
                        return NSOrderedAscending;
                    }
                }];
                
                self.dataArray = dataArray;
                
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
                
                WLAccuIndexModel *model  =[self.dataArray firstObject];
                self.indexTime = model.EpochDateTime;
                
                self.lastIndexTime = [[NSDate date] timeIntervalSince1970];
                
            }
            
            
            
            
        });
        
        
       
    
        
        
    } failed:^(NSError *error) {
        
        self.lastIndexTime =[[NSDate date] timeIntervalSince1970];
        
        if (!self.indexTime) {
            dispatch_async(dispatch_get_main_queue(), ^{
                 [WXPErrorTipView showInView:self.view delegate:self];
            });
           
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                 [FishToast view:self.view toastError:error];
            });
           
        }
        
    }];
}


- (void)errorviewTapinView:(WXPErrorTipView *)errorView {
    
    [self requestIndex];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.dayArray.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    NSString *day = self.dayArray[index];
    return day;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    WLIndexSubViewController *subController = [[WLIndexSubViewController alloc] init];
    
    subController.index = index;
    
    
    return subController;
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    NSString *name = self.dayArray[index];
    
    CGFloat width = name.length *14;
    return width +25;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
 
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = 0;
    return CGRectMake(leftMargin, originY, self.view.frame.size.width - 2*leftMargin, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {

    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);

    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    
    WLIndexSubViewController *subcontroller = (WLIndexSubViewController *)viewController;
    
    NSInteger index = subcontroller.index;
    NSString *day = self.dayArray[index];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Day=%@",day];
    NSArray *dataArray =[self.dataArray filteredArrayUsingPredicate:predicate];
    [subcontroller configDataArray:dataArray];
    
    
    
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
