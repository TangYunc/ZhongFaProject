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
    NSString *url;
    if ([self.title isEqualToString:@"评估评价"]) {
        url = AssessmentReview_API;
    }else if ([self.title isEqualToString:@"专利申请"]){
        url = PatentApplication_API;
    }else if ([self.title isEqualToString:@"商标注册"]){
        url = TrademarkRegistration_API;
    }else if ([self.title isEqualToString:@"项目申报"]){
        url = ProjectApplication_API;
    }else if ([self.title isEqualToString:@"高新认定"]){
        url = HighRecognition_API;
    }
    [self pushToWKWebViewCtrlUrl:url withTitle:self.title];
}

#pragma mark -- method
- (void)pushToWKWebViewCtrlUrl:(NSString *)urlStr withTitle:(NSString *)title{
    
    WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:urlStr title:title];
    [self.viewControler.navigationController pushViewController:vc animated:YES];
}
@end
