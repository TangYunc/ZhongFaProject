//
//  CustomTabBar.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//
/*
 - (void)loadClassifyPopViewDate{
 
 //获取与接口约定的Token
 NSString *url = [NSString stringWithFormat:@"%@%@",BaseTwoApi,HomePageGetClassify_API];
 NSString *apiToken = [KUserDefault objectForKey:APIToken];
 if (apiToken == nil) {
 return;
 }
 NSMutableDictionary *tempPara = [NSMutableDictionary dictionary];
 [tempPara setObject:apiToken forKey:@"access-token"];
 
 [TNetworking postWithUrl:url params:tempPara success:^(id response) {
 [NewHomePageClassifyDatas mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
 return @{
 @"classifyId" : @"id"
 };
 }];
 NewHomePageClassifyResult *result = [NewHomePageClassifyResult mj_objectWithKeyValues:response];
 if (result.success) {
 self.classifyResultArr = [NSArray array];
 self.classifyResultArr = result.data.datas;
 }
 } fail:^(NSError *error) {
 
 } showHUD:NO];
 }
 
 */
#import "CustomTabBar.h"
#import "CustomBarButton.h"

@interface CustomTabBar ()<UIAlertViewDelegate>

// 发布需求按钮
@property (nonatomic, weak) UIButton *plusBtn;
@property (nonatomic, weak) UILabel *plusLabel;
@property (nonatomic, strong) NSMutableArray *tabBarButtons;
@property (nonatomic, weak) CustomBarButton *currentSelectedBtn;
@property (nonatomic, assign) NSInteger btnTag;         // 点击的是tabbar的哪一个按钮

@end

@implementation CustomTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置背景
        [self setupBg];
        // 2.添加发布需求按钮
        [self setupPlusBtn];
    }
    return self;
}

-(void)setupBg
{
    //设置TabBar的backgroundColor
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbarBg"]];
    
    
}
/** 添加发布需求按钮 */
-(void)setupPlusBtn
{
    // 1.创建按钮
    UIButton *plusBtn = [[UIButton alloc] init];
    
    // 2.设置背景图片
    [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbarAddBtn"] forState:UIControlStateNormal];
    [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbarAddBtn"] forState:UIControlStateHighlighted];
    
    // 监听点击事件
    [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 4.添加
    [self addSubview:plusBtn];
    self.plusBtn = plusBtn;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textColor = UIColorFromRGBA(146, 146, 146, 1.0);
    label.font = [UIFont systemFontOfSize:10.0];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(plusBtnClick)];
    [label addGestureRecognizer:tap];
    self.plusLabel = label;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置选项卡的frame
    [self setupTabBarBtnFrame];
    // 2.设置发布需求按钮的frame
    [self setupPlusBtnFrame];
}

/** 设置发布需求按钮的frame */
-(void)setupPlusBtnFrame
{
    /*
     // 1.设置加号按钮frame
     // 1.1设置加号按钮的位置
     CGFloat plusBtnX = self.frame.size.width * 0.5;
     CGFloat plusBtnY = self.frame.size.height * 0.5;
     CGPoint tempCenter = CGPointMake(plusBtnX, plusBtnY);
     self.plusBtn.center = tempCenter;
     
     // 1.2设置加号按钮的宽高
     CGSize currentSize = self.plusBtn.currentBackgroundImage.size;
     CGFloat plusBtnW = currentSize.width;
     CGFloat plusBtnH = currentSize.height;
     self.plusBtn.bounds = CGRectMake(plusBtnX, plusBtnY, plusBtnW, plusBtnH);
     */
    // 自定义了一个UIView分类，解化代码
    // 1.设置加号按钮frame
    // 1.1设置加号按钮的宽高
    CGSize currentSize = self.plusBtn.currentBackgroundImage.size;
    self.plusBtn.width = currentSize.width;
    self.plusBtn.height = currentSize.height;
    
    // 1.2设置加号按钮的位置
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.2;
    
    self.plusLabel.frame = CGRectMake(0, self.plusBtn.bottom + 2, currentSize.width, 10);
    self.plusLabel.centerX = self.plusBtn.centerX;
    self.plusLabel.text = @"发布需求";
    
    
}
-(void)setupTabBarBtnFrame
{
    NSUInteger count = self.tabBarButtons.count;
    CGFloat btnWidth = self.width / (count + 1);
//    CGFloat btnWidth = self.width / count;
    CGFloat btnHeight = self.height;
    for (int i = 0; i < count; i ++) {
        // 1.取出对应的按钮
        UIButton *btn = self.tabBarButtons[i];
        // 2.设算frame
        CGFloat btnW = btnWidth;
        CGFloat btnH = btnHeight;
        CGFloat btnY = 0;
        CGFloat btnX = i * btnW;
        if (i >= count / 2) {
                btnX = (i + 1) * btnW;
            }
        
        // 3.设置frame
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(btnWidth * 2.5 + 10, 0, 14, 14)];
    view.clipsToBounds = YES;
    view.layer.cornerRadius = 7;
    view.userInteractionEnabled = NO;
    self.tabBarView = view;
    [self addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 14, 10)];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14.0];
    label.textAlignment = NSTextAlignmentCenter;
    self.tabBarLabel = label;
    [view addSubview:label];
    
}
-(void)addTabBarButton:(UITabBarItem *)item
{
    // 1.创建按钮
    CustomBarButton *tabBarButton = [[CustomBarButton alloc] init];
    
    // 2.设置item
    tabBarButton.item = item;
    
    // 添加tag
    tabBarButton.tag = self.tabBarButtons.count;
    
    // 添加按钮的监听事件
    [tabBarButton addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchDown];
    
    
    // 3.添加选项卡到自定义的tabBar上
    [self addSubview:tabBarButton];
    
    // 4.添加当前的按钮到数组中
    [self.tabBarButtons addObject:tabBarButton];
    
    
    // 5.判断是否是第一个按钮
    if (self.tabBarButtons.count == 1) {
        // 第一个按钮
        [self btnOnClick:tabBarButton];
    }
    
    
    
}

#pragma mark -- 按钮事件
-(void)btnOnClick:(CustomBarButton *)btn;
{
    self.btnTag = btn.tag;
    if (self.btnTag == 0) {
        NSLog(@"点击首页控制器");
    }else if (self.btnTag == 1){
        NSLog(@"点击咨询控制器");
    }else if (self.btnTag == 2){
        NSLog(@"点击采购料单控制器");
    }else{
        NSLog(@"点击我的控制器");
    }
    
    // 0.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:from:to:)]) {
        [self.delegate tabBar:self from:self.currentSelectedBtn.tag to:btn.tag];
    }
    
    // 1.取消选中上一次选中的按钮
    self.currentSelectedBtn.selected = NO;
    
    // 2.选中当前的按钮
    btn.selected = YES;
    
    // 3.记录当前选中的按钮
    self.currentSelectedBtn = btn;
}

-(void)plusBtnClick
{
    NSLog(@"plusBtnClick");
    
    // 是在首页点击了“+”
    if (self.btnTag == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    }else if (self.btnTag == 1) {   // 是在我的页面点击的“+”
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            NSLog(@"点击了取消，不做处理");
            break;
            
        case 1:
            NSLog(@"点击了确定,通知代理");
            // 通知代理
            if ([self.delegate respondsToSelector:@selector(tabBarPresentViewController:)]) {
                [self.delegate tabBarPresentViewController:self];
            }
            break;
        default:
            break;
    }
}




#pragma mark - tabBarButtons的懒加载
-(NSMutableArray *)tabBarButtons
{
    if (!_tabBarButtons) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}


// 手动调用tabBar按钮点击
-(void)selectTabItem:(NSInteger)index{
    CustomBarButton *btn= _tabBarButtons[index];
    [self btnOnClick:btn];
}

//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.plusBtn];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.plusBtn pointInside:newP withEvent:event]) {
            return self.plusBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}

@end
