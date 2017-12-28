//
//  ViewController.m
//  XLBanner
//
//  Created by 路 on 2017/7/12.
//  Copyright © 2017年 键盘上的行者. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()<XLCycleViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet XLCycleView *bannerView;
@property (weak, nonatomic) IBOutlet XLCycleView *textView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _bannerView.imageUrlArray = @[@"http://haitaoad.nosdn.127.net/ad.bid.material_958e94ff19d4425fbf8ff675d2d6f29e?param=640y248",@"http://p4.music.126.net/KBGimsi9Oyx10aZZM5_rkA==/18767563976515199.jpg?param=640y248",@"http://p4.music.126.net/DOUERTQqfwX40zHtGsCnWw==/18688399139301883.jpg?param=640y248",@"http://p3.music.126.net/jGi52eDVUxCnMaVy-_bqcQ==/18531168976543961.jpg?param=640y248",@"http://p3.music.126.net/7lvZQAdwUktLAdUSCvWjmA==/18653214767235643.jpg?param=640y248",@"http://p3.music.126.net/nZCNbtXbzn0NieGZniBw9w==/18964376556159465.jpg?param=640y248",@"http://haitaoad.nosdn.127.net/ad.bid.material_48b4f29d4793407ca16f0dd243ca4807?param=640y248",@"http://p4.music.126.net/w0gNUJQmI8vDTXDTsByOgA==/19041342370095071.jpg?param=640y248",@"http://p1.music.126.net/M3YaF1uVBhhX9yw1K3-kvQ==/18984167765277108.jpg?param=210y210"];
    _pageControl.currentPage = 0;
    self.pageControl.numberOfPages = _bannerView.imageUrlArray.count;
    _bannerView.delegate = self;
    
    _bannerView.DidChangeCycleViewItem = ^(NSInteger index) { //通过代理切换pageControl
        _pageControl.currentPage = index;
    };
    
    
    
    
    
    
    _textView.isText = YES;
    _textView.titleArray = @[@"这个是跑马灯的测试，嘿嘿",@"不知道写什么文字，索性就随意写点吧",@"好好学习天天向上",@"没有什么能够阻挡我对生活的向往！！！！",@"行走于键盘之上。。。。。"];
    _textView.delegate = self;
    
    
    NSArray * fontArrays = [[UIFont familyNames] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *str1 = (NSString *)obj1;
        NSString *str2 = (NSString *)obj2;
        return [str1 compare:str2];
    }];
    for(NSString *fontfamilyname in fontArrays)
    {
        NSLog(@"family:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
        {
            NSLog(@"\tfont:'%@'",fontName);
        }
        NSLog(@"-------------");
    }
    

    
}


#pragma mark ---XLCycleViewDelegate
-(void)cycleView:(XLCycleView *)cycleView didSelectItemAtIndex:(NSInteger)index{
    if (cycleView == _bannerView) {
        NSLog(@"点击的是banner轮播的第  %ld个视图",index);
    }else if (cycleView == _textView){
        NSLog(@"点击的是跑马灯轮播的第  %ld个文字",index);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
