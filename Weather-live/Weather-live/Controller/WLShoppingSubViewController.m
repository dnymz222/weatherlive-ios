//
//  WLShoppingSubViewController.m
//  Weather-live
//
//  Created by xueping on 2019/5/21.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLShoppingSubViewController.h"
#import "FishCateModel.h"
#import "Masonry.h"
#import "FishNetworkFirstHandler.h"
#import "WLTaobaoCouponCell.h"
#import "FishCouponItemModel.h"
#import "FishAliHandler.h"
#import "YYModel.h"
#import "MJRefresh.h"
#import "WLXunquanBannerModel.h"
#import "WLXunquanColumnModel.h"
#import "UIView+WL.h"
#import "LBBannerCell.h"
#import "WLXunquanColumnCell.h"
#import "WLItemShoppingViewController.h"
#import "WLAliWebController.h"



typedef NS_ENUM(NSInteger,WLShoppingSubCellType) {
    
    WLShoppingSubCellTypeBanner,
    WLShoppingSubCellTypeItem,
    WLShoppingSubCellTypeNormal,
};

@interface WLShoppingSubViewController ()<UITableViewDelegate,UITableViewDataSource,LBBannerCellDelegate,WLXunquanColumnCellDelegate>


@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,assign)CGFloat cellHeight;

@property(nonatomic,assign)NSInteger page;

@property(nonatomic,assign)BOOL hasData;

@property(nonatomic,strong)FishCateModel *cate;

@property(nonatomic,copy)NSArray *bannerArray;
@property(nonatomic,copy)NSArray *itemArray;

@property(nonatomic,strong)NSMutableArray *sectionArray;




@end

@implementation WLShoppingSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    
    self.sectionArray = [NSMutableArray array];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    self.cellHeight = width*0.4f;
    
    
    self.sectionArray = [NSMutableArray array];
    
    [self.tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pull)];
    _tableView.mj_header.hidden = YES;
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pushMore)];
    _tableView.mj_footer.hidden = YES;
    
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)configCateModel:(FishCateModel *)cate {
    
    _cate  =cate;
    if (!_hasData) {
        _page = 1;
        NSDictionary *dict = @{@"page":@(_page)};
        NSString *path = [NSString stringWithFormat:@"/xunquan/cat/%@",cate.cateId];
        [FishNetworkFirstHandler xunquancatCouponWithPath:path paramater:dict success:^(NSURLResponse *response, id data) {
            NSArray *array = [NSArray yy_modelArrayWithClass:[FishCouponItemModel class] json:data];
            if (array && array.count) {
                self.hasData = YES;
                self.tableView.mj_footer.hidden = NO;
                self.tableView.mj_header.hidden = NO;
                [self.dataArray addObjectsFromArray:array];
                [self.tableView reloadData];
            }
            
        } failed:^(NSError *error) {
            
        }];
        if (0 == _index) {
            
            [FishNetworkFirstHandler   xunquancolumnWithparamater:nil success:^(NSURLResponse *response, id data) {

                NSDictionary *dataDict  = (NSDictionary *)data;
                NSArray *bannerArray = [NSArray yy_modelArrayWithClass:[WLXunquanBannerModel class] json:dataDict[@"bannerList"]];
                NSArray *itemArray  = [NSArray yy_modelArrayWithClass:[WLXunquanColumnModel class] json:dataDict[@"itemList"]];
                if (bannerArray && bannerArray.count) {
                    self.bannerArray = bannerArray;
                }

                if (itemArray && itemArray.count) {
                    self.itemArray = itemArray;
                }

                [self.tableView reloadData];



            } failed:^(NSError *error) {

            }];
            
        }
    }
    
}





- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    [self.sectionArray removeAllObjects];
    if (self.bannerArray) {
        [self.sectionArray addObject:@(WLShoppingSubCellTypeBanner)];
    }
    
    if (self.itemArray) {
        [self.sectionArray addObject:@(WLShoppingSubCellTypeItem)];
    }
    
    if (self.dataArray) {
        [self.sectionArray addObject:@(WLShoppingSubCellTypeNormal)];
    }
   
    
    return self.sectionArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    WLShoppingSubCellType type = (WLShoppingSubCellType) [self.sectionArray[section] integerValue];
    if (type == WLShoppingSubCellTypeBanner) {
        return 1;
    } else if (type == WLShoppingSubCellTypeItem) {
        return 1;
    } else {
        return self.dataArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    WLShoppingSubCellType type = (WLShoppingSubCellType) [self.sectionArray[indexPath.section] integerValue];
    if (type == WLShoppingSubCellTypeBanner) {
        CGFloat width =[UIScreen mainScreen].bounds.size.width;
        return width/440.0*180;
    } else if (type == WLShoppingSubCellTypeItem) {
        return [UIView wl_heightWithCount:self.itemArray.count];
    } else {
        return self.cellHeight;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WLShoppingSubCellType type = (WLShoppingSubCellType) [self.sectionArray[indexPath.section] integerValue];
    if (type == WLShoppingSubCellTypeBanner) {
        LBBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"banner"];
        if (cell == nil) {
            cell = [[LBBannerCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"banner"];
            cell.delegate = self;
        }
        
        [cell configImageArray:[self.bannerArray valueForKey:@"imageUrl"]];
        
        return cell;
    } else if (type == WLShoppingSubCellTypeItem) {
        WLXunquanColumnCell *cell =[tableView dequeueReusableCellWithIdentifier:@"item"];
        if (cell== nil) {
            cell  =[[WLXunquanColumnCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"item"];
            cell.delegate = self;
            
        }
        
        [cell configItemList:self.itemArray];
        
        return cell;
    } else {
        
        WLTaobaoCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[WLTaobaoCouponCell  alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        FishCouponItemModel *coupon = self.dataArray[indexPath.row];
        [cell configWithCoupon:coupon];
        
        return cell;
    }
   
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    WLShoppingSubCellType type = (WLShoppingSubCellType) [self.sectionArray[indexPath.section] integerValue];
    if (type == WLShoppingSubCellTypeBanner) {
      
    } else if (type == WLShoppingSubCellTypeItem) {
        
       
    } else {
        
        FishCouponItemModel *model = self.dataArray[indexPath.row];
        
        if (![model.coupon_share_url hasPrefix:@"http"]) {
            model.coupon_share_url = [@"https:" stringByAppendingString:model.coupon_share_url];
        }
        
        [FishAliHandler viewController:self openWithUrl:model.coupon_share_url success:^(AlibcTradeResult * _Nonnull result) {
            
            
            
        } failed:^(NSError * _Nonnull error) {
            
        }];
    }
    
   
    
    
}


- (void)pull {
    
    _page = 1;

    _tableView.mj_header.hidden = YES;
    _tableView.mj_footer.hidden = YES;
    [_tableView setContentOffset:CGPointZero animated:NO];

    NSDictionary *dict  =@{@"page":@(_page)};
    
     NSString *path = [NSString stringWithFormat:@"/xunquan/cat/%@",_cate.cateId];
    
    __weak typeof(self) wself =self;
    [FishNetworkFirstHandler xunquancatCouponWithPath:path paramater:dict.copy success:^(NSURLResponse *response, id data) {
        
        
        NSArray *array= [NSArray yy_modelArrayWithClass:[FishCouponItemModel class] json:data];
        
        if (array.count) {
            [self.dataArray removeAllObjects];
            [wself.tableView reloadData];
            [self.dataArray addObjectsFromArray:array];
            [self.tableView reloadData];
            wself.tableView.mj_footer.hidden = NO;
            wself.tableView.mj_header.hidden = NO;
            [wself.tableView.mj_footer setState:MJRefreshStateIdle];
            
            [wself.tableView.mj_header  endRefreshing];
            
        }
        
        
        
    } failed:^(NSError *error) {
        
        
    }];
    
    
    
}


- (void)pushMore {
    
    _page ++ ;
    NSDictionary  *dic = @{@"page":@(_page)};
//    if (_sort) {
//        [dic setValue:_sort forKey:@"sort"];
//    }
    __weak typeof(self) wself = self;
    NSString *path = [NSString stringWithFormat:@"/xunquan/cat/%@",_cate.cateId];
    [FishNetworkFirstHandler xunquancatCouponWithPath:path paramater:dic success:^(NSURLResponse *response, id data) {
        
        NSArray *dataArray = [NSArray yy_modelArrayWithClass:[FishCouponItemModel class] json:data];
        if (dataArray.count) {
            [self.dataArray addObjectsFromArray:dataArray];
            [wself.tableView reloadData];
            [wself.tableView.mj_footer endRefreshing];
        } else {
            [wself.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        
    } failed:^(NSError *error) {
        
        if (20001 == error.code) {
            [wself.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    }];
    
    
}

- (void)WLXunquanColumnCellDidSelectIndex:(NSInteger)index {
    
    WLXunquanColumnModel *model = self.itemArray[index];
    
    
    if (1 == model.type) {
        WLItemShoppingViewController *itemVc = [[WLItemShoppingViewController alloc] init];
        itemVc.name = model.name;
        itemVc.urlPath = model.url;
        [self.navigationController  pushViewController:itemVc animated:YES];
        
    } else {
//        [WXPBaichuanHanlder viewController:self openByUrl:model.url success:^(AlibcTradeResult *result) {
//
//        } failed:^(NSError *error) {
//
//        }];
//
        [FishAliHandler viewController:self openWithUrl:model.url success:^(AlibcTradeResult * _Nonnull result) {
            
        } failed:^(NSError * _Nonnull error) {
            
        }];
        
        
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
