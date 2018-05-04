//
//  SSMBannerModelFirstCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/14.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMBannerModelFirstCell.h"
#import "NewHomePageCollectionSectionHeaderView.h"
#import "SSMResult.h"

@interface SSMBannerModelFirstCell ()
{
    NewHomePageCollectionSectionHeaderView *_headerView;
    UIImageView *_largeZoneImageView;
    UIImageView *_small1ZoneImageView;
    UIImageView *_small2ZoneImageView;
    UIView *_gapView;
}
@end

@implementation SSMBannerModelFirstCell

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
    
    //1.大图模块
    _largeZoneImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _largeZoneImageView.contentMode = UIViewContentModeScaleAspectFill;
    _largeZoneImageView.layer.cornerRadius = 5 * KWidth_ScaleW;
    _largeZoneImageView.clipsToBounds = YES;
    [self.contentView addSubview:_largeZoneImageView];
    _largeZoneImageView.userInteractionEnabled = YES;
    //2.模块1
    _small1ZoneImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _small1ZoneImageView.contentMode = UIViewContentModeScaleAspectFill;
    _small1ZoneImageView.layer.cornerRadius = 5 * KWidth_ScaleW;
    _small1ZoneImageView.clipsToBounds = YES;
    [self.contentView addSubview:_small1ZoneImageView];
    _small1ZoneImageView.userInteractionEnabled = YES;
    //3.模块2
    _small2ZoneImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _small2ZoneImageView.contentMode = UIViewContentModeScaleAspectFill;

    _small2ZoneImageView.layer.cornerRadius = 5 * KWidth_ScaleW;
    _small2ZoneImageView.clipsToBounds = YES;
    [self.contentView addSubview:_small2ZoneImageView];
    _small2ZoneImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *ladiesZoneImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapAction:)];
    UITapGestureRecognizer *menImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapAction:)];
    UITapGestureRecognizer *babyZoneImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapAction:)];
    [_largeZoneImageView addGestureRecognizer:ladiesZoneImageViewTap];
    [_small1ZoneImageView addGestureRecognizer:menImageViewTap];
    [_small2ZoneImageView addGestureRecognizer:babyZoneImageViewTap];
    //间隙视图
    _gapView = [[UIView alloc] initWithFrame:CGRectZero];
    _gapView.backgroundColor = UIColorFromRGBA(245, 245, 245, 1.0);
    [self.contentView addSubview:_gapView];
    
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    _headerView.frame = CGRectMake(0, 0, kScreenWidth, 80/2.0 * KWidth_ScaleH);
    _headerView.sectionType = @"SSMBannerModelCell";
    _headerView.title = @"实力商家";
    SSMDatasBusiness *businessLarge;
    SSMDatasBusiness *businessSmall1;
    SSMDatasBusiness *businessSmall2;
    if (self.theDatas.count == 3) {
        
        businessLarge = self.theDatas[0];
        businessSmall1 = self.theDatas[1];
        businessSmall2 = self.theDatas[2];
    }else if (self.theDatas.count == 2){
        businessLarge = self.theDatas[0];
        businessSmall1 = self.theDatas[1];
        businessSmall2 = nil;
    }else if (self.theDatas.count == 1){
        businessLarge = self.theDatas[0];
        businessSmall1 = nil;
        businessSmall2 = nil;
    }else if (self.theDatas.count == 0){
        businessLarge = nil;
        businessSmall1 = nil;
        businessSmall2 = nil;
    }
    CGFloat fromLeftGapWidth = 22/2.0 * KWidth_ScaleW;
    CGFloat itemWidth = 339/2.0 * KWidth_ScaleW;
    CGFloat itemHeight = 390/2.0 * KWidth_ScaleH;
    
    _largeZoneImageView.frame = CGRectMake(fromLeftGapWidth, _headerView.bottom, itemWidth, itemHeight);
    [_largeZoneImageView sd_setImageWithURL:[NSURL URLWithString:businessLarge.res_path] placeholderImage:[UIImage imageNamed:@"DefaultLargeIcon"] options:SDWebImageRetryFailed];
    
    CGFloat itemSmallWidth = 355/2.0 * KWidth_ScaleW;
    CGFloat itemSmallHeight = 190/2.0 * KWidth_ScaleH;
    CGFloat small1ZoneImageViewGapfromLeft = 8/2.0 * KWidth_ScaleW;
    _small1ZoneImageView.frame = CGRectMake(_largeZoneImageView.right + small1ZoneImageViewGapfromLeft, _largeZoneImageView.top, itemSmallWidth, itemSmallHeight);
    [_small1ZoneImageView sd_setImageWithURL:[NSURL URLWithString:businessSmall1.res_path] placeholderImage:[UIImage imageNamed:@"DefaultLargeIcon"] options:SDWebImageRetryFailed];
    
    
    _small2ZoneImageView.frame = CGRectMake(_small1ZoneImageView.left, _small1ZoneImageView.bottom + small1ZoneImageViewGapfromLeft, _small1ZoneImageView.width, _small1ZoneImageView.height);
    [_small2ZoneImageView sd_setImageWithURL:[NSURL URLWithString:businessSmall2.res_path] placeholderImage:[UIImage imageNamed:@"DefaultLargeIcon"] options:SDWebImageRetryFailed];
    
    CGFloat gapViewHeight = 20/2.0 * KWidth_ScaleH;
    _gapView.frame = CGRectMake(0, self.height - gapViewHeight, self.width, gapViewHeight);
}

- (void)imageViewTapAction:(UITapGestureRecognizer *)tap{
    
//    NSArray *items;
    NSString *tempDataStr = nil;
    NSString *tempTpyeStr = nil;
    if (tap.view == _largeZoneImageView) {
        NSLog(@"大图模块");
        tempDataStr = @"";
        tempTpyeStr = @"";
    }else if (tap.view == _small1ZoneImageView){
        NSLog(@"模块1");
        tempDataStr = @"";
        tempTpyeStr = @"";
    }else if (tap.view == _small2ZoneImageView){
        NSLog(@"模块2");
        tempDataStr = @"";
        tempTpyeStr = @"";
    }
    if ([tempTpyeStr isEqualToString:@"url"]) {
        //进入webView页面
//        [self goToMarketCarouselWebViewControllerWapUrl:tempDataStr];
    }else if ([tempTpyeStr isEqualToString:@"special"]){
        //调到专题页签去
//        [self goToOtherSpecialId:tempDataStr];
    }
}

#pragma mark -- 手势
- (void)headerViewClick{
    NSLog(@"商品详情");
    [self choiceTheImageUrl:@""];
}

#pragma mark -- method
- (void)choiceTheImageUrl:(NSString *)url{
    WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@",url] title:@"商品详情"];
    
    [self.viewControler.navigationController pushViewController:vc animated:YES];
}

@end
