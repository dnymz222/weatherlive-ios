//
//  WLXunquanColumnCell.m
//  Weather-live
//
//  Created by xueping on 2019/5/28.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLXunquanColumnCell.h"
#import "Masonry.h"
#import "colorSizeMacro.h"
#import "WLXunquanColumnModel.h"
#import "WLXunquanCloumnItemCell.h"



@interface WLXunquanColumnCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,weak)UICollectionView *collectionView;

@property(nonatomic,assign)CGSize itemSize;

@property(nonatomic,copy)NSArray *itemList;



@end

static NSString *const WXPCITEMVIEWIDENTIFIER = @"WXPITEMVIEWIDENTIFIER";

@implementation WLXunquanColumnCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc] init];
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:layout];
        [self.contentView addSubview:collectionView];
        _collectionView = collectionView;
        _collectionView.delegate =  self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = NO;
        
        
        [_collectionView registerClass:[WLXunquanCloumnItemCell class] forCellWithReuseIdentifier:WXPCITEMVIEWIDENTIFIER ];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.contentView);
        }];
        
        
        
        
        
        CGFloat itemWidth =  kScreenWidth/4;
        
        
        self.itemSize = CGSizeMake(itemWidth, itemWidth+10);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }

    return self;
}

- (void)configItemList:(NSArray *)itemList {
    _itemList = itemList;

    
    NSInteger colCount = itemList.count > 4?5:4;
    
    CGFloat itemWidth =  kScreenWidth/colCount;
    
    
    self.itemSize = CGSizeMake(itemWidth, itemWidth+10);
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        [_collectionView reloadData];
    });
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return  self.itemList.count;
    
}


- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    WLXunquanCloumnItemCell *itemview =[collectionView dequeueReusableCellWithReuseIdentifier:WXPCITEMVIEWIDENTIFIER  forIndexPath:indexPath];
    WLXunquanColumnModel *model = self.itemList[indexPath.row];
    [itemview   configColumn:model];
    
    return itemview;
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
    
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
    return  self.itemSize;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
  
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(WLXunquanColumnCellDidSelectIndex:)]) {
        [self.delegate WLXunquanColumnCellDidSelectIndex:indexPath.row];
    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
