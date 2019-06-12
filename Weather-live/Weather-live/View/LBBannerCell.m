//
//  LBBannerCell.m
//  lamabiji
//
//  Created by xueping on 2018/11/13.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "LBBannerCell.h"
#import "TYCyclePagerView.h"
#import "LBImagItemCell.h"
#import "TYPageControl.h"
#import "Masonry.h"
#import "ColorSizeMacro.h"


@interface LBBannerCell ()<TYCyclePagerViewDelegate,TYCyclePagerViewDataSource>

@property(nonatomic,strong)TYCyclePagerView *pageContentView;
@property(nonatomic,copy)NSArray *imageArray;

@property(nonatomic,strong)TYPageControl *pageControl;

@property(nonatomic,assign)CGFloat itemWidth;

@end


@implementation LBBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.itemWidth = [UIScreen mainScreen].bounds.size.width;
        
        [self.contentView addSubview:self.pageContentView];
        
        [self.pageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.contentView);
        }];
        
        [self addPageControl];
        
        
    }
    
    return self;
}

- (TYCyclePagerView *)pageContentView {
    
    if (!_pageContentView) {
        
        TYCyclePagerView *pagerView = [[TYCyclePagerView alloc]init];
        //        pagerView.layer.borderWidth = 1;
        pagerView.isInfiniteLoop = YES;
//        pagerView.autoScrollInterval = 3.0;
        
        pagerView.dataSource = self;
        pagerView.delegate = self;
        // registerClass or registerNib
        [pagerView registerClass:[LBImagItemCell class] forCellWithReuseIdentifier:@"item"];
        _pageContentView  = pagerView;
        
        
    }
    
    return _pageContentView;
}

- (void)addPageControl {
    TYPageControl *pageControl = [[TYPageControl alloc]init];
    //pageControl.numberOfPages = _datas.count;
    pageControl.currentPageIndicatorSize = CGSizeMake(4, 4);
    pageControl.pageIndicatorSize = CGSizeMake(4, 4);
    pageControl.currentPageIndicatorTintColor = UIColorFromRGB(0xfc4b36);
    pageControl.pageIndicatorTintColor = UIColorFromRGB(0xcccccc);
    //    pageControl.pageIndicatorImage = [UIImage imageNamed:@"Dot"];
    //    pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"DotSelected"];
    //    pageControl.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    //    pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //    pageControl.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //    [pageControl addTarget:self action:@selector(pageControlValueChangeAction:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:pageControl];
    _pageControl = pageControl;
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-8);
        make.height.equalTo(@12);
        make.width.equalTo(@200);
    }];
}



- (void)configImageArray:(NSArray *)imageArray {
    
    _imageArray = imageArray;
    [self.pageContentView reloadData];
    
    self.pageControl.numberOfPages = imageArray.count;
    
    if (imageArray.count  > 1) {
        self.pageContentView.autoScrollInterval = 3;
    }
    
}


- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.imageArray.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    LBImagItemCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"item" forIndex:index];
    
    NSString *image = self.imageArray[index];
    if (![image hasPrefix:@"http"]) {
        image = [@"https:" stringByAppendingString:image];
    }
    [cell configWithImage:image];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(self.itemWidth, self.itemWidth*180.0/440.0);
    layout.itemSpacing = 0;
    //layout.minimumAlpha = 0.3;
    layout.itemHorizontalCenter = YES;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
    //    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index {
    
    if (_delegate && [_delegate respondsToSelector:@selector(lbBannerCellClickImageAtIndex:)]) {
        [_delegate lbBannerCellClickImageAtIndex:index];
    }
}

@end
