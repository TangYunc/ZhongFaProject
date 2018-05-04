//
//  SSMClassifyCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/16.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMClassifyCell.h"
#import "SSMTableViewController.h"

@implementation SSMClassifyCell

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
        [self.contentView addSubview:_bjView];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    _bjView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    for (UIView *subView in _bjView.subviews) {
        [subView removeFromSuperview];
    }
    CGFloat gapWidth = 10/2.0 * KWidth_ScaleW;
    CGFloat itemWidth = (kScreenWidth - gapWidth) / 2.0;
    CGFloat itemHeight = 80/2.0 * KWidth_ScaleH;
    
    NSInteger tempCount = self.datas.count;
    for (NSInteger i = 0; i < tempCount; i++) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((i % 2) * (itemWidth + gapWidth), (i / 2) * (itemHeight + gapWidth), itemWidth, itemHeight)];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self setAttributeStringForPriceLabel:titleLabel text:self.datas[i]];
        titleLabel.font = [UIFont systemFontOfSize:KFloat(14)];
        titleLabel.textColor = [UIColor colorWithHexString:@"#1C1C1C"];
        titleLabel.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
        titleLabel.text = self.datas[i];
        [_bjView addSubview:titleLabel];
        titleLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTitleClick:)];
        [titleLabel addGestureRecognizer: tap];
    }

}

#pragma mark -- 手势
- (void)tapTitleClick:(UITapGestureRecognizer *)tap{
    NSLog(@"点击了%ld",tap.view.tag);
    SSMTableViewController *tableVC = [[SSMTableViewController alloc] init];
    [self.viewControler.navigationController pushViewController:tableVC animated:YES];
}

- (void)setAttributeStringForPriceLabel:(UILabel *)label text:(NSString *)text
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString
                                              alloc] initWithString:text];
    NSUInteger length = [text length];
    NSMutableParagraphStyle *
    style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.firstLineHeadIndent = 30/2.0 * KWidth_ScaleW;//设置与前部的距离
//    style.tailIndent = -10; //设置与尾部的距离
    style.alignment = NSTextAlignmentLeft;//靠左显示
    [attrString addAttribute:NSParagraphStyleAttributeName value:style
                       range:NSMakeRange(0, length)];
    label.attributedText = attrString;
}
@end
