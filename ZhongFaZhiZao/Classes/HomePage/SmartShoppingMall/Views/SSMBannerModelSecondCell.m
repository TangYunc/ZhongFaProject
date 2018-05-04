//
//  SSMBannerModelSecondCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/14.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMBannerModelSecondCell.h"
#import "NewHomePageCollectionSectionHeaderView.h"
#import "SSMBannerModelSecondView.h"

@interface SSMBannerModelSecondCell ()
{
    UIView *_pictureView;
    UIView *_gapView;
    NewHomePageCollectionSectionHeaderView *_headerView;
}

@end

@implementation SSMBannerModelSecondCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.backgroundView = nil;
        //初始化子视图
        [self setUpSubViews];
        
    }
    return self;
}

//初始化子视图
- (void)setUpSubViews{
    
    _headerView = [[NewHomePageCollectionSectionHeaderView alloc] initWithFrame:CGRectZero];
    _headerView.userInteractionEnabled = YES;
    [_headerView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerViewClick)]];
    [self.contentView addSubview:_headerView];
    
    _pictureView = [[UIView alloc] initWithFrame:CGRectZero];
    _pictureView.backgroundColor = self.backgroundColor;
    [self.contentView addSubview:_pictureView];
    //间隙视图
    _gapView = [[UIView alloc] initWithFrame:CGRectZero];
    _gapView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_gapView];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    _headerView.frame = CGRectMake(0, 0, kScreenWidth, 80/2.0 * KWidth_ScaleH);
    _headerView.sectionType = @"SSMBannerModelCell";
    _headerView.title = @"源头好货";
    
    CGFloat gapWidth = 24/2.0 * KWidth_ScaleW;
    CGFloat viewGapWidth = 18/2.0 * KWidth_ScaleW;
    CGFloat itemWidth = (kScreenWidth - gapWidth * 2 - viewGapWidth) / 2.0;
    CGFloat itemHeight = 216/2.0 * KWidth_ScaleH;
//    NSArray *imageArr = self.dataList.item;
    NSMutableArray *images = [NSMutableArray array];
//    for (GWMarketSpecialBannerDataListItem *dataListItem in imageArr) {
//        [images addObject:dataListItem.image];
//    }
    NSArray *tempImageArr = images;
//    NSInteger temptCount = tempImageArr.count;
    NSInteger temptCount = 4;
    CGFloat collectionHeight = 0;
    if (temptCount == 2){
        collectionHeight = itemHeight;
    }else if (temptCount > 2){
        collectionHeight = itemHeight * 2 + viewGapWidth;
    }
    for (UIView *subView in _pictureView.subviews) {
        [subView removeFromSuperview];
    }
    _pictureView.frame = CGRectMake(gapWidth, _headerView.bottom, self.width - gapWidth * 2, collectionHeight) ;
    NSArray *itemBJImageArr = @[@"SSMBannerModelSecondCellPictureOne",@"SSMBannerModelSecondCellPictureTwo",@"SSMBannerModelSecondCellPictureThree",@"SSMBannerModelSecondCellPictureFour"];
    for (NSInteger i = 0; i < temptCount; i++) {
        SSMBannerModelSecondView *itemImageView = [[SSMBannerModelSecondView alloc] initWithFrame:CGRectMake((i % 2) * (itemWidth + viewGapWidth), (i / 2) * (itemHeight + viewGapWidth), itemWidth, itemHeight)];
        itemImageView.layer.cornerRadius = 5 * KWidth_ScaleW;
        itemImageView.clipsToBounds = YES;
        itemImageView.itemBJImageName = itemBJImageArr[i];
        itemImageView.items = self.theDatas[0];
        itemImageView.tag = 10 + i;
        [_pictureView addSubview:itemImageView];
        itemImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemImageViewTapAction:)];
        [itemImageView addGestureRecognizer:tap];
    }
    CGFloat gapViewHeight = 31/2.0 * KWidth_ScaleH;
    _gapView.frame = CGRectMake(0, self.height - gapViewHeight, self.width, gapViewHeight);
    
}

#pragma mark -- 按钮事件
- (void)itemImageViewTapAction:(UITapGestureRecognizer *)tap{
    
    NSLog(@"点击了第%ld个图片",tap.view.tag);
    SSMDatasGoodProduct *goodsProduct = self.theDatas[tap.view.tag - 10];
//    [self choiceTheImageUrl:goodsProduct.click_link];
    [self choiceTheImageUrl:@"http://wap.cecb2b.com/corp/nicInfo/4993348?corpId=205170"];
    //http://wap.cecb2b.com/corp/nicInfo/4993348?corpId=205170
}

#pragma mark -- 手势
- (void)headerViewClick{
    NSLog(@"源头好货商品详情");
//    [self choiceTheImageUrl:@""];
}

#pragma mark -- method
- (void)choiceTheImageUrl:(NSString *)url{
    WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@",url] title:@"商品详情"];
    
    [self.viewControler.navigationController pushViewController:vc animated:YES];
}
@end
