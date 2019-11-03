//
//  WLIndexSubViewController.m
//  Weather-live
//
//  Created by xueping on 2019/5/23.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLIndexSubViewController.h"
#import "WLAccuIndexDetailCell.h"
#import "Masonry.h"
#import "WLAccuFooterReusableView.h"

@interface WLIndexSubViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WLAccuFooterReusableViewDelegate>

@property(nonatomic,copy)NSArray *dataArray;


@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,assign)CGFloat screenwidth;



@end

@implementation WLIndexSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenwidth  = [UIScreen mainScreen].bounds.size.width;
    [self.view addSubview:self.collectionView];
    CGFloat bottom = [ [UIDevice currentDevice].systemVersion floatValue] < 11 ? -49:0;
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(bottom);
    }];
    // Do any additional setup after loading the view.
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_collectionView registerClass:[WLAccuIndexDetailCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[WLAccuFooterReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter  withReuseIdentifier:@"footer"];
    }
    
    return _collectionView;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((self.screenwidth-2)/2,114 );
    
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    return CGSizeZero;
//}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return CGSizeZero;
//}



- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WLAccuIndexDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    WLAccuIndexModel *model = self.dataArray[indexPath.row];
    [cell configIndexModel:model];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    if (self.dataArray && self.dataArray.count) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        return CGSizeMake(width, 40);
    } else {
        return CGSizeZero;
    }
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
      
        return nil;
        
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        
        if (self.dataArray && self.dataArray.count) {
            WLAccuFooterReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
            view.delegate = self;
            return view;
        } else {
            return nil;
        }
        
    }
    
    return nil;
 
}

- (void)AcuuWeatherFooterViewClickButtonLink {
    

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.accuweather.com"]];
}

- (void)configDataArray:(NSArray *)dataArray {
    
    self.dataArray = dataArray;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
    
    
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
