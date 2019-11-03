//
//  WLAddressListViewController.m
//  Weather-live
//
//  Created by xueping on 2019/8/27.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLAddressListViewController.h"
#import "Masonry.h"
#import "STLocationModel.h"
#import "ColorSizeMacro.h"
#import "WLAddLocationFooterView.h"
#import "WLMyDatabaseTool.h"
#import "FishMapSelectPositionViewController.h"



@interface WLAddressListViewController ()<UITableViewDelegate,UITableViewDataSource,WLAddLocationFooterViewDelegate,FishMapSelectPositionViewControllerDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;



@end

@implementation WLAddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"select location", nil);
    
    self.dataArray = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    [self.dataArray addObjectsFromArray:[WLMyDatabaseTool excuteLocationArray]];
    
    
    [self.tableView reloadData];
    
  
    
    // Do any additional setup after loading the view.
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
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}




- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section  {
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15.f];
        cell.textLabel.textColor = UIColorFromRGB(0x666666);
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13.f];
        cell.detailTextLabel.textColor = UIColorFromRGB(0x999999);
        
        
    }
    
    STLocationModel *location =  self.dataArray[indexPath.row];
    cell.textLabel.text = location.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"latitude:%0.2f longtiude:%0.2f",location.location.coordinate.latitude,location.location.coordinate.longitude];
    
    
    
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    WLAddLocationFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (footerView == nil) {
        footerView  = [[WLAddLocationFooterView alloc] initWithReuseIdentifier:@"header"];
        footerView.delegate = self;
    }
    
    return footerView;
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return NSLocalizedString(@"delete", nil);
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
        STLocationModel *location = self.dataArray[indexPath.row];
        [WLMyDatabaseTool removeLocation:location];
        
//        [self.dataArray removeObjectAtIndex:indexPath.row];
       // NSIndexSet *sectionIndex = [NSIndexSet indexSetWithIndex:indexPath.section];
//        [tableView  deselectRowAtIndexPath:indexPath animated:YES];
        
        
        
    }
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    STLocationModel *locationModel = self.dataArray[indexPath.row];
    
    if (self.delegate ) {
        [self.delegate addresslistSelectlocation:locationModel];
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)addbuttonClick {
    
    
    FishMapSelectPositionViewController *mapselectVc = [[FishMapSelectPositionViewController alloc] init];
    mapselectVc.delegate = self;
    
    [self.navigationController pushViewController:mapselectVc animated:YES];
    
}

- (void)mapSelectPositionViewControllerDidSelected:(STLocationModel *)loction {
    
    [WLMyDatabaseTool addlocation:loction];
    
    [self reloadData];
    
    
}


- (void)reloadData {
    
    NSArray *array = [WLMyDatabaseTool excuteLocationArray];
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:array];
    [self.tableView reloadData];
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
