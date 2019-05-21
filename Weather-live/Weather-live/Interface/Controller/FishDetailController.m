//
//  LBDetailController.m
//  lamabiji
//
//  Created by mc on 2018/9/29.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "FishDetailController.h"
#import "NSString+LB.h"
#import "FishNetworkBaseHandler.h"
#import "FishNetworkFirstHandler.h"
#import "FishCouponItemModel.h"
#import "FishDetailItemModel.h"
//#import "LBDetailRateModel.h"
#import "FishSellerModel.h"
#import "FishImageItemModel.h"
#import "YYModel.h"
#import "FishDetailTitleCell.h"
#import "FishDetailImageHeaderView.h"
#import "FishDetailShopCell.h"
//#import "LBDetailRateCell.h"
//#import "LBDetailRateFooterView.h"
#import "FishImageListCell.h"
#import "FishDetailHeaderView.h"
#import "ColorSizeMacro.h"
#import "Masonry.h"
#import "FishImageItemModel.h"
#import "FishCouponDetailBottomView.h"
#import "FishAliHandler.h"
#import "NSString+MD5.h"
#import "FishToast.h"
//#import "LBRateController.h"

#import "NSString+LB.h"
#import "FishAliUser.h"
#import "LBKeyMacro.h"




static NSString *const FishDetailTitleCellIdentifer = @"FishDetailTitleCellIdentifer";
static NSString *const FishDetailImageHeaderViewIdentifier  = @"FishDetailImageHeaderViewIdentifier";
static NSString *const FishetailShopCellIdentifier = @"FishDetailShopCellIdentifier";
static NSString *const FishImageListCellIdentifier = @"FishImageListCellIdentifier";
static NSString *const FishetailHeaderViewIdentifier = @"FishDetailHeaderViewIdentifier";
static NSString *const UITableViewCellIdentifier  = @"UITableViewCellIdentifier";
static NSString *const FishDetailRateFooterViewIdentifier = @"FishDetailRateFooterViewIdentifier";


typedef NS_ENUM(NSInteger,LBDetailSectionType) {
    FishDetailSectionTypeItem =0, //
    FishDetailSectionTypeSeller,
//    LBDetailSectionTypeRate,
    FishDetailSectionTypeParamer,
    FishDetailSectionTypeDetail,
    
    
};

@interface FishDetailController ()<UITableViewDelegate,UITableViewDataSource,LBCouponDetailBottomViewDelegate,LBDetailTitleCellDelegate,LBImageListCellDelegate>

@property(nonatomic,copy)NSString *itemId;

@property(nonatomic,strong)FishDetailItemModel *detailItemModel;
@property(nonatomic,strong)FishSellerModel *sellerModel;
//@property(nonatomic,strong)LBDetailRateModel *rateModel;
@property(nonatomic,copy)NSArray *rateLsit;
@property(nonatomic,copy)NSArray *productParas;
@property(nonatomic,strong)NSArray *imageArray;

@property(nonatomic,strong)NSMutableArray *sectionArray;

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)FishCouponDetailBottomView *bottomView;
@property(nonatomic,assign)BOOL hasData;

@end

@implementation FishDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.sectionArray = [NSMutableArray array];
    self.itemId = self.itemModel.item_id;
    self.navigationItem.title = @"商品详情";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    CGFloat bootomspace = KIsiPhoneX ?34 :0;
//    [LBUser shareInstance].showrate =2;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-44-bootomspace);
        
    }];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-bootomspace);
        make.top.equalTo(self.tableView.mas_bottom);
        
    }];
    
    NSDictionary * exparamas = @{@"id":self.itemId,
                                 @"locate":@"guessitem-item",
                                 @"pvid":@"",
                                 @"scm":@"",
                                 @"spm":@"",
                                 };
    NSString * exparastring = [NSString fish_dictTojsonWithJsonObject:exparamas];
    
    NSDictionary *dataobject = @{
                                 @"exParams":exparastring,
                                 @"itemNumId":self.itemId,
                                 
                                 
                                 };
    //    dataobject.exParams = exparastring;
    //    dataobject.itemNumId = itemId;
    NSString *datastring = [NSString fish_dictTojsonWithJsonObject:dataobject];
    
    NSString  *urlstring =[@"https://h5api.m.taobao.com/h5/mtop.taobao.detail.getdetail/6.0/?jsv=2.4.8&api=mtop.taobao.detail.getdetail&v=6.0&ttid=2016%40taobao_h5_2.0.0&isSec=0&ecode=0&AntiFlood=true&AntiCreep=true&H5Request=true&type=json&dataType=json&data=" stringByAppendingString: [datastring fish_encodeToPercentEscapeString]];
    
    [FishNetworkBaseHandler sendGetRequestWithUrl:urlstring success:^(NSURLResponse *response, id data) {
//        NSLog(@"data:%@",data);
        
        NSDictionary   *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil ];
        
        if ([dict isKindOfClass:[NSDictionary class]]) {
            NSDictionary *datadict = [dict valueForKey:@"data"];
            self.detailItemModel = [FishDetailItemModel yy_modelWithJSON:[datadict objectForKey:@"item"]];
            self.sellerModel = [FishSellerModel yy_modelWithJSON:[datadict objectForKey:@"seller"]];
            if ([FishAliUser shareInstance].showrate) {
                NSDictionary *ratedict = datadict[@"rate"];
//                if ([ratedict isKindOfClass:[NSDictionary class]]) {
//                    self.rateLsit = [NSArray yy_modelArrayWithClass:[LBDetailRateModel class] json:[ratedict objectForKey:@"rateList"]];
//                    if (self.rateLsit.count) {
//                        self.rateModel = [self.rateLsit firstObject];
//                        [self.rateModel cacluteHeight];
//                    }
//                }
            }
           
            
            
            @try {
                NSArray *propsArray= datadict[@"props"][@"groupProps"][0][@"基本信息"];
                NSMutableArray *dataArray = [NSMutableArray array];
                for (NSDictionary *dict in propsArray) {
                    NSArray *allkeys = [dict allKeys];
                    if (allkeys.count) {
                        NSString *key = [allkeys firstObject];
                        NSString *desString = [NSString stringWithFormat:@"%@：%@",key,dict[key]];
                        [dataArray addObject:desString];
                    }
                }
                self.productParas = dataArray.copy;
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
            
            
            [self.tableView reloadData];
            _hasData = YES;
            [self loadDetailImages];
            
            
            
            
        }
        
    } failed:^(NSError *error) {
        
        [FishToast view:self.view toastError:error];
    }];
    
    
    
//    [self loadDetailImages];
    
  
    
    
    
    // Do any additional setup after loading the view.
}

- (void)loadDetailImages {
    
    
    long long  timeinterval  = (long long) [[NSDate date] timeIntervalSince1970];
    
    
    NSString *key = [NSString stringWithFormat:@"%lld%@",timeinterval,@"lamabiji"];
    NSString *md5value = [key md5];
    NSDictionary *dict = @{
                           @"t":[NSString stringWithFormat:@"%lld",timeinterval],
                           @"s":md5value
                           
                           };
    
//    NSString *urlstring = [NSString stringWithFormat:@"https://hws.m.taobao.com/cache/desc/5.0?id=%@&type=0",self.itemId];
    
                           
//    [FishNetworkBaseHandler sendGetRequestWithUrl:urlstring success:^(NSURLResponse *response, id data) {
//        NSDictionary   *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil ];
//
//        NSDictionary *content = [dict valueForKey:@"wdescContent"];
//        NSArray *pages = [content   valueForKey:@"pages"];
//        NSString *pagesjson = [NSString fish_dictTojsonWithJsonObject:pages];
//        if (pagesjson) {
//
//            [LBNetworkBijiHandler lamaImageTransWithparamater:@{@"images":pagesjson} success:^(NSURLResponse *response, id data) {
//                NSLog(@"data:%@",data);
//                self.imageArray = [NSArray yy_modelArrayWithClass:[LBImageItemModel class] json:data];
//                if (_hasData) {
//                    [self.tableView reloadData];
//                }
//
//            } failed:^(NSError *error) {
//
//            }];
//
//
//
//        }
//
//
//
//    } failed:^(NSError *error) {
//
//    }];
    
    if (self.detailItemModel.moduleDescUrl) {
        
        NSString *urlsting ;
        if ([self.detailItemModel.moduleDescUrl hasPrefix:@"http"]) {
            urlsting = self.detailItemModel.moduleDescUrl;
        } else{
            urlsting= [@"https:"  stringByAppendingString:self.detailItemModel.moduleDescUrl];
        }
        [FishNetworkBaseHandler sendGetRequestWithUrl:urlsting success:^(NSURLResponse *response, id data) {
            
            NSMutableArray *imageArray = [NSMutableArray array];
            
            NSDictionary   *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil ];
            NSDictionary *dataDict = [dict valueForKey:@"data"];
            if (dataDict) {
                NSArray *childArray = [dataDict valueForKey:@"children"];
                
                if (childArray && [childArray isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *dict in childArray) {
                        NSDictionary *params = [dict valueForKey:@"params"];
                        if (params && [params isKindOfClass:[NSDictionary class]]) {
                            NSString *picurl = [params valueForKey:@"picUrl"];
                            if (picurl) {
                                FishImageItemModel *model = [[FishImageItemModel alloc] init];
                                model.image = picurl;
                                NSDictionary *size = [params valueForKey:@"size"];
                                if (size && [size isKindOfClass:[NSDictionary class]]) {
                                    model.width = [size valueForKey:@"width"];
                                    model.height = [size valueForKey:@"height"];
                                }
                                
                                [imageArray addObject:model];
                            }
                        }
                        
                    }
                }
            }
            
            if (imageArray.count) {
                self.imageArray = imageArray.copy;
                [self.tableView reloadData];
                
            } else {
                
                [FishNetworkFirstHandler lamaDetailImagesWithItemId:self.itemId
                                                       paramater:dict
                                                         success:^(NSURLResponse *response, id data) {
                                                             
                                                             
                                                             self.imageArray = [NSArray yy_modelArrayWithClass:[FishImageItemModel class] json:data];
                                                             //            if (_hasData) {
                                                             [self.tableView reloadData];
                                                             //            }
                                                             
                                                             
                                                             
                                                         } failed:^(NSError *error) {
                                                             
                                                         }];
                
                
                
            }
            
            
            
          
            
        } failed:^(NSError *error) {
            
        }];
        
        
    } else {
    
    
        [FishNetworkFirstHandler lamaDetailImagesWithItemId:self.itemId
                                               paramater:dict
                                                 success:^(NSURLResponse *response, id data) {


            self.imageArray = [NSArray yy_modelArrayWithClass:[FishImageItemModel class] json:data];
//            if (_hasData) {
                [self.tableView reloadData];
//            }



        } failed:^(NSError *error) {

        }];
    }
    
    
}

- (FishCouponDetailBottomView *)bottomView {
    
    if (!_bottomView) {
        _bottomView = [[FishCouponDetailBottomView alloc] init];
        _bottomView.delegate = self;
    }
    
    return _bottomView;
}


- (void)bottomViewClickButtonAtIndex:(NSInteger)buttonIndex {
    
    if (0 == buttonIndex) {
        [self.navigationController  popViewControllerAnimated:YES];
    } else {
        
        NSString *url = [@"https:" stringByAppendingString:self.itemModel.coupon_share_url];
        [FishAliHandler viewController:self openWithUrl:url success:^(AlibcTradeResult * _Nonnull result) {
            
        } failed:^(NSError * _Nonnull error) {
            
        }];
    }
    
}

- (void)couponButtonClick:(UIButton *)button {
    NSString *url = [@"https:" stringByAppendingString:self.itemModel.coupon_share_url];
    [FishAliHandler viewController:self openWithUrl:url success:^(AlibcTradeResult * _Nonnull result) {
        
    } failed:^(NSError * _Nonnull error) {
        
    }];
    
}




- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor  = UIColorFromRGB(0xcccccc);
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    
    return _tableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    [self.sectionArray removeAllObjects];
    if (self.detailItemModel) {
        [self.sectionArray addObject:@(FishDetailSectionTypeItem)];
    }
    if (self.sellerModel) {
        [self.sectionArray addObject:@(FishDetailSectionTypeSeller)];
        
    }
    
    if (self.productParas.count) {
        [self.sectionArray addObject:@(FishDetailSectionTypeParamer)];
    }
    
//    if (self.rateModel) {
//        [self.sectionArray addObject:@(LBDetailSectionTypeRate)];
//    }
    if (self.imageArray.count) {
        [self.sectionArray addObject:@(FishDetailSectionTypeDetail)];
    }
    
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    LBDetailSectionType type = (LBDetailSectionType)[self.sectionArray[section] integerValue];
    
    switch (type) {
        case FishDetailSectionTypeItem:
            return 1;
            
            break;
        case FishDetailSectionTypeSeller:
            return 1;
            
            break;
        case FishDetailSectionTypeParamer:
            return self.productParas.count;
            
            break;
//        case LBDetailSectionTypeRate:
//
//            return 1;
//
//            break;
        case FishDetailSectionTypeDetail:
            
            return self.imageArray.count;
            
            break;
            
        default:
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LBDetailSectionType type = (LBDetailSectionType)[self.sectionArray[indexPath.section] integerValue];
    
    switch (type) {
        case FishDetailSectionTypeItem:
            return 166;
            break;
        case FishDetailSectionTypeSeller:
            
            return 80;
            
            break;
        case FishDetailSectionTypeParamer:
            return 30;
            break;
//        case LBDetailSectionTypeRate:
//
//            return self.rateModel.totalHeight;
//            break;
        case FishDetailSectionTypeDetail:
        {
            FishImageItemModel *itemModel = self.imageArray[indexPath.row];
            if (itemModel.outHeight) {
                return itemModel.outHeight;
            }else if (!itemModel.width) {
                return kScreenWidth;
            } else if (!itemModel.height) {
                return kScreenWidth;
            } else {
                CGFloat height = [itemModel.height floatValue]/[itemModel.width floatValue] *kScreenWidth;
                itemModel.outHeight = height;
                return height;
                
            }
            
        }
            break;
            
        default:
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    LBDetailSectionType type = (LBDetailSectionType)[self.sectionArray[section] integerValue];
    
    switch (type) {
        case FishDetailSectionTypeItem:
            return kScreenWidth;
            break;
        case FishDetailSectionTypeSeller:
            return CGFLOAT_MIN;
            
            break;
        case FishDetailSectionTypeParamer:
            
            return 44;
            
            break;
//        case LBDetailSectionTypeRate:
//
//            return 44;
//            break;
        case FishDetailSectionTypeDetail:
            return 44;
            break;
            
        default:
            break;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    LBDetailSectionType type = (LBDetailSectionType)[self.sectionArray[section] integerValue];
    
    switch (type) {
        case FishDetailSectionTypeItem:
            
            return 4;
            
            break;
        case FishDetailSectionTypeSeller:
            
            return 4;
            
            break;
        case FishDetailSectionTypeParamer:
            
            return 4;
            
            break;
//        case LBDetailSectionTypeRate:
//
//            return 56;
//
//
//            break;
        case FishDetailSectionTypeDetail:
            return CGFLOAT_MIN;
            break;
            
        default:
            break;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LBDetailSectionType type = (LBDetailSectionType)[self.sectionArray[indexPath.section] integerValue];
    
    switch (type) {
        case FishDetailSectionTypeItem:
        {
            FishDetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:FishDetailTitleCellIdentifer];
            if (cell == nil) {
                cell = [[FishDetailTitleCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:FishDetailTitleCellIdentifer];
                cell.delegate = self;
            }
            [cell configWithDetailItemModel:self.detailItemModel coupon:self.itemModel];
            return cell;
        }
            
            break;
        case FishDetailSectionTypeSeller:
        {
            FishDetailShopCell *cell = [tableView dequeueReusableCellWithIdentifier:FishetailShopCellIdentifier];
            if (cell == nil) {
                cell = [[FishDetailShopCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:FishetailShopCellIdentifier];
            }
            [cell configWithModel:self.sellerModel];
            return cell;
        }
            
            break;
        case FishDetailSectionTypeParamer:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:UITableViewCellIdentifier];
                cell.textLabel.font = [UIFont systemFontOfSize:12.f];
                cell.textLabel.textColor = UIColorFromRGB(0x999999);
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.textLabel.text = self.productParas[indexPath.row];
            return cell;
        }
            
            break;
//        case LBDetailSectionTypeRate:
//        {
//            LBDetailRateCell *cell = [tableView dequeueReusableCellWithIdentifier:LBDetailRateCellIdentifier];
//            if (cell == nil) {
//                cell = [[LBDetailRateCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:LBDetailRateCellIdentifier];
//                cell.delegate = self;
//            }
//
////            LBDetailRateModel *model = [self.rateLsit firstObject];
//            [cell configWithDetailRateModel:self.rateModel];
//
//            return cell;
//
//        }
            
            
            break;
        case FishDetailSectionTypeDetail:
        {
            FishImageListCell *cell = [tableView dequeueReusableCellWithIdentifier:FishImageListCellIdentifier];
            if (cell == nil) {
                cell = [[FishImageListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:FishImageListCellIdentifier];
                cell.delegate = self;
            }
            
            FishImageItemModel *model = self.imageArray[indexPath.row];
            [cell configWithModel:model];
            
            return cell;
        }
            
            break;
            
        default:
            break;
    }
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    LBDetailSectionType type = (LBDetailSectionType)[self.sectionArray[section] integerValue];
    
    switch (type) {
        case FishDetailSectionTypeItem:
            
        {
            FishDetailImageHeaderView *headerview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FishDetailImageHeaderViewIdentifier];
            if (headerview == nil  ) {
                headerview   = [[FishDetailImageHeaderView alloc] initWithReuseIdentifier:FishDetailImageHeaderViewIdentifier];
            }
            [headerview  configImageArray:self.detailItemModel.images];
            return headerview   ;
        }
            
            break;
        case FishDetailSectionTypeSeller:
            return nil;
            
            break;
        case FishDetailSectionTypeParamer:
        {
            FishDetailHeaderView *headerview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FishetailHeaderViewIdentifier];
            if (headerview == nil  ) {
                headerview   = [[FishDetailHeaderView alloc] initWithReuseIdentifier:FishetailHeaderViewIdentifier];
            }
            [headerview configTitle:@"产品参数"];
            return headerview;
        }
            
            break;
//        case LBDetailSectionTypeRate:
//
//        {
//            LBDetailHeaderView *headerview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:LBDetailHeaderViewIdentifier];
//            if (headerview == nil  ) {
//                headerview   = [[LBDetailHeaderView alloc] initWithReuseIdentifier:LBDetailHeaderViewIdentifier];
//            }
//            [headerview configTitle:@"商品评价"];
//            return headerview;
//        }
            
            break;
        case FishDetailSectionTypeDetail:
        {
            FishDetailHeaderView *headerview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FishetailHeaderViewIdentifier];
            if (headerview == nil  ) {
                headerview   = [[FishDetailHeaderView alloc] initWithReuseIdentifier:FishetailHeaderViewIdentifier];
            }
            [headerview configTitle:@"商品详情"];
            return headerview;
        }
            
            break;
            
        default:
            break;
    }
    
    return nil;
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    LBDetailSectionType type = (LBDetailSectionType)[self.sectionArray[section] integerValue];
    
    switch (type) {
        case FishDetailSectionTypeItem:
            return nil;
            
            break;
        case FishDetailSectionTypeSeller:
            return nil;
            
            break;
        case FishDetailSectionTypeParamer:
            return nil;
            
            break;
//        case LBDetailSectionTypeRate:
//        {
//            LBDetailRateFooterView *footerview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:LBDetailRateFooterViewIdentifier];
//            if (footerview == nil) {
//                footerview = [[LBDetailRateFooterView alloc] initWithReuseIdentifier:LBDetailRateFooterViewIdentifier];
//                footerview.delegate = self;
//            }
//
//            return footerview;
//        }
            
            
            break;
        case FishDetailSectionTypeDetail:
        {
            
            return nil;
            
        }
            
            break;
            
        default:
            break;
    }
    
}

- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)reloadImageHeight {
    
    [self.tableView reloadData];
}

//- (void)rateFooterViewButtonClick:(UIButton *)button {
//    
//    LBRateController *controller = [[LBRateController alloc] init];
//    controller.itemId = self.itemId;
//    [self.navigationController pushViewController:controller animated:YES];
//    
//}

//- (void)rateCellTouchImageInCellTag:(NSInteger)celltag atIndex:(NSInteger)index collectionView:(UICollectionView *)collectionView
//{
//    PictureSacnViewController *picVC=[[PictureSacnViewController alloc] init];
//    NSMutableArray *array=[NSMutableArray array];
//
//    for (NSString   *string  in self.rateModel.images) {
//        NSString * imageString = string;
//        if (![imageString containsString:@"http"]) {
//            imageString = [@"https:" stringByAppendingString:imageString];
////            imageString = [imageString stringByReplacingOccurrencesOfString:@"_40x40.jpg" withString:@""];
//        }
//
//        [array addObject:imageString];
//
//    }
//    picVC.picArray= array;
//    picVC.currenpage=index + 1;//当前图片
////    picVC.modalPresentationStyle = 5;
//    [self.navigationController presentViewController:picVC animated:NO completion:nil];
//
//
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
