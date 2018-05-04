//
//  MineFirstSectionCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/2.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "MineFirstSectionCell.h"
#import "MineOrderCustomBtn.h"
#import "AccountAndPWLoginViewController.h"

@implementation MineFirstSectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.backgroundView = nil;
        //初始化子视图
        [self initSubviews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOut:) name:@"loginOut" object:nil];
    }
    return self;
}
//初始化子视图
- (void)initSubviews{
    
    NSArray *titles = @[@"待付款",@"待发货",@"待收货",@"退款中"];
    NSArray *imageNames = @[@"MineForThePaymentIcon",@"MineToSendTheGoodsIcon",@"MineForTheGoodsIcon",@"MineRefundingIcon"];
    NSInteger temptCount = titles.count;
    CGFloat itemWidth = kScreenWidth / temptCount;
    CGFloat itemHeight = 72 * KWidth_ScaleH;
    for (int i = 0; i < temptCount; i++) {
        MineOrderCustomBtn *customBtn = [[MineOrderCustomBtn alloc] initWithFrame:CGRectMake(i * itemWidth, 0, itemWidth, itemHeight)];
        
        // 设置标题
        [customBtn setTitle:titles[i]];
        // 设置图片
        [customBtn setTitleImage:[UIImage imageNamed:imageNames[i]]];
        // 设置事件
        customBtn.tag =  10 + i;
        customBtn.layer.borderWidth = 0.5;
        customBtn.layer.borderColor = UIColorFromRGBA(245, 245, 245, 1.0).CGColor;
        [customBtn addTarget:self action:@selector(customBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:customBtn];
    }
    
    //    小圆点
    _redLbl1 = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth/4.0-25)/2.0+20, 9*KWidth_ScaleH, 13, 13)];
    _redLbl1.layer.masksToBounds = YES;
    _redLbl1.layer.cornerRadius = 6.5;
    _redLbl1.backgroundColor = RED_COLOR;
    _redLbl1.textColor = [UIColor whiteColor];
    _redLbl1.textAlignment = NSTextAlignmentCenter;
    _redLbl1.font = [UIFont systemFontOfSize:10.0];
    
    if ([KUserDefault objectForKey:@"token"]) {
        
        _redLbl1.hidden = NO;
        
    }else{
        _redLbl1.hidden = YES;
    }
    
    [self.contentView addSubview:_redLbl1];
    
    _redLbl2 = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth/4.0-25)/2.0+20+kScreenWidth/4.0, 9*KWidth_ScaleH, 13, 13)];
    _redLbl2.layer.masksToBounds = YES;
    _redLbl2.layer.cornerRadius = 6.5;
    _redLbl2.backgroundColor = RED_COLOR;
    _redLbl2.textColor = [UIColor whiteColor];
    _redLbl2.textAlignment = NSTextAlignmentCenter;
    _redLbl2.font = [UIFont systemFontOfSize:10.0];
    
    if ([KUserDefault objectForKey:@"token"]) {
        
        _redLbl2.hidden = NO;
        
    }else{
        _redLbl2.hidden = YES;
    }
    [self.contentView addSubview:_redLbl2];
    
    _redLbl3 = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth/4.0-25)/2.0+20+kScreenWidth/4.0*2, 9*KWidth_ScaleH, 13, 13)];
    _redLbl3.layer.masksToBounds = YES;
    _redLbl3.layer.cornerRadius = 6.5;
    _redLbl3.backgroundColor = RED_COLOR;
    _redLbl3.textColor = [UIColor whiteColor];
    _redLbl3.textAlignment = NSTextAlignmentCenter;
    _redLbl3.font = [UIFont systemFontOfSize:10.0];
    if ([KUserDefault objectForKey:@"token"]) {
        
        _redLbl3.hidden = NO;
        
    }else{
        _redLbl3.hidden = YES;
    }
    [self.contentView addSubview:_redLbl3];
    
    _redLbl4 = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth/4.0-25)/2.0+20+kScreenWidth/4.0*3, 9*KWidth_ScaleH, 13, 13)];
    _redLbl4.layer.masksToBounds = YES;
    _redLbl4.layer.cornerRadius = 6.5;
    _redLbl4.backgroundColor = RED_COLOR;
    _redLbl4.textColor = [UIColor whiteColor];
    _redLbl4.textAlignment = NSTextAlignmentCenter;
    _redLbl4.font = [UIFont systemFontOfSize:10.0];
    
    if ([KUserDefault objectForKey:@"token"]) {
        
        _redLbl4.hidden = NO;
        
    }else{
        _redLbl4.hidden = YES;
    }
    [self.contentView addSubview:_redLbl4];
    
    //底部的线
    _bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    _bottomView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.contentView addSubview:_bottomView];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
     if (self.theOrderCount.waitpayCount > 0) {
     
     _redLbl1.hidden = NO;
         _redLbl1.text = [NSString stringWithFormat:@"%ld",(long)self.theOrderCount.waitpayCount];
     
     }else{
         
     _redLbl1.hidden = YES;
     }
    
     if (self.theOrderCount.waitSippingCount > 0) {
     
     _redLbl2.hidden = NO;
         _redLbl2.text = [NSString stringWithFormat:@"%ld",(long)self.theOrderCount.waitSippingCount];
     }else{
     
     _redLbl2.hidden =YES;
     }
    
     if (self.theOrderCount.waitReceiptCount > 0) {
     
     _redLbl3.hidden = NO;
         _redLbl3.text = [NSString stringWithFormat:@"%ld",(long)self.theOrderCount.waitReceiptCount];
     }else{
     
     _redLbl3.hidden = YES;
     }
    
    
     if (self.theOrderCount.refundCount > 0) {
     
     _redLbl4.hidden = NO;
         _redLbl4.text = [NSString stringWithFormat:@"%ld",(long)self.theOrderCount.refundCount];
     }else{
     
     _redLbl4.hidden = YES;
     }
    
    
    
    _bottomView.frame = CGRectMake(0, self.height - 10, self.width, 10);
}

#pragma mark -- 按钮事件
- (void)customBtnAction:(UIButton *)button{
    
    if (![KUserDefault objectForKey:@"token"]) {
        
        AccountAndPWLoginViewController *vc = [[AccountAndPWLoginViewController alloc]init];
        [self.viewControler.navigationController pushViewController:vc animated:YES];
    }else{
        
        if (button.tag == 10) {
            NSLog(@"待付款");
            WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@%@",BaseApi,MineForThePayment_api] title:@"待付款"];
            
            [self.viewControler.navigationController pushViewController:vc animated:YES];
        }else if (button.tag == 11){
            NSLog(@"待发货");
            WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@%@",BaseApi,MineToSendTheGoods_api] title:@"待发货"];
            
            [self.viewControler.navigationController pushViewController:vc animated:YES];
        }else if (button.tag == 12){
            NSLog(@"待收货");
            WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@%@",BaseApi,MineForTheGoods_api] title:@"待收货"];
            
            [self.viewControler.navigationController pushViewController:vc animated:YES];
        }else{
            NSLog(@"退款中");
            WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@%@",BaseApi,MineRefunding_api] title:@"退款中"];
            
            [self.viewControler.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)loginOut:(NSNotification *)notify{
    
        _redLbl1.hidden = YES;
        _redLbl2.hidden = YES;
        _redLbl3.hidden = YES;
        _redLbl4.hidden = YES;
}

- (void)dealloc
{
    // 删除监听认领商品的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"dealloc:MineFirstSectionCell");
}
@end
