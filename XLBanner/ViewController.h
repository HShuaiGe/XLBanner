//
//  ViewController.h
//  XLBanner
//
//  Created by 路 on 2017/7/12.
//  Copyright © 2017年 键盘上的行者. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLCycleView.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet XLCycleView *bannerView;
@property (weak, nonatomic) IBOutlet XLCycleView *textView;

@end

