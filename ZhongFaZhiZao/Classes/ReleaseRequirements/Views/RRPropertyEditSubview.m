//
//  RRPropertyEditSubview.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/12.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "RRPropertyEditSubview.h"
#import "ScrollPickView.h"
#import "CityPickView.h"
#import "NSString+Mobile.h"
#import "ChooseLocationView.h"

@interface RRPropertyEditSubview ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) ChooseLocationView *chooseLocationView;
@property (nonatomic,strong) UIView  *cover;

@end

@implementation RRPropertyEditSubview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showAuxiliaryIcon = YES;
        self.showScroll = YES;
        self.isClickCoverBtn = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self initSubviews];
    }
    return self;
}

//初始化子视图
- (void)initSubviews{
    
    //名字
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    _titleLabel.font = [UIFont systemFontOfSize:14.f];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    //内容
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _contentLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    _contentLabel.font = [UIFont systemFontOfSize:14.f];
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_contentLabel];
    //辅助视图
    _auxiliaryImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _auxiliaryImageView.clipsToBounds = YES;
    _auxiliaryImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_auxiliaryImageView];
    
    //底部的线
    _bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    _bottomView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [self addSubview:_bottomView];
    
    //coverBtn
    _coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_coverBtn setBackgroundColor:[UIColor clearColor]];
    [_coverBtn addTarget:self action:@selector(coverBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_coverBtn];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(currentViewTapClick:)];
//    [self addGestureRecognizer:tap];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat titleLabelHeight = 40/2.0 * KWidth_ScaleH;
    CGFloat titleLabelGapFromLeft = 32/2.0 * KWidth_ScaleW;
    CGFloat titleLabelGapFromTop = (self.height - titleLabelHeight) / 2.0;
    _titleLabel.frame = CGRectMake(titleLabelGapFromLeft, titleLabelGapFromTop, 130 * KWidth_ScaleW, titleLabelHeight);
    _titleLabel.text = self.titleStr;
    
    _contentLabel.frame = CGRectMake(_titleLabel.right, titleLabelGapFromTop, 130 * KWidth_ScaleW, titleLabelHeight);
    _contentLabel.text = @"";
    
    CGFloat auxiliaryImgWidth = 16/2.0 * KWidth_ScaleW;
    CGFloat auxiliaryImgHeight = 30/2.0 * KWidth_ScaleH;
    CGFloat auxiliaryImgGapFromRight = 30/2.0 * KWidth_ScaleH;
    _auxiliaryImageView.frame = CGRectMake(0, 0, auxiliaryImgWidth, auxiliaryImgHeight);
    _auxiliaryImageView.image = [UIImage imageNamed:@"MineAuxiliaryIcon"];
    _auxiliaryImageView.centerY = _titleLabel.centerY;
    _auxiliaryImageView.right = self.frame.size.width - auxiliaryImgGapFromRight;
    
    CGFloat bottomViewHeight = 3/2.0 * KWidth_ScaleH;
    _bottomView.frame = CGRectMake(0, self.height - bottomViewHeight, self.width, bottomViewHeight);
    
    _coverBtn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (self.isClickCoverBtn) {
        _coverBtn.enabled = YES;
    }else{
        _coverBtn.enabled = NO;
    }
    if (self.showAuxiliaryIcon) {
        _auxiliaryImageView.hidden = NO;
    }else{
        _auxiliaryImageView.hidden = YES;
    }
}


#pragma mark -- 按钮事件
- (void)coverBtnAction:(UIButton *)button{

    NSArray *questionArray = [self.theNameDatas copy];
    if (questionArray.count == 0) {
        return;
    }
    if (self.showScroll) {
        [self setUpPickView:questionArray withDefaultDesc:questionArray[0]];
    }else{
        [self setUpCityPickView];
    }
}

- (void)setUpPickView:(NSArray *)questionArray withDefaultDesc:(NSString *)defaultDesc{
    //滚轮样式的选择器
    ScrollPickView *scrollPickView = [[ScrollPickView alloc] initWithQuestionArray:questionArray withDefaultDesc:defaultDesc];
    [scrollPickView showView];
    WS(weakSelf);
    scrollPickView.confirmBlock = ^(NSInteger selectedQuestion) {
        weakSelf.contentLabel.text = questionArray[selectedQuestion];
        NSInteger tagId = [[weakSelf.theIdDatas copy][selectedQuestion] integerValue];
//        _contentLabel.tag = tagId;
        if (weakSelf.block) {
            weakSelf.block(tagId, questionArray[selectedQuestion]);
        }
    };
}
/*
- (void)setUpCityPickView1{
    //城市样式的选择器
    [CityPickView showPickViewWithComplete:^(NSArray *arr) {
        
        NSString *str = [NSString replaceUnicode:[NSString stringWithFormat:@"%@%@%@",arr[0],arr[1],arr[2]]];
        _contentLabel.text = str;
    } withProvince:nil withCity:nil withTown:nil withThreeScroll:YES];
}
*/
- (void)setUpCityPickView{
    self.cover.hidden = !self.cover.hidden;
    self.chooseLocationView.hidden = self.cover.hidden;
}

- (UIView *)cover{
    
    if (!_cover) {
        _cover = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _cover.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        
        [[UIApplication sharedApplication].keyWindow addSubview:_cover];
        _chooseLocationView = [[ChooseLocationView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 350, [UIScreen mainScreen].bounds.size.width, 350)];
        _chooseLocationView.theProvinceDatas = self.theProvinceDatas;
        [_cover addSubview:_chooseLocationView];
        __weak typeof (self) weakSelf = self;
        _chooseLocationView.chooseFinish = ^{
            
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.contentLabel.text = weakSelf.chooseLocationView.address;
                if (weakSelf.cityBlock) {
                    weakSelf.cityBlock(weakSelf.chooseLocationView.provinceId, weakSelf.chooseLocationView.cityId);
                }
                weakSelf.cover.hidden = YES;
            }];
        };
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCover:)];
        [_cover addGestureRecognizer:tap];
        tap.delegate = self;
        _cover.hidden = YES;
    }
    return _cover;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
    if (CGRectContainsPoint(_chooseLocationView.frame, point)){
        return NO;
    }
    return YES;
}


- (void)tapCover:(UITapGestureRecognizer *)tap{
    
    if (_chooseLocationView.chooseFinish) {
        _chooseLocationView.chooseFinish();
    }
}

@end
