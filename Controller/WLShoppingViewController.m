//
//  WLShoppingViewController.m
//  Weather-live
//
//  Created by xueping on 2019/5/21.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLShoppingViewController.h"
#import "ColorSizeMacro.h"
#import "WLAliSearchController.h"
#import "WLNetworkFirstHandler.h"
#import "WLShoppingSubViewController.h"
#import "WLCateModel.h"
#import "YYModel.h"
#import "WXPErrorTipView.h"


@interface WLShoppingViewController ()<UISearchBarDelegate,WXPErrorTipViewDelegate>

@property(nonatomic,strong)UISearchBar *searchBar;


@property(nonatomic,copy)NSArray *dataArray;

@end



@implementation WLShoppingViewController



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
    
    UISearchBar *serachbar  =[[UISearchBar alloc] init];
    serachbar.placeholder = @"复制宝贝标题/搜索关键字";
    UITextField *textfield = [serachbar valueForKey:@"_searchField"];
    [textfield setValue:UIColorFromRGB(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    [textfield setValue:[UIFont systemFontOfSize:14.f] forKeyPath:@"_placeholderLabel.font"];
 
    
    serachbar.delegate = self;
    _searchBar = serachbar;
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth  -60 , 44 )];
    
    self.searchBar.frame = view.bounds;
    [view addSubview:self.searchBar];
    self.searchBar.barTintColor =[UIColor whiteColor];
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    self.navigationItem.titleView = view;
    
    
    [self loadCate];
    
    // Do any additional setup after loading the view.
}

- (void)loadCate {
    
    [WLNetworkFirstHandler xunquancateWithparamater:nil success:^(NSURLResponse *response, id data) {
        
        NSArray *array = [NSArray yy_modelArrayWithClass:[WLCateModel class] json:data];
        if (array && array.count) {
            
            self.dataArray = array;
            [WXPErrorTipView removeErrorviewInView:self.view];
             [self reloadData];
        }
       
        
    } failed:^(NSError *error) {
        
        [WXPErrorTipView showInView:self.view delegate:self];
        
    }];
    
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    WLAliSearchController *resultControler = [[WLAliSearchController alloc] init];
    [self.navigationController pushViewController:resultControler animated:YES];
    return NO;
    
}


- (void)errorviewTapinView:(WXPErrorTipView *)errorView {
    
    [self loadCate];
    
}



- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.dataArray.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    WLCateModel *cate = self.dataArray[index];
    return cate.name;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    WLShoppingSubViewController *subController = [[WLShoppingSubViewController alloc] init];
    
    subController.index = index;
    
    
    return subController;
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
WLCateModel *cate= self.dataArray[index];
    
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
    
    WLShoppingSubViewController *subcontroller = (WLShoppingSubViewController*)viewController;
    
    WLCateModel *cate = self.dataArray[subcontroller.index];
    
    [subcontroller configCateModel:cate];
    
    
    
    
    
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
