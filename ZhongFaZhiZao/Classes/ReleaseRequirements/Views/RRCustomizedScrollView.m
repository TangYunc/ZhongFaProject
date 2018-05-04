//
//  RRCustomizedScrollView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/12.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "RRCustomizedScrollView.h"
#import "RRPropertyEditSubview.h"
#import "RRCustomSubview.h"
#import "RRTextViewEditSubview.h"


@interface RRCustomizedScrollView ()<UITextFieldDelegate>
{
    RRCustomSubview *_rrCustomSubview;
    RRTextViewEditSubview *_textViewEditSubview;
}

@end

@implementation RRCustomizedScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化UI
        [self initUI];
        //监听当前控制器关闭的时候关闭键盘
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeRRViewController) name:@"closeRRViewController" object:nil];
        
    }
    return self;
}
//初始化UI
- (void)initUI{
    
    WS(weakSelf);
    NSArray *titleArr = @[@"项目所处阶段",@"项目需求类型",@"项目需求子类型",@"请选择您的行业"];
    NSInteger tempCount = titleArr.count;
    CGFloat propertyEditViewHeight = 99/2.0 * KWidth_ScaleH;
    for (NSInteger i = 0; i < tempCount; i++) {
        
        RRPropertyEditSubview *propertyEditView = [[RRPropertyEditSubview alloc] initWithFrame:CGRectMake(0, i * propertyEditViewHeight, kScreenWidth, propertyEditViewHeight)];
        propertyEditView.block = ^{
            [weakSelf endEditing:YES];
        };
        propertyEditView.tag = 10 + i;
        propertyEditView.titleStr = titleArr[i];
        [self addSubview:propertyEditView];
    }
    //2.
    RRPropertyEditSubview *lastView = (RRPropertyEditSubview *)[self viewWithTag:13];
    CGFloat textBJViewHeight = 377.5/2.0 * KWidth_ScaleH;
    _textViewEditSubview = [[RRTextViewEditSubview alloc] initWithFrame:CGRectMake(0, lastView.bottom, kScreenWidth, textBJViewHeight)];
    _textViewEditSubview.discribStr = @"请描述您的需求";
    _textViewEditSubview.placeholderStr = @"具体描述您的需求，方便我们能更快更好的为您服务";
    [self addSubview:_textViewEditSubview];
    
    CGFloat rrCustomSubviewHeight = kScreenHeight - 784/2.0 * KWidth_ScaleH;
    CGFloat rrCustomSubviewGapFromTop = 20/2.0 * KWidth_ScaleH;
    _rrCustomSubview = [[RRCustomSubview alloc] initWithFrame:CGRectMake(0, _textViewEditSubview.bottom + rrCustomSubviewGapFromTop, kScreenWidth, rrCustomSubviewHeight)];
    [self addSubview:_rrCustomSubview];
}

#pragma mark -- 手势
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

#pragma mark -- 通知
- (void)closeRRViewController{
    
    [self endEditing:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
