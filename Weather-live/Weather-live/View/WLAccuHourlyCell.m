//
//  WLAccuHourlyCell.m
//  Weather-live
//
//  Created by xueping on 2019/5/22.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLAccuHourlyCell.h"
#import "WLAcuuHourlyItemCell.h"
#import "WLAccuHourlyModel.h"
#import "Masonry.h"
#import "WLColor.h"


@interface WLAccuHourlyCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>



@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,copy)NSArray *hourArray;


@end

@implementation WLAccuHourlyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        [self.contentView addSubview:self.collectionView];
//        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.bottom.equalTo(self.contentView);
//            make.width.equalTo(@(80*12));
//        }];
        
        [self.contentView addSubview:self.scrollView];
        [self.scrollView addSubview:self.collectionView];
        
        
        
    }
    
    return self;
    
}


- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.backgroundColor = [WLColor viewColor];
        _collectionView.scrollEnabled   = NO;
        [_collectionView registerClass:[WLAcuuHourlyItemCell class] forCellWithReuseIdentifier:@"cell"];
        
//        _collectionView.contentSize = CGSizeMake(80*12, 100);
        
//       self.collectionView.showsHorizontalScrollIndicator = YES;
        
        
        
    }
    
    return _collectionView;
    
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
//        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.backgroundColor = [WLColor viewColor];
    }
    
    return _scrollView;
    
}

- (void)configHourArray:(NSArray *)hourArray {
    
    self.hourArray = hourArray;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGFloat height = self.frame.size.height;
        
        self.scrollView.contentSize = CGSizeMake(hourArray.count*80, height);
         self.collectionView.frame = CGRectMake(0, 0, hourArray.count*80, height);
        [self.collectionView reloadData];
    });
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.hourArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(80, 100);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    WLAcuuHourlyItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    
    WLAccuHourlyModel *model  = self.hourArray[indexPath.row];
    
    [cell configHourlyModel:model];
    
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width  =self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.scrollView.frame = CGRectMake(0, 0, width, height);
    self.scrollView.contentSize = CGSizeMake(24*80, height);
    self.collectionView.frame = CGRectMake(0, 0, 24*80, height);
}


//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//
//    return self.scrollView;
//}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
