//
//  MineHeaderView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "MineHeaderView.h"
#import "MineCustomCollectionBtn.h"
#import "AccountAndPWLoginViewController.h"
#import "MessageCenterViewController.h"

@interface MineHeaderView ()

@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat collectionBJViewHeight;

@end

@implementation MineHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.headerHeight = 240 * KWidth_ScaleH;
        self.collectionBJViewHeight = 41 * KWidth_ScaleH;
        //初始化子视图
        [self initSubViews];
        self.userInteractionEnabled = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOut:) name:@"loginOut" object:nil];
    }
    return self;
}

- (void)initSubViews{
    
    //1.背景视图
    _bjImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.headerHeight)];
    _bjImageView.image = [UIImage imageNamed:@"MineHeaderBJViewIcon"];
    _bjImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_bjImageView];
    _bjImageView.userInteractionEnabled = YES;
    
    //2.头像
    CGFloat iconImgH = 108 * KWidth_ScaleH;
    _headerPortraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-iconImgH) / 2.0 - 1, 55 * KWidth_ScaleH, iconImgH, iconImgH)];
    _headerPortraitImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headerPortraitImageView.layer.cornerRadius = iconImgH / 2.0f;
    _headerPortraitImageView.backgroundColor = [UIColor clearColor];
    _headerPortraitImageView.layer.masksToBounds = YES;
//    _headerPortraitImageView.layer.borderWidth = 1.0f;
//    _headerPortraitImageView.layer.borderColor = [UIColor clearColor].CGColor;
    _headerPortraitImageView.image = [UIImage imageNamed:@"MineHeadportraitIcon"];
    [_bjImageView addSubview:_headerPortraitImageView];
//    _headerPortraitImageView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *headerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTapAction:)];
//    [_headerPortraitImageView addGestureRecognizer:headerTap];
    
    //3.用户名
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(_headerPortraitImageView.frame)+13*KWidth_ScaleH, kScreenWidth-40*2, 21)];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = [UIFont systemFontOfSize:17.f];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [_bjImageView addSubview:_nameLabel];
    
    //    点击登录按钮
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat loginBtnH = 122 * KWidth_ScaleH;
    _loginBtn.frame = CGRectMake((kScreenWidth-loginBtnH)/2.0, CGRectGetMaxY(_headerPortraitImageView.frame)+12*KWidth_ScaleH, loginBtnH, 35*KWidth_ScaleH);
    _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#8682fc"];
    [_loginBtn setTitle:@"点击登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _loginBtn.titleLabel.textColor = [UIColor whiteColor];
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = 15;
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    if ([KUserDefault objectForKey:@"token"]) {
        
        _loginBtn.hidden = YES;
    }else{
        _loginBtn.hidden = NO;
    }
    [_bjImageView addSubview:_loginBtn];
    
    
    //    最多三个标签
    _bqLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 5*KWidth_ScaleH+CGRectGetMaxY(_headerPortraitImageView.frame)+13*KWidth_ScaleH+21, kScreenWidth, 14)];
    _bqLbl.backgroundColor = [UIColor redColor];
    if ([KUserDefault objectForKey:@"token"]) {
        _bqLbl.hidden = NO;
    }else{
        _bqLbl.hidden = YES;
    }
    [_bjImageView addSubview:_bqLbl];
    
    
    _bqlbl1 = [[UIImageView alloc]init];
    //    _bqLbl.backgroundColor = [UIColor orangeColor];
    if ([KUserDefault objectForKey:@"token"]) {
        _bqlbl1.hidden = NO;
    }else{
        _bqlbl1.hidden = YES;
    }
    [_bjImageView addSubview:_bqlbl1];
    
    
    _informationBtn = [CustomButton buttonWithType:UIButtonTypeCustom];
    _informationBtn.frame = CGRectMake(_bjImageView.width-15*KWidth_ScaleW-24, 12, 26, 32);
    _informationBtn.imageRect = CGRectMake(4, 0, 18, 14);
    _informationBtn.titleRect = CGRectMake(0, 16, 26, 14);
    [_informationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_informationBtn setTitle:@"消息" forState:UIControlStateNormal];
    _informationBtn.titleLabel.font = [UIFont systemFontOfSize:10.0];
    _informationBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    if ([KUserDefault objectForKey:@"token"]) {
        
        _informationBtn.hidden = NO;
        
    }else{
        _informationBtn.hidden = YES;
    }
    
    [_informationBtn setImage:[UIImage imageNamed:@"MineMessageCenterIcon"] forState:UIControlStateNormal];
    [_informationBtn addTarget:self action:@selector(informationBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_bjImageView addSubview:_informationBtn];
    
    
    //4.所有累计的背景视图
    _collectionBJView = [[UIView alloc] initWithFrame:CGRectMake(0, _bjImageView.bottom, kScreenWidth, self.collectionBJViewHeight)];
    _collectionBJView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionBJView];
    
    NSArray *collectionTitles = @[@"商品收藏",@"店铺收藏"];
    NSArray *collectionImageNames = @[@"MineGoodsCollectionIcon",@"MineShopsCollectionIcon"];
    NSInteger tempCount = collectionTitles.count;
    float buttonWidth = (kScreenWidth - 0.5) / tempCount;
    for (int i = 0; i < tempCount; i++) {
        MineCustomCollectionBtn *customBtn = [[MineCustomCollectionBtn alloc] initWithFrame:CGRectMake(i * (buttonWidth + 0.5), 0, buttonWidth, self.collectionBJViewHeight)];
        // 设置累计标题
        [customBtn setTitle:collectionTitles[i]];
        [customBtn setTitleImage:[UIImage imageNamed:collectionImageNames[i]]];
        // 设置事件
        customBtn.tag =  11 + i;
        [customBtn addTarget:self action:@selector(customBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_collectionBJView addSubview:customBtn];
    }
    
    MineCustomCollectionBtn *goodsCollectionBtn = (MineCustomCollectionBtn *)[self viewWithTag:11];
    
    _gapLine1View = [[UIView alloc] initWithFrame:CGRectMake(goodsCollectionBtn.right, _collectionBJView.bottom, 0.5, _collectionBJView.height)];
    _gapLine1View.backgroundColor = UIColorFromRGBA(238, 238, 238, 1.0);
    [_collectionBJView addSubview:_gapLine1View];
    
    _gapLine2View = [[UIView alloc] initWithFrame:CGRectMake( 0, _collectionBJView.bottom, self.width, 0.5)];
    _gapLine2View.backgroundColor = UIColorFromRGBA(238, 238, 238, 1.0);
    [self addSubview:_gapLine2View];
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake( 0, _gapLine2View.bottom, self.width, 10)];
    _bottomView.backgroundColor = UIColorFromRGBA(238, 238, 238, 1.0);
    [self addSubview:_bottomView];
}

- (void)setPersonalInformation:(MinePersonalInfoDatas *)personalInformation{
    
    if (_personalInformation != personalInformation) {
        _personalInformation = personalInformation;
        
        //2.头像
        [_headerPortraitImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"DefaultIcon"]];
        //3.店名
        _loginBtn.hidden = YES;
        _nameLabel.hidden = NO;
        _informationBtn.hidden = NO;
        _nameLabel.text = self.personalInformation.corpName;
        
        
        NSUInteger flagcount = self.personalInformation.membership.count;
        
        if (flagcount > 0) {
            
            for (NSInteger i = 0; i < flagcount; i++) {
                
                _bqLbl.hidden = NO;
                
                UIImageView *img = [[UIImageView alloc]init];
                img.frame = CGRectMake((kScreenWidth -2*(flagcount-1)-28*flagcount)/2.0+2*i+28*i, 0, 28, 14);
                //                    img.backgroundColor = [UIColor cyanColor];
                //                    img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",response[@"data"][@"membership"][i][@"role_name"]]];
                
                [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://images.cecb2b.com/images/common-service/icon/%@.png", self.personalInformation.membership[i][@"Role_id"]]] placeholderImage:nil];
                
                [_bqLbl addSubview:img];
            }
        }else {
            
            _bqlbl1.hidden = YES;
        }
        //4.所有收藏的背景视图
//        MineCustomCollectionBtn *goodsCollectionBtn = (MineCustomCollectionBtn *)[self viewWithTag:11];
    }
}

#pragma mark -- 按钮事件
- (void)customBtnAction:(MineCustomCollectionBtn *)btn{
    
    if (btn.tag == 11) {
        NSLog(@"点击商品收藏");
        [self mineGoodsCollection];
    }else{
        NSLog(@"点击店铺收藏");
        [self mineShopsCollection];
    }
}

- (void)loginBtnClick{
    NSLog(@"点击登录");
    AccountAndPWLoginViewController *accountAndPWLoginVC = [[AccountAndPWLoginViewController alloc]init];
    [self.viewControler.navigationController pushViewController:accountAndPWLoginVC animated:YES];
}
/*
 - (void)headerTapAction:(UITapGestureRecognizer *)tap{
 
 }
 */

- (void)informationBtn:(UIButton *)button{
    
    MessageCenterViewController *vc = [[MessageCenterViewController alloc]init];
    [self.viewControler.navigationController pushViewController:vc animated:YES];
}
#pragma mark -- 手势事件



#pragma mark -- method

- (void)mineGoodsCollection{
    
    if (![KUserDefault objectForKey:@"token"]) {
        AccountAndPWLoginViewController *vc = [[AccountAndPWLoginViewController alloc]init];
        [self.viewControler.navigationController pushViewController:vc animated:YES];
    }else{
        WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@%@",BaseApi,MineGoodsCollection_api] title:@"我的收藏"];
        [self.viewControler.navigationController pushViewController:vc animated:YES];
    }
}


- (void)mineShopsCollection{
    if (![KUserDefault objectForKey:@"token"]) {
        AccountAndPWLoginViewController *vc = [[AccountAndPWLoginViewController alloc]init];
        [self.viewControler.navigationController pushViewController:vc animated:YES];
    }else{
        WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@%@",BaseApi,MineShopsCollection_api] title:@"我的收藏"];
        [self.viewControler.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 根据颜色生成图片
- (UIImage *)generateImageFromColor:(UIColor *)color{
    
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return colorImage;
}
- (void)viewColorChangeFromCoror:(UIColor *)fromColor toColor:(UIColor *)toColor withTheView:(UIView *)view{
    
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [view.layer addSublayer:gradientLayer];
    
    //设置渐变区域的起始和终止位置（范围为0-1）
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    //设置颜色数组
    gradientLayer.colors = @[(__bridge id)fromColor.CGColor,
                             (__bridge id)toColor.CGColor];
    
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[@(0.4f), @(1.0f)];
}
- (NSString *)getFilePath:(NSString *)plistName{
    
    NSString *plistNameStr = [NSString stringWithFormat:@"%@.plist",plistName];
    /*保存数据一*/
    /*新建一个plist*/
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *newplistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename= [newplistPath stringByAppendingPathComponent:plistNameStr];
    
    return filename;
}

#pragma mark --通知
- (void)loginOut:(NSNotification *)notify{
    
    _loginBtn.hidden = NO;
    _nameLabel.hidden = YES;
    _informationBtn.hidden = YES;
    _bqLbl.hidden = YES;
}
- (void)dealloc
{
    // 删除监听认领商品的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"dealloc:MineHeaderView");
}
@end
