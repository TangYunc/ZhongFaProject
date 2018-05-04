//
//  MineTableView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/2.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "MineTableView.h"
#import "MineFirstSectionCell.h"
#import "MineSecondSectionCell.h"
#import "MineLastSectionCell.h"
#import "AccountAndPWLoginViewController.h"
#import "UMengShareViewController.h"

//typedef void (^runloopBlock)(void);
@interface MineTableView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *dataLists;
@property (nonatomic, strong) NSIndexPath *theIndexPath;
//@property (nonatomic, strong) NSMutableArray *tasks;
@end

@implementation MineTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableFooterView = [[UIView alloc] init];
        //初始化子视图
        self.backgroundColor = [UIColor colorWithRed:245/250.0 green:245/250.0 blue:245/250.0 alpha:1];
        self.backgroundView=nil;
        self.delegate = self;
        self.dataSource = self;
        self.dataLists = @[
  @{@"image":[UIImage imageNamed:@"MineAccountSecurityIcon"],@"title":@"账户安全"},
  @{@"image":[UIImage imageNamed:@"MineReceivingAdressManagementIcon"],@"title":@"收货地址管理"},
  @{@"image":[UIImage imageNamed:@"MineShareIcon"],@"title":@"分享好友"}
  ];
        //        _tasks = NSMutableArray.array;
//        [self addRunLoopOberserver];l
    }
    return self;
}

#pragma mark -UITableViewDataSource delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([KUserDefault objectForKey:@"token"]) {
        
        return 3;
    }else{
        return 2;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.dataLists.count;
    }else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![KUserDefault objectForKey:@"token"]) {
        if (indexPath.section == 0) {
            
            static NSString *identifier = @"MineFirstSectionCellId";
            MineFirstSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[MineFirstSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.theOrderCount = self.theOrderCount;
            return cell;
        }else{
            static NSString *identifier = @"MineSecondSectionCellId";
            MineSecondSectionCell *theCell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!theCell) {
                theCell = [[MineSecondSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            UIImageView *cellAssistantIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 15)];
            cellAssistantIcon.image = [UIImage imageNamed:@"MineAuxiliaryIcon"];
            theCell.accessoryView = cellAssistantIcon;
            theCell.theDic = self.dataLists[indexPath.row];
            
            return theCell;
        }
        
    }else{
        if (indexPath.section == 0) {
            
            static NSString *identifier = @"MineFirstSectionCellId";
            MineFirstSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[MineFirstSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.theOrderCount = self.theOrderCount;
            return cell;
        }else if(indexPath.section == 1){
            static NSString *identifier = @"MineSecondSectionCellId";
            MineSecondSectionCell *theCell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!theCell) {
                theCell = [[MineSecondSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            UIImageView *cellAssistantIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 15)];
            cellAssistantIcon.image = [UIImage imageNamed:@"MineAuxiliaryIcon"];
            theCell.accessoryView = cellAssistantIcon;
            theCell.theDic = self.dataLists[indexPath.row];
            
            return theCell;
        }else{
            static NSString *identifier = @"MineLastSectionCellId";
            MineLastSectionCell *theCell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!theCell) {
                theCell = [[MineLastSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            return theCell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.theIndexPath = indexPath;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //先将未到时间执行前的任务取消。
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(todoSomething:) object:cell];
    [self performSelector:@selector(todoSomething:)withObject:cell afterDelay:0.2f];
    
}
- (void)todoSomething:(id)sender
{
    NSLog(@"点击了单元格");
    if (self.theIndexPath.section == 1) {
        if (self.theIndexPath.row == 0) {
            //账户安全
            [self accountSecurity];
        }else if (self.theIndexPath.row == 1){
            //收货地址管理
            [self receivingAdressManagement];
        }else {
            //分享好友
            [self share];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        //   我的订单
        UIView *orderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 41)];
        orderView.backgroundColor = [UIColor whiteColor];
        orderView.userInteractionEnabled = YES;
        
        UIImageView *orderImg = [[UIImageView alloc]initWithFrame:CGRectMake(20*KWidth_ScaleW, (41-17)/2.0, 17, 17)];
        orderImg.image = [UIImage imageNamed:@"MineMyOrderIcon"];
        [orderView addSubview:orderImg];
        
        UILabel *orderLbl = [[UILabel alloc]initWithFrame:CGRectMake(9+CGRectGetMaxX(orderImg.frame), 20/2.0, 66, 21)];
        orderLbl.text = @"我的订单";
        orderLbl.font = [UIFont systemFontOfSize:16.0];
        [orderView addSubview:orderLbl];
        
        UIImageView *JTImg = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-15*KWidth_ScaleW-8, (41-15)/2.0, 8, 15)];
        JTImg.image = [UIImage imageNamed:@"MineAuxiliaryIcon"];
        [orderView addSubview:JTImg];
        
        UILabel *JTlabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-15*KWidth_ScaleW-8-10*KWidth_ScaleW-80, (41-17)/2.0, 80, 17)];
        JTlabel.text = @"查看全部订单";
        JTlabel.textAlignment = NSTextAlignmentRight;
        JTlabel.font = [UIFont systemFontOfSize:13.0];
        JTlabel.textColor = TEXT_GREY_COLOR;
        [orderView addSubview:JTlabel];
        
        UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        orderBtn.frame = orderView.frame;
        
        [orderBtn addTarget:self action:@selector(orderBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [orderView addSubview:orderBtn];
        return orderView;
    }else{
        return [[UIView alloc] init];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat heightForHeaderInSection = 0;
    if (section == 0) {
        heightForHeaderInSection = 41;
    }else{
        heightForHeaderInSection = 0;
    }
    return heightForHeaderInSection;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat cellHeight = 0;
    if (indexPath.section == 0) {
        cellHeight = 72 + 10;
    }else{
        cellHeight = 41;
    }
    return cellHeight;
}

#pragma mark -- 按钮事件
- (void)orderBtnClick{
    
    if (![KUserDefault objectForKey:@"token"]) {
        
        AccountAndPWLoginViewController *vc = [[AccountAndPWLoginViewController alloc]init];
        [self.viewControler.navigationController pushViewController:vc animated:YES];
        
    }else{
        WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@%@",BaseApi,MineMyOrder_api] title:@"我的订单"];
        [self.viewControler.navigationController pushViewController:vc animated:YES];
    }
}

- (void)receivingAdressManagement{
    
    if (![KUserDefault objectForKey:@"token"]) {
        
        AccountAndPWLoginViewController *vc = [[AccountAndPWLoginViewController alloc]init];
        [self.viewControler.navigationController pushViewController:vc animated:YES];
        
    }else{
        WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@%@",BaseApi,MineReceivingAdressManagement_api] title:@"收货地址"];
        [self.viewControler.navigationController pushViewController:vc animated:YES];
    }
}

- (void)accountSecurity{
    
    if (![KUserDefault objectForKey:@"token"]) {
        
        AccountAndPWLoginViewController *vc = [[AccountAndPWLoginViewController alloc]init];
        [self.viewControler.navigationController pushViewController:vc animated:YES];
    }else{
        
        WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@%@",BaseApi,MineAccountSecurity_api] title:@"账号安全"];
        [self.viewControler.navigationController pushViewController:vc animated:YES];
        NSLog(@"期待");
    }
}

- (void)share{
    
    UMengShareViewController *vc = [[UMengShareViewController alloc]init];
    [self.viewControler.navigationController pushViewController:vc animated:YES];
}
/*
- (void)addTask:(runloopBlock)task{
    
    [self.tasks addObject:task];
    if (self.tasks.count > 18 ) {
        [self.tasks removeObjectAtIndex:0];
    }
}

- (void)addRunLoopOberserver{
    //获取当前runloop
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    
    //定义上下文
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)self,
        &CFRetain,
        &CFRelease,
        NULL
    };
    //创建观察者
    CFRunLoopObserverRef observerRef = CFRunLoopObserverCreate(NULL, kCFRunLoopBeforeWaiting, YES, 0, &callback, &context);
    //添加观察者
    CFRunLoopAddObserver(runloop, observerRef, kCFRunLoopDefaultMode);
    //释放
    CFRelease(observerRef);
}

void callback (CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    MineTableView *mineTableView = (__bridge MineTableView *)info;
    if (mineTableView.tasks.count == 0) {
        return;
    }
     runloopBlock block = mineTableView.tasks.firstObject;
    block();
    [mineTableView.tasks removeObjectAtIndex:0];
}
*/

@end
