//
//  SSMTableViewCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/16.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMTableViewCell.h"

@implementation SSMTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        self.backgroundColor = [UIColor whiteColor];
        //初始化子视图
        [self setUpSubViews];
        
    }
    return self;
}

- (void)setUpSubViews{
    
    //商品图片
    _goodsImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    _goodsImageView.clipsToBounds = YES;
    [self.contentView addSubview:_goodsImageView];
    
    //商品标题
    _goodsNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _goodsNameLabel.numberOfLines = 2;
    _goodsNameLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    _goodsNameLabel.textAlignment = NSTextAlignmentLeft;
    _goodsNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _goodsNameLabel.font = [UIFont systemFontOfSize:KFloat(16.f)];
    [self.contentView addSubview:_goodsNameLabel];
    
    //价格
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _priceLabel.textColor = [UIColor colorWithHexString:@"#F35833"];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    _priceLabel.font = [UIFont systemFontOfSize:KFloat(18.f)];
    [self.contentView addSubview:_priceLabel];
    
    
    _gapLineView = [[UIView alloc] initWithFrame:CGRectZero];
    _gapLineView.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
    [self.contentView addSubview:_gapLineView];
    //公司
    _companyNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _companyNameLabel.textColor = [UIColor colorWithHexString:@"#666666 "];
    _companyNameLabel.textAlignment = NSTextAlignmentLeft;
    _companyNameLabel.font = [UIFont systemFontOfSize:KFloat(12.f)];
    [self.contentView addSubview:_companyNameLabel];
    
    //5.商品出货位置Label
    _locationLabel = [[UILabel alloc] init];
    _locationLabel.textAlignment = NSTextAlignmentLeft;
    _locationLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    _locationLabel.font = [UIFont systemFontOfSize:11.f];
    [self.contentView addSubview:_locationLabel];
    //6.商品出货位置视图
    _locationImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _locationImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_locationImageView];

    _bottomGapLineView = [[UIView alloc] initWithFrame:CGRectZero];
    _bottomGapLineView.backgroundColor = UIColorFromRGBA(245, 245, 245, 1.0);
    [self.contentView addSubview:_bottomGapLineView];
    
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat imageHeight = 160/2.0 * KWidth_ScaleW;
    CGFloat fromLeftGapDistance = 30/2.0 * KWidth_ScaleW;
    CGFloat fromTopGapDistance = 30/2.0 * KWidth_ScaleW;
    //1.
    _goodsImageView.frame = CGRectMake(fromLeftGapDistance, fromTopGapDistance, imageHeight, imageHeight);
    NSString *goodImageUrlStr = @"";
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodImageUrlStr] placeholderImage:[UIImage imageNamed:@"DefaultMediumIcon"] options:SDWebImageRefreshCached];
    //2.
    NSString *goodsNameStr = @"ZA28-12.5全新现货滚丝机各种型号滚丝机滚轧机";
    CGFloat goodsNameLabelGapFromLeft = 28/2.0 * KWidth_ScaleW;
    CGFloat goodsNameLabelWidth = kScreenWidth - _goodsImageView.right - (28 + 53)/2.0 *  KWidth_ScaleW;
    CGSize goodsNameLblWidthSize = [_goodsNameLabel sizeThatFits:CGSizeMake(goodsNameLabelWidth,MAXFLOAT)];
    _goodsNameLabel.frame = CGRectMake(_goodsImageView.right + goodsNameLabelGapFromLeft,_goodsImageView.top, goodsNameLabelWidth, goodsNameLblWidthSize.height);
    _goodsNameLabel.text = goodsNameStr;
    [_goodsNameLabel sizeToFit];
    //3.
    NSString *goodsPriceStr = @"6,2000.00";
    if (goodsPriceStr == nil || goodsPriceStr == Nil) {
        goodsPriceStr = @"";
    }
    CGFloat goodsPriceLabelHeight = 50/2.0 * KWidth_ScaleH;
    CGFloat goodsPriceLabelGapFromTop = 8/2.0 * KWidth_ScaleH;
    NSString *profitStr = [NSString stringWithFormat:@"¥%@",goodsPriceStr];
    CGSize goodsPriceLblWidthSize = [_priceLabel sizeThatFits:CGSizeMake(MAXFLOAT,goodsPriceLabelHeight)];
    _priceLabel.frame = CGRectMake(_goodsNameLabel.left, _goodsNameLabel.bottom + goodsPriceLabelGapFromTop, goodsPriceLblWidthSize.width, goodsPriceLabelHeight);
    _priceLabel.text = profitStr;
    [_priceLabel sizeToFit];
    //4.
    _gapLineView.frame = CGRectMake(_goodsNameLabel.left, 0, _goodsNameLabel.width, 0.5);
    _gapLineView.bottom = _goodsImageView.bottom;
    //5.
    NSString *companyNameeStr = @"北京南士电子科技有限公司";
    CGFloat companyNameLabelGapFromTop = 26/2.0 * KWidth_ScaleW;
    CGFloat companyNameLabelHeight = 33 * KWidth_ScaleW;
    CGSize companyNameLblWidthSize = [_companyNameLabel sizeThatFits:CGSizeMake(MAXFLOAT,companyNameLabelHeight)];
    _companyNameLabel.frame = CGRectMake(_goodsNameLabel.left,_gapLineView.bottom + companyNameLabelGapFromTop, companyNameLblWidthSize.width, companyNameLabelHeight);
    _companyNameLabel.text = companyNameeStr;
    [_companyNameLabel sizeToFit];
    
    //6.
    NSString *locationStr = @"北京";
    CGFloat locationLabelGapFromRight = 41/2.0 * KWidth_ScaleW;
    CGFloat locationLabelHeight = 33/2.0 * KWidth_ScaleH;
    CGSize locationLblWidthSize = [_locationLabel sizeThatFits:CGSizeMake(MAXFLOAT,locationLabelHeight)];
    _locationLabel.frame = CGRectMake(0,0, locationLblWidthSize.width, locationLabelHeight);
    _locationLabel.centerY = _companyNameLabel.centerY;
    _locationLabel.text = locationStr;
    [_locationLabel sizeToFit];
    _locationLabel.right = self.frame.size.width - locationLabelGapFromRight;
    //7.
    CGFloat locationImgWidth = 22.4/2.0 * KWidth_ScaleW;
    CGFloat locationImgHeight = 28.9/2.0 * KWidth_ScaleH;
    CGFloat locationImgGapFromRight = 7.6/2.0 * KWidth_ScaleW;
    _locationImageView.frame = CGRectMake(0, 0, locationImgWidth, locationImgHeight);
    _locationImageView.bottom = _locationLabel.bottom;
    _locationImageView.right = _locationLabel.left - locationImgGapFromRight;
    _locationImageView.image = [UIImage imageNamed:@"NewHomePageLocationIcon"];
    //8.
    _bottomGapLineView.frame = CGRectMake(0, self.frame.size.height - 0.5, kScreenWidth, 0.5);
    
}

#pragma mark -- 按钮事件


@end
