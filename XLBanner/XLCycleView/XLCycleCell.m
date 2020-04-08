//
//  XLCycleCell.m
//  XLBanner
//
//  Created by 路 on 2017/8/1.
//  Copyright © 2017年 键盘上的行者. All rights reserved.
//

#import "XLCycleCell.h"

@interface XLCycleCell ()
@end

@implementation XLCycleCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self.contentView addSubview:self.cycleImageView];
        [self.contentView addSubview:self.cycleTitleLabel];
    }
    return self;
}

-(UIImageView *)cycleImageView
{
    if (!_cycleImageView) {
        _cycleImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    }
    return _cycleImageView;
}

-(UILabel *)cycleTitleLabel
{
    if (!_cycleTitleLabel) {
        _cycleTitleLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _cycleTitleLabel.backgroundColor = [UIColor whiteColor];
    }
    return _cycleTitleLabel;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}
@end
