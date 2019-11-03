//
//  WLIndexSelectViewController.m
//  Weather-live
//
//  Created by xueping on 2019/10/25.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLIndexSelectViewController.h"
#import "WLIndexSelectCell.h"
#import "Masonry.h"
#import "WLAccuIndexModel.h"
#import "LBKeyMacro.h"
#import "WLAccuNormalHeaderView.h"

@interface WLIndexSelectViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,assign)NSInteger selectFirst;
@property(nonatomic,assign)NSInteger selectTwo;

@property(nonatomic,strong)NSUserDefaults *userdefaults;

@end

@implementation WLIndexSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.navigationItem.title = NSLocalizedString(@"select two items", nil);
    
    NSUserDefaults *userdefalult = [[NSUserDefaults alloc] initWithSuiteName:Appgroupkey];
    
    self.selectFirst = [userdefalult   integerForKey:AppgroupIndiciesSelect1Key]?:-100;
    self.selectTwo = [userdefalult  integerForKey:AppgroupIndiciesSelect2Key]?:-100;
    self.userdefaults = userdefalult;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    
    
    
  

    // Do any additional setup after loading the view.
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    
    return _tableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 120;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    WLAccuNormalHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
      
      if (headerView == nil) {
          headerView = [[WLAccuNormalHeaderView alloc] initWithReuseIdentifier:@"header"];
          headerView.button.hidden =  YES;
          headerView.titleLabel.text = NSLocalizedString(@"select tips", nil);
      }
    
    
          
    return headerView;
}
      

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WLIndexSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[WLIndexSelectCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    WLAccuIndexModel *model = self.dataArray[indexPath.row];
    [cell configWithModel:model first:self.selectFirst second:self.selectTwo];
    
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WLAccuIndexModel *model = self.dataArray[indexPath.row];
    
    if (model.selectType   ) {
        if (1 == model.selectType) {
            self.selectFirst = -100;
        } else {
            self.selectTwo = -100;
        }
    } else{
        if (-100 == self.selectFirst) {
            self.selectFirst = model.ID;
        }else if ( -100 == self.selectTwo) {
            self.selectTwo = model.ID;
        }
    }
    
    [self.tableView reloadData];
    
    
    
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.userdefaults  setInteger:self.selectFirst forKey:AppgroupIndiciesSelect1Key];
    [self.userdefaults  setInteger:self.selectTwo forKey:AppgroupIndiciesSelect2Key];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:AppgroupIndiciesChangedKey object:nil];
    
    
    
    
    
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
