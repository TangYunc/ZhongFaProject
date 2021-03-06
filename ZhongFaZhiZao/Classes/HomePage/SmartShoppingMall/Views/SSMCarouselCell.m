//
//  SSMCarouselCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/14.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMCarouselCell.h"
#import "HomePageImgRunLoopView.h"

@interface SSMCarouselCell ()
{
    HomePageImgRunLoopView *_imgRunView;
    UIView *_brandView;
    UIView *_gapView;
}
/** 图片数组*/
@property (nonatomic,strong) NSMutableArray *imgMarr;

@end
@implementation SSMCarouselCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.backgroundColor = [UIColor clearColor];
//        self.backgroundView = nil;
        //初始化子视图
        [self setUpSubViews];
        
    }
    return self;
}

- (void)setUpSubViews{
    
    CGFloat imgRunViewHeight = 283/2.0 * KWidth_ScaleH;
    _imgRunView = [[HomePageImgRunLoopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, imgRunViewHeight) placeholderImg:[UIImage imageNamed:@"DefaultLargeIcon"]];
    [self.contentView addSubview:_imgRunView];
    //间隙视图
    _brandView = [[UIView alloc] initWithFrame:CGRectZero];
    _brandView.backgroundColor = [UIColor colorWithHexString:@"#EBF9FF"];
    [self.contentView addSubview:_brandView];
    //间隙视图
    _gapView = [[UIView alloc] initWithFrame:CGRectZero];
    _gapView.backgroundColor = UIColorFromRGBA(245, 245, 245, 1.0);
    [self.contentView addSubview:_gapView];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    if (self.datas.count > 0) {
        
        for (SSMDatasBanner *banner in self.datas) {
            [self.imgMarr addObject:banner.res_path];
        }
        _imgRunView.imgUrlArray = self.imgMarr;
        WS(weakSelf);
        [_imgRunView  touchImageIndexBlock:^(NSInteger index) {
            NSLog(@"%ld",(long)index);
            SSMDatasBanner *banner = weakSelf.datas[index];
            [weakSelf choiceTheImageUrl:banner.click_link];
        }];
        
        CGFloat brandViewHeight = 68/2.0 * KWidth_ScaleH;
        _brandView.frame = CGRectMake(0, _imgRunView.bottom, self.width, brandViewHeight);
        NSArray *brandNames = @[@"正品保障",@"资金安全",@"七天退换"];
        NSArray *brandImages = @[@"SSMCarouselFirstBrand",@"SSMCarouselSecondBrand",@"SSMCarouselThirdBrand"];
        CGFloat btnWidth = (96 + 7 + 32)/2.0 * KWidth_ScaleW;
        CGFloat btnHeight = 33/2.0 * KWidth_ScaleH;
        CGFloat btnGapFromLeft = 124/2.0 * KWidth_ScaleW;
        CGFloat btnGapWithOther = 58/2.0 * KWidth_ScaleW;
        CGFloat btnGapFromTop = (_brandView.height - btnHeight) / 2.0;
        NSInteger tempCount = brandNames.count;
        for (NSInteger i = 0; i < tempCount; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(btnGapFromLeft + i * (btnWidth + btnGapWithOther), btnGapFromTop, btnWidth, btnHeight);
            button.tag = 10 + i;
            [button setTitle:brandNames[i] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:brandImages[i]] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:KFloat(12.f)];
            [_brandView addSubview:button];
        }
        
        CGFloat gapViewHeight = 20/2.0 * KWidth_ScaleH;
        _gapView.frame = CGRectMake(0, _brandView.bottom, self.width, gapViewHeight);
    }
}

- (NSMutableArray *)imgMarr{
    if (!_imgMarr) {
        //        NSString *urlStr = @"http://pic.121mai.com/s28_05460157903471942.gif";
        _imgMarr = [NSMutableArray arrayWithCapacity:8];
    }
    return _imgMarr;
}

#pragma mark -- 按钮事件
#pragma mark -- method
- (void)choiceTheImageUrl:(NSString *)url{
    WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@",url] title:@"广告"];
    
    [self.viewControler.navigationController pushViewController:vc animated:YES];
}
@end
