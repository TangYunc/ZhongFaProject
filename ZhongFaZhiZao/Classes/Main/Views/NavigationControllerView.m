//
//  NavigationControllerView.m
//  ZhongFaZhiZao
//
//  Created by chenzhiqiang on 2016/12/17.
//  Copyright © 2016年 chenzhiqiang. All rights reserved.
//

#import "NavigationControllerView.h"

@implementation NavigationControllerView
{
    UILabel *_midLabel;
}
- (instancetype)initWithFrame:(CGRect)frame andLeftBtn:(NSString *)title{

    if (self = [super initWithFrame:frame]) {
        
        UIView *navView = [[UIView alloc]initWithFrame:frame];
//        navView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NavBG"]];
        [self addSubview:navView];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, navView.frame.size.width, navView.frame.size.height)];
        imageView.image = [UIImage imageNamed:@"NavBG"];
        imageView.userInteractionEnabled = YES;
        [navView addSubview:imageView];
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0, SafeAreaTopHeight-65/2.0-6, 94/2.0, 65/2.0);
        leftBtn.imageView.frame = leftBtn.bounds;
        leftBtn.hidden = NO;
//        leftBtn.center = CGPointMake(94/2.0/2.0, 44);
//        leftBtn.backgroundColor = [UIColor redColor];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"BackNV"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(leftBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
        [navView addSubview:leftBtn];
        
        _midLabel = [[UILabel alloc]init];
        _midLabel.frame = CGRectMake(0, 0, 180, 24);
        _midLabel.center = CGPointMake(kScreenWidth/2.0, SafeAreaTopHeight - 22);
        _midLabel.text = title;
        _midLabel.textColor = [UIColor whiteColor];
        _midLabel.textAlignment = NSTextAlignmentCenter;
        _midLabel.font = [UIFont systemFontOfSize:18.0];
        [navView addSubview:_midLabel];
        

    }

    return self;
}


- (instancetype)initWithFrame:(CGRect)frame andtitle:(NSString *)title{
    
    if (self = [super initWithFrame:frame]) {
        
        UIView *navView = [[UIView alloc]initWithFrame:frame];
//        navView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NavBG"]];
        [self addSubview:navView];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, navView.frame.size.width, navView.frame.size.height)];
        imageView.image = [UIImage imageNamed:@"NavBG"];
        imageView.userInteractionEnabled = YES;
        [navView addSubview:imageView];

        
        _midLabel = [[UILabel alloc]init];
        _midLabel.frame = CGRectMake(0, 0, 180, 24);
        _midLabel.center = CGPointMake(kScreenWidth/2.0, SafeAreaTopHeight - 22);
        _midLabel.text = title;
        _midLabel.textColor = [UIColor whiteColor];
        _midLabel.textAlignment = NSTextAlignmentCenter;
        _midLabel.font = [UIFont systemFontOfSize:18.0];
        [navView addSubview:_midLabel];
        
    }
    
    return self;
}

- (void)setTitle:(NSString *)title {
    _midLabel.text = title;
}

- (instancetype)initWithFrame:(CGRect)frame andRightBtn:(NSString *)title{

    if (self = [super initWithFrame:frame]) {
        
        UIView *navView = [[UIView alloc]initWithFrame:frame];
//        navView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NavBG"]];
        [self addSubview:navView];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, navView.frame.size.width, navView.frame.size.height)];
        imageView.image = [UIImage imageNamed:@"NavBG"];
        imageView.userInteractionEnabled = YES;
        [navView addSubview:imageView];

        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(kScreenWidth-21-20, 44-21/2.0, 21, 21);
        rightBtn.imageView.frame = rightBtn.bounds;
        rightBtn.hidden = NO;
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"LoginCloseIcon"] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [navView addSubview:rightBtn];
        
        UILabel *midLabel1 = [[UILabel alloc]init];
        midLabel1.frame = CGRectMake(0, 0, 180, 24);
        midLabel1.center = CGPointMake(kScreenWidth/2.0, SafeAreaTopHeight - 22);
        midLabel1.text = title;
        midLabel1.textColor = [UIColor whiteColor];
        midLabel1.textAlignment = NSTextAlignmentCenter;
        midLabel1.font = [UIFont systemFontOfSize:18.0];
        [navView addSubview:midLabel1];
        rightBtn.center = CGPointMake(kScreenWidth-21-20, SafeAreaTopHeight - 22);

    }
    
    return self;
}


#pragma mark - 点击事件
- (void)leftBarButtonItemClick{
    
    
    if (self.viewController) {
        
        [self.viewController.navigationController popViewControllerAnimated:YES];
    }
    
}


- (void)rightButtonClick{

    if (self.viewController) {
        
        [self.viewController.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

@end
