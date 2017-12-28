//
//  XLCycleView.h
//  XLBanner
//
//  Created by 路 on 2017/7/27.
//  Copyright © 2017年 键盘上的行者. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XLCycleView;
@protocol XLCycleViewDelegate <NSObject>

/**
 点击某个图片
 
 @param cycleView XLCycleView的标识符
 @param index 第几个
 */
-(void)cycleView:(XLCycleView *)cycleView didSelectItemAtIndex:(NSInteger)index;

@end


@interface XLCycleView : UIView
@property (copy, nonatomic) void(^DidChangeCycleViewItem)(NSInteger index);
@property (nonatomic, strong) NSArray *imageUrlArray; //轮播的图片数组
@property (nonatomic, strong) NSArray *titleArray;    //文字数组
@property (nonatomic, assign) BOOL isText;            //是否是文字轮播  YES：是  NO：不是
@property (nonatomic, assign) id <XLCycleViewDelegate>delegate;

@end



