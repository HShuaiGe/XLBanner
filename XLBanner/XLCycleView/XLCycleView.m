//
//  XLCycleView.m
//  XLBanner
//
//  Created by 路 on 2017/7/27.
//  Copyright © 2017年 键盘上的行者. All rights reserved.
//

#import "XLCycleView.h"
#import "XLCycleCell.h"
#import "UIImageView+WebCache.h"

@interface XLCycleView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView   *collectionView;       //轮播 UICollectionView
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIPageControl  *pageControl;              //轮播图上的PageControl
@property (nonatomic, strong) UIButton       *imageViewButton;          //加载轮播的图片
@property (nonatomic, assign) NSInteger      totalPage;                 //轮播总的数量
@property (nonatomic, assign) NSInteger      currentPage;               //当前展示第几个的图片 默认第0个
@property (nonatomic, strong) NSTimer *timer;                           //定时器
@end

@implementation XLCycleView

#pragma mark --- 纯代码加载
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _isText = NO;
        [self initUI];
    }
    return self;
}

#pragma mark --- xib加载
-(void)awakeFromNib{
    [super awakeFromNib];
    [self initUI];
}


#pragma mark --- 布局UI
-(void)initUI{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = self.bounds.size;
    flowLayout.minimumLineSpacing = 0;
    _flowLayout = flowLayout;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //UICollectionView
    _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:_flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerClass:[XLCycleCell class] forCellWithReuseIdentifier:@"XLCycleCell"];
    [self addSubview:_collectionView];
    
    //PageControl
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height - 10);
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.backgroundColor = [UIColor brownColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:self.pageControl];
}


#pragma mark 添加定时器
-(void)addTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}

#pragma mark  --- 定时器跳转下一页
-(void)nextPage{
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:50];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    NSInteger nextItem = currentIndexPathReset.item +1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == _totalPage) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}




#pragma mark 删除定时器
-(void) removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)setImageUrlArray:(NSArray *)imageUrlArray{
    _imageUrlArray = imageUrlArray;
    _totalPage = _imageUrlArray.count;
    _pageControl.numberOfPages = _imageUrlArray.count;
    [_collectionView reloadData];
    [self removeTimer];
    [self addTimer];

}


-(void)setTitleArray:(NSArray *)titleArray{
    if (_titleArray.count <= 0) {
        return;
    }
    _titleArray = titleArray;
    _totalPage = _titleArray.count;
    [_collectionView reloadData];
    [self removeTimer];
    [self addTimer];
}



-(void)setIsText:(BOOL)isText{
    _isText = isText;
    if (_isText) {
        _collectionView.scrollEnabled = NO;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }else{
        _collectionView.scrollEnabled = YES;
    }
    
}

#pragma mark --- UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 100;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  _totalPage;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     XLCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLCycleCell" forIndexPath:indexPath];
    if (_isText) {
        cell.cycleImageView.hidden = YES;
        cell.cycleTitleLabel.hidden = NO;
        cell.cycleTitleLabel.text = _titleArray[indexPath.item];
    }else{
        cell.cycleTitleLabel.hidden = YES;
        cell.cycleImageView.hidden = NO;
       [cell.cycleImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrlArray[indexPath.item]]];
    }
    return cell;
}

#pragma mark --- UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(cycleView:didSelectItemAtIndex:)]) {
        [self.delegate cycleView:self didSelectItemAtIndex:indexPath.item];
    }
}

#pragma mark  --- 开始滑动的时候，移除定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}

#pragma mark 停止滑动的时候，激活定时器
-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
    
}

#pragma mark 设置页码
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page;
    if (_isText ) {
        page = (int) (scrollView.contentOffset.y/scrollView.frame.size.height+0.5)%_totalPage;
        
    }else{
        page = (int) (scrollView.contentOffset.x/scrollView.frame.size.width+0.5)%_totalPage;
    }
    self.pageControl.currentPage = page;

}


@end
