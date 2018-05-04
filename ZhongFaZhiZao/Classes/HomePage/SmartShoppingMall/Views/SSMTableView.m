//
//  SSMTableView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/14.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMTableView.h"
#import "SSMCarouselCell.h"
#import "SSMBannerModelFirstCell.h"
#import "SSMBannerModelSecondCell.h"
#import "SSMSecondSectionCell.h"

@interface SSMTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSIndexPath *theIndexPath;
@property (nonatomic, copy) NSString *cellType;
@end

@implementation SSMTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = UIColorFromRGBA(245, 245, 245, 1.0);
        self.cellType = @"SSMBannerModelFirstCell";
    }
    return self;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else if (section == 1){
        if ([self.cellType isEqualToString:@"SSMBannerModelFirstCell"]) {
            return 1;
        }else{
            return 1;
        }
    }else{
        return 2;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *identifier = @"SSMCarouselCellId";
        SSMCarouselCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[SSMCarouselCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        return cell;
        
    }else if (indexPath.section == 1){
        if ([self.cellType isEqualToString:@"SSMBannerModelFirstCell"]) {
            static NSString *identifier = @"SSMBannerModelFirstCellId";
            SSMBannerModelFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[SSMBannerModelFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            return cell;
        }else{
            static NSString *identifier = @"SSMBannerModelSecondCellId";
            SSMBannerModelSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[SSMBannerModelSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            
            return cell;
        }
        
    }else{
        static NSString *identifier = @"SSMSecondSectionCellID";
        SSMSecondSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[SSMSecondSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        return cell;
    }
}
// 单元格高度的设置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0;
    if (indexPath.section == 0) {
        cellHeight = 371/2.0 * KWidth_ScaleH;
    }else if (indexPath.section == 1){
        if ([self.cellType isEqualToString:@"SSMBannerModelFirstCell"]) {
            cellHeight = (390 + 80 + 20 * 2)/2.0 * KWidth_ScaleH;
        }else{
            cellHeight = 565/2.0 * KWidth_ScaleH;
        }
    }else{
        cellHeight = (530 + 31)/2.0 * KWidth_ScaleH;
    }
    return cellHeight;
    
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
