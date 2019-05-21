//
//  LBDetailImageHeaderView.m
//  lamabiji
//
//  Created by xueping on 2018/10/2.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "FishDetailImageHeaderView.h"
#import "TYCyclePagerView.h"
#import "FishImagItemCell.h"
#import "TYPageControl.h"
#import "Masonry.h"
#import "ColorSizeMacro.h"



@interface FishDetailImageHeaderView ()<TYCyclePagerViewDelegate,TYCyclePagerViewDataSource>

@property(nonatomic,strong)TYCyclePagerView *pageContentView;
@property(nonatomic,copy)NSArray *imageArray;

@property(nonatomic,strong)TYPageControl *pageControl;

@property(nonatomic,assign)CGFloat itemWidth;


@end


static NSString *const FishImageItemCellID = @"FishImageItemCellID";

@implementation FishDetailImageHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
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
        pagerView.isInfiniteLoop = NO;
        pagerView.autoScrollInterval = 3.0;
        pagerView.dataSource = self;
        pagerView.delegate = self;
        // registerClass or registerNib
        [pagerView registerClass:[FishImagItemCell class] forCellWithReuseIdentifier:FishImageItemCellID];
        _pageContentView  = pagerView;
        
        
    }
    
    return _pageContentView;
}

- (void)addPageControl {
    TYPageControl *pageControl = [[TYPageControl alloc]init];
    //pageControl.numberOfPages = _datas.count;
    pageControl.currentPageIndicatorSize = CGSizeMake(12, 4);
    pageControl.pageIndicatorSize = CGSizeMake(12, 4);
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
    
}


- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.imageArray.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    FishImagItemCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:FishImageItemCellID forIndex:index];
    
    NSString *image = self.imageArray[index];
    if (![image containsString:@"http"]) {
        image = [@"https:" stringByAppendingString:image];
    }
    [cell configWithImage:image];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(self.itemWidth, self.itemWidth);
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
