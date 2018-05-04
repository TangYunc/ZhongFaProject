//
//  SSMFiltrateCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/16.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMFiltrateCell.h"

@interface SSMFiltrateCell ()

@property (nonatomic, assign) CGFloat filtrateTextBtnMaxX;
@property (strong, nonatomic) NSLayoutConstraint *filtrateHeight;

@end

@implementation SSMFiltrateCell

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
//    self.filtrateTextBtnMaxX = 0;
    CGFloat filtrateItemTextBtnFromLeft = 30/2.0 * KWidth_ScaleH;
    CGFloat filtrateItemTextBtnFromTop = 30/2.0 * KWidth_ScaleH;
    CGFloat filtrateItemGapWithOther = 15/2.0 * KWidth_ScaleW;
    if (self.datas.count != 0) {
        int rows = 0;

        for (int i = 0; i < self.datas.count; i ++) {
            CGSize filtrateItemSize = [self sizeWithText:self.datas[i] font:[UIFont systemFontOfSize:KFloat(14.f)] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            UIButton *filtrateItemTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            filtrateItemTextBtn.backgroundColor = [UIColor whiteColor];
            CGFloat filtrateTextBtnX = self.filtrateTextBtnMaxX + filtrateItemTextBtnFromLeft;
            CGFloat filtrateTextBtnY = 0;
            CGFloat filtrateTextBtnW = filtrateItemSize.width + 30;
            CGFloat filtrateTextBtnH = 30;
            if ((filtrateTextBtnX + filtrateTextBtnW) > (kScreenWidth - filtrateItemTextBtnFromLeft * 2) ) {
                self.filtrateTextBtnMaxX = 0;
                filtrateTextBtnX = self.filtrateTextBtnMaxX + filtrateItemTextBtnFromLeft;
                rows = rows + 1;
            }
            filtrateTextBtnY = filtrateItemTextBtnFromTop + (30 + filtrateItemGapWithOther) * rows;
            self.filtrateHeight.constant = (rows + 1) * 30 + rows * filtrateItemGapWithOther;
            filtrateItemTextBtn.frame = CGRectMake(filtrateTextBtnX, filtrateTextBtnY, filtrateTextBtnW, filtrateTextBtnH);
            filtrateItemTextBtn.clipsToBounds = YES;
            filtrateItemTextBtn.layer.cornerRadius = 3;
            filtrateItemTextBtn.layer.borderWidth = 0.5;
            filtrateItemTextBtn.layer.borderColor = UIColorFromRGBA(153, 153, 153, 1.0).CGColor;
            filtrateItemTextBtn.titleLabel.font = [UIFont systemFontOfSize:KFloat(14.f)];
            [filtrateItemTextBtn setTitleColor:[UIColor colorWithHexString:@"#4A4A4A"] forState:UIControlStateNormal];
            [filtrateItemTextBtn setTitleColor:[UIColor colorWithHexString:@"#31B3EF"] forState:UIControlStateSelected];
            filtrateItemTextBtn.tag = 10 + i;
            [filtrateItemTextBtn addTarget:self action:@selector(filtrateResultClicked:) forControlEvents:UIControlEventTouchUpInside];
            [filtrateItemTextBtn setTitle:self.datas[i] forState:UIControlStateNormal];
            self.filtrateTextBtnMaxX = CGRectGetMaxX(filtrateItemTextBtn.frame);
            [_bjView addSubview: filtrateItemTextBtn];
            
        }
        CGFloat lastBtnGapFrombottom = 35/2.0 * KWidth_ScaleH;
        UIButton *lastBtn = (UIButton *)[_bjView viewWithTag: (self.datas.count+10 - 1)];
        NSLog(@"-------%f",lastBtn.bottom + lastBtnGapFrombottom);
        CGFloat cellHeight = lastBtn.bottom + lastBtnGapFrombottom;
        if (self.block) {
            self.block(cellHeight);
        }
    }else {
        self.filtrateHeight.constant = 0;
    }
    
    
}

#pragma mark -- 按钮事件
-(void)filtrateResultClicked:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

#pragma mark -- 手势
- (void)tapTitleClick:(UITapGestureRecognizer *)tap{
    NSLog(@"点击了%ld",tap.view.tag);
}

#pragma mark -- method
// 计算文字尺寸
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
