//
//  SSMFiltratePriceCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/17.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMFiltratePriceCell.h"

@interface SSMFiltratePriceCell ()<UITextFieldDelegate>

@end

@implementation SSMFiltratePriceCell

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
    _minValueTF = [[UITextField alloc] initWithFrame:CGRectZero];
    _minValueTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _minValueTF.font = [UIFont systemFontOfSize:KFloat(14.f)];
    _minValueTF.textColor = [UIColor colorWithHexString:@"#999999"];
    _minValueTF.textAlignment = NSTextAlignmentCenter;
    [_minValueTF setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
    _minValueTF.borderStyle = UITextBorderStyleRoundedRect;
    _minValueTF.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
//    _minValueTF.delegate = self;
    [self.contentView addSubview:_minValueTF];
    
    _gapView = [[UIView alloc] initWithFrame:CGRectZero];
    _gapView.backgroundColor = [UIColor colorWithHexString:@"#4A4A4A"];
    [self.contentView addSubview:_gapView];
    
    _maxValueTF = [[UITextField alloc] initWithFrame:CGRectZero];
    _maxValueTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _maxValueTF.font = [UIFont systemFontOfSize:KFloat(14.f)];
    _maxValueTF.textColor = [UIColor colorWithHexString:@"#999999"];
    _maxValueTF.textAlignment = NSTextAlignmentCenter;
    [_maxValueTF setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
    _maxValueTF.borderStyle = UITextBorderStyleRoundedRect;
    _maxValueTF.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
//    _maxValueTF.delegate = self;
    [self.contentView addSubview:_maxValueTF];
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    _bottomView.backgroundColor = UIColorFromRGBA(245, 245, 245, 2.0);
    [self.contentView addSubview:_bottomView];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    //1.
    CGFloat minValueTFWidth = 220/2.0 * KWidth_ScaleW;
    CGFloat minValueTFHeight = 60/2.0 * KWidth_ScaleW;
    CGFloat minValueTFGapFromLeft = 30/2.0 * KWidth_ScaleW;
    CGFloat minValueTFGapFromTop = (self.frame.size.height - 21/2.0 * KWidth_ScaleH - minValueTFHeight) / 2.0;
    _minValueTF.frame = CGRectMake(minValueTFGapFromLeft, minValueTFGapFromTop, minValueTFWidth, minValueTFHeight);
    //2.
    CGFloat gapViewGapFromLeft = 15/2.0 * KWidth_ScaleW;
    _gapView.frame = CGRectMake(_minValueTF.right + gapViewGapFromLeft, 0, 16/2.0 * KWidth_ScaleW, 1);
    _gapView.centerY = _minValueTF.centerY;
    //3.
    _maxValueTF.frame = CGRectMake(_gapView.right + gapViewGapFromLeft, _minValueTF.top, _minValueTF.width, _minValueTF.height);
    //4.
    CGFloat bottomViewHeight = 21/2.0 * KWidth_ScaleH;
    _bottomView.frame = CGRectMake(0, self.frame.size.height - bottomViewHeight, kScreenWidth, bottomViewHeight);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_minValueTF resignFirstResponder];
    [_maxValueTF resignFirstResponder];
}

@end
