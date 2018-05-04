//
//  SSMSearchNoResultCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/18.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMSearchNoResultCell.h"

@implementation SSMSearchNoResultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.backgroundView = nil;
        
        //初始化子视图
        [self setUpSubViews];
        
    }
    return self;
}

//初始化子视图
- (void)setUpSubViews{
    //1.
    _bjView = [[UIView alloc] initWithFrame:CGRectZero];
    _bjView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [self.contentView addSubview:_bjView];
    //2.
    _tipImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _tipImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_tipImageView];
    //3.
    _tipLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _tipLabel.textColor = [UIColor colorWithHexString:@"#7C8495"];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.font = [UIFont systemFontOfSize:KFloat(12.f)];
    [self.contentView addSubview:_tipLabel];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    _bjView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    CGFloat tioImageViewWidht = 414/2.0 * KWidth_ScaleW;
    CGFloat tioImageViewHeight = 332/2.0 * KWidth_ScaleH;
    _tipImageView.frame = CGRectMake(0, 0, tioImageViewWidht, tioImageViewHeight);
    _tipImageView.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0 - SafeAreaTopHeight);
    _tipImageView.image = [UIImage imageNamed:@"SSMSearchNoResultIcon"];
    
    _tipLabel.frame = CGRectMake(0, _tipImageView.bottom + 41.7/2.0 * KWidth_ScaleH, self.frame.size.width, 24/2.0 * KWidth_ScaleH);
    _tipLabel.text = @"没有搜索到相关信息";
}

@end
