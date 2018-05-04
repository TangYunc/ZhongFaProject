//
//  CounselingViewController.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "CounselingViewController.h"
#import "IMDetailViewController.h"

@interface CounselingViewController ()<RCIMUserInfoDataSource>

@end

@implementation CounselingViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BACK_COLOR;
    
    //    [WKProgressHUD popMessage:@"即时通讯" inView:self.view duration:HUD_DURATION animated:YES];
    
    //    是否显示网络状态
    self.isShowNetworkIndicatorView = NO;
    //    是否显示连接状态
    self.showConnectingStatusOnNavigatorBar = YES;
    //    设置默认的聊天列表类型
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE)]];
    
    //    设置背景颜色
    self.cellBackgroundColor = BACK_COLOR;
    
    //    设置置顶的cell背景颜色
    self.topCellBackgroundColor = TEXT_GREY_COLOR;
    
}

//高度
- (CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
}

#pragma mark - 点击会话列表中的cell回调
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath{
    
    IMDetailViewController *vc = [[IMDetailViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.conversationType = model.conversationType;
    vc.targetId = model.targetId;
    vc.title = model.conversationTitle;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
