

//
//  SSMFiltrateTabelView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/16.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMFiltrateTabelView.h"
#import "SSMFiltrateCell.h"

@interface SSMFiltrateTabelView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSIndexPath *theIndexPath;
@property (nonatomic, assign) CGFloat cellHeight;

@end

@implementation SSMFiltrateTabelView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = UIColorFromRGBA(245, 245, 245, 1.0);
        
    }
    return self;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.section == 0) {
//
//    }else if (indexPath.section == 1){
//
//    }else if (indexPath.section == 2){
//
//    }else{
//
//    }
    static NSString *identifier = @"SSMFiltrateCellId";
    SSMFiltrateCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SSMFiltrateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.datas = @[@"通信电子",@"通信电子,通信电子,通信电子,通信电子,通信电子",@"通信",@"通信电sdfgSGDFSGSDG子",@"通信电子"];
    cell.block = ^(CGFloat cellHeight) {
        self.cellHeight = cellHeight;
        
    };
    return cell;
}

// 单元格高度的设置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0;
    cellHeight = 175;
    return cellHeight;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CGFloat titleViewHeight = 80/2.0 * KWidth_ScaleH;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, titleViewHeight)];
    titleView.backgroundColor = UIColorFromRGBA(245, 245, 245, 1.0);
    
    UIView *topGapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20/2.0 * KWidth_ScaleH)];
    topGapView.backgroundColor = UIColorFromRGBA(245, 245, 245, 1.0);
    [titleView addSubview:topGapView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, topGapView.bottom, 100, 40)];
    titleLabel.textColor = [UIColor colorWithHexString:@"#1C1C1C"];
    titleLabel.font = [UIFont systemFontOfSize:KFloat(16)];
    [titleView addSubview:titleLabel];
    
    
    UIView *gapLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 53.5, kScreenWidth, 0.5)];
    gapLineView.backgroundColor = UIColorFromRGBA(245, 245, 245, 1.0);
    [titleView addSubview:gapLineView];
    
    titleView.tag = 100 + section;
    titleView.userInteractionEnabled = YES;
    
    NSArray *sectionTitleArr = @[@"全部分类",@"智能控制",@"工业软件",@"智能制造装备",@"3D打印",];
    titleLabel.text = sectionTitleArr[section];
    return titleView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 54;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.theIndexPath = indexPath;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //先将未到时间执行前的任务取消。
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(todoSomething:) object:cell];
    [self performSelector:@selector(todoSomething:)withObject:cell afterDelay:0.2f];
    
}



- (void)todoSomething:(id)sender
{
    
}

@end
