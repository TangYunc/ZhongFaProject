//
//  MineLastSectionCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/7.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "MineLastSectionCell.h"

@implementation MineLastSectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.backgroundView = nil;
        //初始化子视图
        [self initSubviews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NoLogin) name:@"NoLogin" object:nil];
    }
    return self;
}
//初始化子视图
- (void)initSubviews{
    //    退出按钮
    _exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _exitBtn.frame = CGRectMake(0, 0, 340*KWidth_ScaleW, 35*KWidth_ScaleH);
    _exitBtn.backgroundColor = [UIColor whiteColor];
    [_exitBtn setTitle:@"退出" forState:UIControlStateNormal];
    [_exitBtn setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    _exitBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _exitBtn.titleLabel.text = @"退出";
    _exitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    
    [_exitBtn addTarget:self action:@selector(exitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_exitBtn];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    if ([KUserDefault objectForKey:@"token"]) {
        
        _exitBtn.hidden = NO;
    }else{
        _exitBtn.hidden = YES;
    }
}

#pragma mark -- 按钮事件
- (void)exitBtnClick{
    
    NSLog(@"退出当前账号");
    
    //    [self.navigationController popToRootViewControllerAnimated:YES];
    //移除UserDefaults中存储的用户信息
    [KUserDefault removeObjectForKey:@"uid"];
    [KUserDefault removeObjectForKey:@"token"];
    [KUserDefault removeObjectForKey:@"uname"];
    [KUserDefault removeObjectForKey:@"contacts"];
    [KUserDefault removeObjectForKey:@"mobile"];
    [KUserDefault synchronize];
    
    NSLog(@"%@",[KUserDefault objectForKey:@"token"]);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOut" object:nil];
    _exitBtn.hidden = YES;
}

#pragma mark -- 通知
- (void)NoLogin{
    
    _exitBtn.hidden = YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
