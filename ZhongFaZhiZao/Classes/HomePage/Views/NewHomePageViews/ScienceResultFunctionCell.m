//
//  ScienceResultFunctionCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/8.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "ScienceResultFunctionCell.h"
#import "ScienceResultCustomFounctionBtn.h"

@interface ScienceResultFunctionCell ()
{
    ScienceResultCustomFounctionBtn *_customBtn;
}
@end

@implementation ScienceResultFunctionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor magentaColor];
        [self setUpCell];
    }
    return self;
}

- (void)setUpCell{
    _customBtn = [[ScienceResultCustomFounctionBtn alloc] initWithFrame:CGRectZero];
    // 设置事件
    [_customBtn addTarget:self action:@selector(customBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_customBtn];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _customBtn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    // 设置标题
    [_customBtn setTitle:self.title];
    // 设置图片
    [_customBtn setTitleImage:[UIImage imageNamed:self.titleImage]];
}

- (void)customBtnAction:(ScienceResultCustomFounctionBtn *)btn{
    
    NSLog(@"点击的是%@",self.titleImage);
}
@end
