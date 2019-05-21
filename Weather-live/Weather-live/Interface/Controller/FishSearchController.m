//
//  LBSearchController.m
//  lamabiji
//
//  Created by xueping on 2018/9/24.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "FishSearchController.h"
#import "ColorSizeMacro.h"
#import "Masonry.h"
#import "FishCouponCollectionViewCell.h"
#import "FishCouponItemModel.h"
#import "MJRefresh.h"
#import "FishNetworkFirstHandler.h"
#import "YYModel.h"
#import "FishToast.h"

#import "LBKeyMacro.h"
#import "FishAliUser.h"
#import "FishDetailController.h"
#import "FishAliHandler.h"
#import "WXPSortHeaderView.h"

@interface FishSearchController ()<UISearchBarDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,WXPSortHeaderViewDelegate>

@property(nonatomic, strong)UISearchBar *searchBar;

@property(nonatomic, strong) UIBarButtonItem *cancelButtonItem;

@property(nonatomic,strong)NSMutableArray *dataSource;

@property(nonatomic,assign)CGFloat  cellHeight;

@property(nonatomic,assign)NSInteger page;

@property(nonatomic,copy)NSString *sort;

@property(nonatomic,copy)NSString *keyword;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,assign)BOOL  searchAll;
@property(nonatomic,strong)WXPSortHeaderView *headerView;



@end
static NSString *const FishSearchCouponCellIdentifier = @"FishSearchCouponCellIdentifier";
@implementation FishSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    

    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
   
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width-120 , 44 )];
    
    self.searchBar.frame = view.bounds;
    [view addSubview:self.searchBar];
    self.searchBar.barTintColor =[UIColor blueColor];
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    self.navigationItem.titleView = view;
    
   // self.navigationItem.leftBarButtonItem = nil;
    
    
    
    UITextField *textfield = [self.searchBar valueForKey:@"_searchField"];
    textfield.font = [UIFont systemFontOfSize:13.f];
    textfield.textColor = UIColorFromRGB(0xffffff);
    [textfield setValue:UIColorFromRGB(0xffffff) forKeyPath:@"_placeholderLabel.textColor"];
    float fontsize = width > 370?12:8.5;
    [textfield setValue:[UIFont systemFontOfSize:fontsize] forKeyPath:@"_placeholderLabel.font"];
 
    self.searchBar.placeholder = @"输入宝贝标题或关键词搜索";
    
    
    self.dataSource = [NSMutableArray array];
    
 
    WXPSortHeaderView *headerView = [[WXPSortHeaderView alloc] init];
    [self.view addSubview:headerView ];
    headerView.delegate = self;
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    
    [headerView resertStatus];
    _headerView = headerView;
    
    
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat itemWidth =  (width-6)/2;
    
    
    layout.itemSize = CGSizeMake(itemWidth, itemWidth + 100);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    _collectionView.delegate =  self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor =UIColorFromRGB(0xeeeeee);
    
    [_collectionView registerClass:[FishCouponCollectionViewCell class] forCellWithReuseIdentifier:FishSearchCouponCellIdentifier];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(headerView.mas_bottom);
        make.bottom.equalTo(self.view);
        
    }];
    
    
 
    
    
//    [self loadData];
    

    
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pushMore)];
    _collectionView.mj_footer.hidden = YES;
    
    [self addSearchButtonItem];
    
    

    // Do any additional setup after loading the view.
}

- (UISearchBar *)searchBar {
    
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.delegate = self ;
//        _searchBar.placeholder = @"开关切换:开-搜全部,关-搜母婴";
        
        
        
    }
    
    return _searchBar;
}



- (void)addSearchButtonItem {
    _cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    [_cancelButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14.f],NSFontAttributeName,UIColorFromRGB(0xffffff),NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    UIBarButtonItem *navigativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if ([[UIDevice currentDevice].systemVersion floatValue] > 9.9f) {
        navigativeSpacer.width = [UIScreen mainScreen].bounds.size.width < 375? 6: -6;;
    } else {
        navigativeSpacer.width = [UIScreen mainScreen].bounds.size.width < 375? 3: 5;
    }
    self.navigationItem.rightBarButtonItems = @[navigativeSpacer,_cancelButtonItem];
}


- (void)cancelAction {
    [_searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:NO];
    
}

//- (void)swtichChange:(UISwitch *)switchView {
//
//    self.searchAll = switchView.isOn;
//    if (self.searchBar.text && self.searchBar.text.length) {
//        [self searchCouponWithSearchBar:self.searchBar];
//    }
//
//}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    if (self.dataSource.count  == 0) {
        [_searchBar becomeFirstResponder];
    }
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [_searchBar resignFirstResponder];
    
}




- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
//    [_searchHintHandler configWithKeyWord:searchText];
    
    
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    
    
    
    [self searchCouponWithSearchBar:searchBar];
    
    [searchBar resignFirstResponder];
    
}

- (void)searchCouponWithSearchBar:(UISearchBar *)searchBar {
//    [_searchHintHandler.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.equalTo(self.view);
//        make.height.equalTo(@0);
//    }];
//
    if (!searchBar.text) return;
    [_headerView resertStatus];
    _sort = nil;
    _page = 1;
    _keyword = searchBar.text;
   
    [self reloadData];
    
    
}

- (void)reloadData {
    
    if (!_keyword) {
        return;
    }
    
    _collectionView.mj_footer.hidden = YES;
    [_collectionView setContentOffset:CGPointZero animated:NO];
    [self.dataSource removeAllObjects];
    [self.collectionView reloadData];
 
    
    NSString *path = @"/xunquan/search/cat/50013886";
    NSDictionary *dict;
    if (_sort) {
        dict  =  @{@"keyword":_keyword,
                   @"page":@"1",
                   @"sort":_sort
                   };
    } else {
           dict  =  @{@"keyword":_keyword,
                            @"page":@"1"};
    }
    
    __weak typeof(self) wself = self;
    
    [FishNetworkFirstHandler lamasearchWithPath:path
                                      paramater:dict
                                        success:^(NSURLResponse *response, id data) {
                                            
                                            NSArray *dataArray = [NSArray yy_modelArrayWithClass:[FishCouponItemModel class] json:data];
                                            if (dataArray.count) {
                                                [wself.dataSource addObjectsFromArray:dataArray];
                                                [wself.collectionView reloadData];
                                                wself.collectionView.mj_footer.hidden = NO;
                                                [wself.collectionView.mj_footer setState:MJRefreshStateIdle];
                                                
//                                                NSArray *historyArray    = [[NSUserDefaults standardUserDefaults] objectForKey:SearhHistoryKey];
//                                                if (historyArray ) {
//                                                    NSMutableArray *muarray = [NSMutableArray array];
//
//                                                    [muarray addObject:_keyword];
//
//                                                    for (NSString *string in historyArray) {
//
//                                                        if (![string isEqualToString:_keyword]) {
//                                                            if (muarray.count < 20) {
//                                                                [muarray addObject:string];
//                                                            }
//
//                                                        }
//                                                    }
//
//                                                    [[NSUserDefaults standardUserDefaults] setObject:muarray.copy forKey:SearhHistoryKey];
//
//                                                } else {
//
//                                                    NSMutableArray *mutaArray = [NSMutableArray array];
//                                                    [mutaArray addObject:_keyword];
//                                                    [[NSUserDefaults standardUserDefaults] setObject:mutaArray.copy forKey:SearhHistoryKey];
//                                                }
                                                
                                            } else {
                                                [FishToast view:wself.view toastMessage:@"没有查询到数据"];
                                            }
                                            
                                            
                                        }
                                         failed:^(NSError *error) {
                                             
                                             
                                             [FishToast view:self.view toastError:error];
                                             if (  20001 == error.code) {
                                                 
                                                 [self.collectionView reloadData];
                                             }
                                             
                                         }];
    
    
}




- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
//    [_searchHintHandler.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.equalTo(self.view);
//    }];
//
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [_searchBar resignFirstResponder];
}







- (void)pushMore {
    
    _page ++;
    
    NSString *path = _searchAll?@"/xunquan/search":@"/lama/search";
    
    NSString *pagesting = [NSString stringWithFormat:@"%zd",_page];
    NSDictionary *dict;
    if (_sort) {
        dict  =  @{@"keyword":_keyword,
                   @"page":pagesting,
                   @"sort":_sort
                   };
    } else {
        dict  =  @{@"keyword":_keyword,
                   @"page":pagesting};
    }
    
    
    __weak typeof(self)  wself = self;
   
    [FishNetworkFirstHandler lamasearchWithPath:path paramater:dict success:^(NSURLResponse *response, id data) {
        
        NSArray *array = [NSArray yy_modelArrayWithClass:[FishCouponItemModel class] json:data];
        
        [self.dataSource addObjectsFromArray:array];
        
        __weak typeof(self) weakself = self;
        [wself.collectionView.mj_footer endRefreshingWithCompletionBlock:^{
            [weakself.collectionView reloadData];
        }];
        
    } failed:^(NSError *error) {
        
        [wself.collectionView.mj_footer endRefreshing];
        [FishToast view:self.view toastError:error];
        if(error.code == 20001) {
            [wself.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        
    }];
//    [ searchCouponWithParamater:@{@"keyword":_keyword,@"page":pagesting}  succeuss:^(NSURLResponse *response, id data) {
//
//        NSArray *array = [NSArray yy_modelArrayWithClass:[WXPCouponItemModel class] json:data];
//
//        [self.dataSource addObjectsFromArray:array];
//
//
//        [_tableView.mj_footer endRefreshingWithCompletionBlock:^{
//            [self.tableView reloadData];
//        }];
//
//
//    } failed:^(NSError *error) {
//        [_tableView.mj_footer endRefreshing];
//        [WXPToast view:self.view toastError:error];
//        if(error.code == 20001) {
//            _tableView.mj_footer.hidden = YES;
//        }
//
//    }];
    
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.dataSource.count;
    
}


- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    FishCouponCollectionViewCell *cell  =[collectionView dequeueReusableCellWithReuseIdentifier:FishSearchCouponCellIdentifier  forIndexPath:indexPath];
    
    FishCouponItemModel     *model = self.dataSource[indexPath.row];
    [cell congfigWithModel:model];
    
    return cell;
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
    
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

//- (CGSize)collectionView:(UICollectionView *)collectionView
//                  layout:(UICollectionViewLayout *)collectionViewLayout
//  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return  self.itemSize;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    //
    //    WXPColumnModel *model = self.itemList[indexPath.row];
    //    if (_delegate && [_delegate respondsToSelector:@selector(specialItemClickWithModel:)]) {
    //        [_delegate specialItemClickWithModel:model];
    //    }
    //
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    FishCouponItemModel *model = self.dataSource[indexPath.row];
    if ([FishAliUser shareInstance].showdetail) {
        
        FishDetailController *detailVc = [[FishDetailController alloc] init];
        detailVc.itemModel = model;
        [self.navigationController pushViewController:detailVc animated:YES];
    } else {
        
        [FishAliHandler viewController:self openWithUrl:model.coupon_share_url success:^(AlibcTradeResult * _Nonnull result) {
            
        } failed:^(NSError * _Nonnull error) {
            
        }];
        
        
    }
    
    
//    LBDetailWebController *detailVc = [[LBDetailWebController alloc] init];
//    detailVc.itemModel = model;
//    [self.navigationController pushViewController:detailVc animated:YES];
}


- (void)sortHeaderChangeStatusWithString:(NSString *)sort {
    
    self.sort = sort;
    self.page = 1;
    
    [self reloadData];
    
    
}

- (void)dealloc {
    
//    [[NSUserDefaults standardUserDefaults] setBool:self.switchView.isOn forKey:searchAllKey];
    
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
