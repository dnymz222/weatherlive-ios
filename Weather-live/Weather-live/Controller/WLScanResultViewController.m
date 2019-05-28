//
//  WLScanResultViewController.m
//  Weather-live
//
//  Created by xueping on 2019/5/28.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLScanResultViewController.h"
#import "FishAliHandler.h"
#import "FishCouponItemModel.h"
#import "Masonry.h"
#import "WLTaobaoCouponCell.h"

@interface WLScanResultViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,assign)CGFloat cellHeight;


@end

@implementation WLScanResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"购物车优惠券";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self.cellHeight = width *0.4f;
    // Do any additional setup after loading the view.
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView  = [[UITableView  alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate  = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
    }
    
    return _tableView;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WLTaobaoCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[WLTaobaoCouponCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    FishCouponItemModel *model = self.dataArray[indexPath.row];
    [cell configWithCoupon:model];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FishCouponItemModel *model = self.dataArray[indexPath.row];
    
    if (![model.coupon_share_url hasPrefix:@"http"]) {
        model.coupon_share_url = [@"https:" stringByAppendingString:model.coupon_share_url];
    }
    
    [FishAliHandler viewController:self openWithUrl:model.coupon_share_url success:^(AlibcTradeResult * _Nonnull result) {
        
        
        
    } failed:^(NSError * _Nonnull error) {
        
    }];
    
    
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
