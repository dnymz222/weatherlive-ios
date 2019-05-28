//
//  WLItemShoppingViewController.m
//  Weather-live
//
//  Created by xueping on 2019/5/28.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLItemShoppingViewController.h"
#import "ColorSizeMacro.h"
#import "Masonry.h"
#import "FishNetworkFirstHandler.h"
#import "FishCateModel.h"
#import "YYModel.h"
#import "FishMuyinSubController.h"

@interface WLItemShoppingViewController ()

@property(nonatomic,copy)NSArray *dataArray;
@end

@implementation WLItemShoppingViewController


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
    
    self.navigationItem.title = self.name;
    
    [self loadCate];
    
    // Do any additional setup after loading the view.
}


- (void)loadCate {
    
    [FishNetworkFirstHandler xunquancatCouponWithPath:_urlPath paramater:nil success:^(NSURLResponse *response, id data) {

        NSArray *array = [NSArray yy_modelArrayWithClass:[FishCateModel class] json:data];
        if (array && array.count) {
            
            self.dataArray = array;
           
            [self reloadData];
        }
        
        
    } failed:^(NSError *error) {
        
       
        
    }];
    
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.dataArray.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    FishCateModel *cate = self.dataArray[index];
    return cate.name;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    FishMuyinSubController *subController = [[FishMuyinSubController alloc] init];
    
    subController.index = index;
    
    
    return subController;
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    FishCateModel *cate= self.dataArray[index];
    
    CGFloat width = cate.name.length *14;
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
    
    FishMuyinSubController *subcontroller = (FishMuyinSubController*)viewController;

    FishCateModel *cate = self.dataArray[subcontroller.index];

    subcontroller.url = cate.url;
    
    [subcontroller  reloadData];
    
    
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
