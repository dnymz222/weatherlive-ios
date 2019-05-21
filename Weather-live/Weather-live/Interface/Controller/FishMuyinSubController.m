//
//  LBMuyinSubController.m
//  lamabiji
//
//  Created by mc on 2018/9/12.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "FishMuyinSubController.h"
#import "FishNetworkFirstHandler.h"
#import "FishCouponCollectionViewCell.h"
#import "ColorSizeMacro.h"
#import "Masonry.h"
#import "YYModel.h"
#import "FishCouponItemModel.h"
#import "MJRefresh.h"

#import "FishErrorTipView.h"


#import "FishCateModel.h"
#import "FishAliHandler.h"
#import "FishDetailController.h"
#import "FishAliUser.h"
#import "WXPSortHeaderView.h"



@interface FishMuyinSubController ()<UICollectionViewDelegate,UICollectionViewDataSource,LBErrorTipViewDelegate,WXPSortHeaderViewDelegate>

@property(nonatomic,assign)NSInteger loaddata;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)CGFloat itemWith;

//@property(nonatomic,assign)CGFloat cateItemWith;

@property(nonatomic,strong)NSMutableArray *sectionArray;
@property(nonatomic,copy)NSString *sort;
//@property(nonatomic,assign)CGSize bannerSize;

@end

static NSString *const FishCouponCollectionViewCellIdentifier = @"FishCouponCollectionViewCellIdentifier";
//static NSString *const LBcategoryItemViewIdentifier = @"FishcategoryItemViewIdentifier";
//static NSString *const LBBannercellIdentifier = @"FishBannercellIdentifier";

@implementation FishMuyinSubController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    WXPSortHeaderView *headerView = [[WXPSortHeaderView alloc] init];
    [self.view addSubview:headerView ];
    headerView.delegate = self;
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    
    [headerView resertStatus];
    
    self.dataArray = [NSMutableArray array];
    self.sectionArray = [NSMutableArray array];

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth =  (width-6)/2;
    layout.itemSize = CGSizeMake(itemWidth, itemWidth + 100);
    self.itemWith = itemWidth;
//    self.cateItemWith = width/5.0;
//    self.bannerSize  =  CGSizeMake(width,width *180.0/440.0);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    _collectionView.delegate =  self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor =UIColorFromRGB(0xeeeeee);
    
    [_collectionView registerClass:[FishCouponCollectionViewCell class] forCellWithReuseIdentifier:FishCouponCollectionViewCellIdentifier];
//    [_collectionView registerClass:[LBCategoryItemView class] forCellWithReuseIdentifier:LBcategoryItemViewIdentifier];
//    [_collectionView registerClass:[LBBannerCell class] forCellWithReuseIdentifier:LBBannercellIdentifier];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(headerView.mas_bottom);
        make.bottom.equalTo(self.view);
        
    }];
    
    
    
    [self loadData];
    
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pull)];
    _collectionView.mj_header.hidden = YES;
    
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pushMore)];
    _collectionView.mj_footer.hidden = YES;
    
    
    
    
    
    
    _page = 1;
    // Do any additional setup after loading the view.
}

//
//- (void)setCateItemArray:(NSArray *)cateItemArray  {
//
//    _cateItemArray = cateItemArray;
//    if (_collectionView) {
//        [_collectionView reloadData];
//    }
//
//}

//- (void)setBannerArray:(NSArray *)bannerArray {
//    
//}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView

{
    [self.sectionArray removeAllObjects];
//    if (self.first && self.bannerArray) {
//         [self.sectionArray  addObject:@(LBMuyinSubSectionTypeBanner)];
//    }
//    if (self.first && self.cateItemArray) {
//        [self.sectionArray  addObject:@(LBMuyinSubSectionTypeCate)];
//    }
    [self.sectionArray addObject:@(FishMuyinSubSectionTypeItem)];
    
    return self.sectionArray.count;
}





- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    LBMuyinSubSectionType type = (LBMuyinSubSectionType)[self.sectionArray[section] integerValue];
    
    switch (type) {
//        case LBMuyinSubSectionTypeBanner:
//            return 1;
//            break;
//        case LBMuyinSubSectionTypeCate:
//
//            return self.cateItemArray.count;
//            break;
        case FishMuyinSubSectionTypeItem:
            
            return self.dataArray.count;
            
            break;
            
        default:
            break;
    }
    
    
   
    
}


- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    LBMuyinSubSectionType type = (LBMuyinSubSectionType)[self.sectionArray[indexPath.section] integerValue];
    
    switch (type) {
            
//        case LBMuyinSubSectionTypeBanner:
//
//        {
//            LBBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LBBannercellIdentifier forIndexPath:indexPath];
//            cell.delegate  = self;
//            [cell configImageArray:[self.bannerArray valueForKey:@"imageUrl"]];
//
//            return cell;
//
//
//        }
            
//            break;
//        case LBMuyinSubSectionTypeCate:
//        {
//
//            LBCategoryItemView *itemview = [collectionView dequeueReusableCellWithReuseIdentifier:LBcategoryItemViewIdentifier forIndexPath:indexPath];
//            itemview.contentView.backgroundColor = [UIColor whiteColor];
//
//            LBCateModel *cateModel = self.cateItemArray[indexPath.row];
//            cateModel.five = YES;
//            [itemview configWithCateModel:cateModel];
//            return itemview;
//        }
//            break;
        case FishMuyinSubSectionTypeItem:
        {
            FishCouponCollectionViewCell *cell  =[collectionView dequeueReusableCellWithReuseIdentifier:FishCouponCollectionViewCellIdentifier  forIndexPath:indexPath];
            
            FishCouponItemModel     *model = self.dataArray[indexPath.row];
            [cell congfigWithModel:model];
            
            return cell;
        }

            
            break;
            
        default:
            break;
    }
    
    
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
     LBMuyinSubSectionType type = (LBMuyinSubSectionType)[self.sectionArray[section] integerValue];
    switch (type) {
//        case LBMuyinSubSectionTypeBanner:
//            return 0;
//            break;
//        case LBMuyinSubSectionTypeCate:
//            return 0;
//            break;
        case FishMuyinSubSectionTypeItem:
            return 5;
            break;
            
        default:
            break;
    }
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    LBMuyinSubSectionType type = (LBMuyinSubSectionType)[self.sectionArray[indexPath.section] integerValue];
    
    switch (type) {
//        case LBMuyinSubSectionTypeBanner:
//            return self.bannerSize;
//            break;
//        case LBMuyinSubSectionTypeCate:
//
//             return CGSizeMake(_cateItemWith, _cateItemWith + 10);
//            break;
        case FishMuyinSubSectionTypeItem:
            
             return CGSizeMake(_itemWith, _itemWith + 100);
            
            
            break;
            
        default:
            break;
    }
    
    
   
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//
//    WXPColumnModel *model = self.itemList[indexPath.row];
//    if (_delegate && [_delegate respondsToSelector:@selector(specialItemClickWithModel:)]) {
//        [_delegate specialItemClickWithModel:model];
//    }
//
    
    
    LBMuyinSubSectionType type = (LBMuyinSubSectionType)[self.sectionArray[indexPath.section] integerValue];
    
    switch (type) {
//        case LBMuyinSubSectionTypeCate:
//        {
//
//            LBCateModel *model = self.cateItemArray[indexPath.row];
//            if (1 == model.type) {
//                LBSubCategoryController *controller = [[LBSubCategoryController alloc] init];
//                controller.cateModel = model;
//                [self.navigationController pushViewController:controller animated:YES];
//            } else if (3 == model.type) {
//
//                [LBAliHandler viewController:self openWithUrl:model.url success:^(AlibcTradeResult * _Nonnull result) {
//
//                } failed:^(NSError * _Nonnull error) {
//
//                }];
//            } else {
            
                
//                LBMuyinSubController *controller = [[LBMuyinSubController alloc] init];
//                controller.url = model.url;
//                [self.navigationController pushViewController:controller animated:YES];
////            }
//
//
//
//        }
//
//
//            break;
        case FishMuyinSubSectionTypeItem:
        {
            [collectionView deselectItemAtIndexPath:indexPath animated:YES];
            
            FishCouponItemModel *model = self.dataArray[indexPath.row];

            if ([FishAliUser shareInstance].showdetail) {
               
                FishDetailController *detailVc = [[FishDetailController alloc] init];
                detailVc.itemModel = model;
                [self.navigationController pushViewController:detailVc animated:YES];
            } else {
                
                NSString *url = [@"https:" stringByAppendingString:model.coupon_share_url];
                
                [FishAliHandler viewController:self openWithUrl:url success:^(AlibcTradeResult * _Nonnull result) {
                    
                } failed:^(NSError * _Nonnull error) {
                    
                }];
                
                
            }
            
          
            
            
        }
           
            
            break;
            
        default:
            break;
    }

    
    

}





- (void)loadData {
    
    
    if ((!_loaddata)  && _url) {
        
        
       
        
        NSMutableDictionary *dict  = [NSMutableDictionary dictionary];
        [dict setObject:@(_page) forKey:@"page"];
        if (_sort) {
            [dict setValue:_sort forKey:@"sort"];
        }
        
        
        __weak typeof(self) wself = self;
    
        
        [FishNetworkFirstHandler lamacatCouponWithPath:_url paramater:dict.copy success:^(NSURLResponse *response, id data) {
            
            
            NSArray *array= [NSArray yy_modelArrayWithClass:[FishCouponItemModel class] json:data];
            if (array.count) {
                [self.dataArray addObjectsFromArray:array];
                [self.collectionView reloadData];
                wself.collectionView.mj_header.hidden = NO;
                wself.collectionView.mj_footer.hidden = NO;
                
                
            }
            
            wself.loaddata  = 1;
            
        } failed:^(NSError *error) {
            
            wself.loaddata = 2;
            
            [FishErrorTipView showInView:self.view delegate:self];
            
        }];
    
    }
    
}

- (void)reloadData {
    
    NSMutableDictionary *dict  = [NSMutableDictionary dictionary];
    [dict setObject:@(_page) forKey:@"page"];
    if (_sort) {
        [dict setValue:_sort forKey:@"sort"];
    }
    
    
    
    if (2 == _loaddata) {
        __weak typeof(self) wself = self;
        [FishNetworkFirstHandler lamacatCouponWithPath:_url paramater:dict.copy success:^(NSURLResponse *response, id data) {
            
            
            NSArray *array= [NSArray yy_modelArrayWithClass:[FishCouponItemModel class] json:data];
            
            if (array.count) {
                [FishErrorTipView removeErrorviewInView:self.view];
                [self.dataArray addObjectsFromArray:array];
                [self.collectionView reloadData];
                wself.collectionView.mj_footer.hidden = NO;
                wself.collectionView.mj_header.hidden = NO;
                
            }
            
            wself.loaddata  = 1;
            
        } failed:^(NSError *error) {
            
            wself.loaddata = 2;
        }];

    }
    
}


- (void)errorviewTapinView:(FishErrorTipView *)errorView {
    
    [self reloadData];
}


- (void)pull {
    
    _page = 1;
    NSMutableDictionary *dict  = [NSMutableDictionary dictionary];
    [dict setObject:@(_page) forKey:@"page"];
    if (_sort) {
        [dict setValue:_sort forKey:@"sort"];
    }
    
    if (1 ==_page) {
        _collectionView.mj_header.hidden = YES;
        _collectionView.mj_footer.hidden = YES;
        [_collectionView setContentOffset:CGPointZero animated:NO];
//        [self.dataArray removeAllObjects];
//        [_collectionView reloadData];
    }
    
    __weak typeof(self) wself =self;
    [FishNetworkFirstHandler lamacatCouponWithPath:_url paramater:dict.copy success:^(NSURLResponse *response, id data) {
        
        
        NSArray *array= [NSArray yy_modelArrayWithClass:[FishCouponItemModel class] json:data];
        
        if (array.count) {
            [self.dataArray removeAllObjects];
            [wself.collectionView reloadData];
            [self.dataArray addObjectsFromArray:array];
            [self.collectionView reloadData];
            wself.collectionView.mj_footer.hidden = NO;
            wself.collectionView.mj_header.hidden = NO;
            [wself.collectionView.mj_footer setState:MJRefreshStateIdle];
        
            [wself.collectionView.mj_header  endRefreshing];
           
        }
        
        
        
    } failed:^(NSError *error) {
        
    
    }];
    
    
    
}
                                 

- (void)pushMore {
    
    _page ++ ;
    NSMutableDictionary *dic = @{@"page":@(_page)}.mutableCopy;
    if (_sort) {
        [dic setValue:_sort forKey:@"sort"];
    }
    __weak typeof(self) wself = self;
    [FishNetworkFirstHandler lamacatCouponWithPath:_url paramater:dic.copy success:^(NSURLResponse *response, id data) {
        
        NSArray *dataArray = [NSArray yy_modelArrayWithClass:[FishCouponItemModel class] json:data];
        if (dataArray.count) {
            [self.dataArray addObjectsFromArray:dataArray];
            [wself.collectionView reloadData];
            [wself.collectionView.mj_footer endRefreshing];
        } else {
            [wself.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        
        
    } failed:^(NSError *error) {
        
        if (20001 == error.code) {
            [wself.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        
    }];
    
    
}

- (void)sortHeaderChangeStatusWithString:(NSString *)sort {
    
    self.sort = sort;
    self.page = 1;
    [self pull];
    
    
    
    
}
//- (void)lbBannerCellClickImageAtIndex:(NSInteger)index {
//    
//    LBBannerModel *model = self.bannerArray[index];
//    
//    
//    [LBAliHandler viewController:self openWithUrl:model.bannerUrl success:^(AlibcTradeResult * _Nonnull result) {
//        
//    } failed:^(NSError * _Nonnull error) {
//        
//    }];
//    
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
