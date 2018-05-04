//
//  SSMFiltrateCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/16.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMFiltrateCell.h"
#import "SSMTableResult.h"

@interface SSMFiltrateCell ()

@property (nonatomic, assign) CGFloat filtrateTextBtnMaxX;
@property (strong, nonatomic) NSLayoutConstraint *filtrateHeight;
@property (nonatomic, strong) NSNumber *choiceCategoryNum;

@end

@implementation SSMFiltrateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.choiceCategoryNum = @0;
        self.backgroundColor = [UIColor whiteColor];
        self.backgroundView = nil;
        
        //初始化子视图
        [self setUpSubViews];
        
    }
    return self;
}

//初始化子视图
- (void)setUpSubViews{
    //1.
    _bjView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_bjView];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    _bjView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    for (UIView *subView in _bjView.subviews) {
        [subView removeFromSuperview];
    }
    self.filtrateTextBtnMaxX = 0;
    CGFloat filtrateItemTextBtnFromLeft = 30/2.0 * KWidth_ScaleH;
    CGFloat filtrateItemTextBtnFromTop = 30/2.0 * KWidth_ScaleH;
    CGFloat filtrateItemGapWithOther = 15/2.0 * KWidth_ScaleW;
    if (self.datas.count != 0) {
       
        
        
        int rows = 0;

        NSInteger itemTag = 0;
        for (NSInteger i = 0; i < self.datas.count; i ++) {
            
            NSString *filtrateTitleStr;
            if ([self.reuseIdentifier isEqualToString:@"SSMFiltrateCellLocationId"]) {
                filtrateTitleStr = self.datas[i];
                itemTag = 0;
            }else if ([self.reuseIdentifier isEqualToString:@"SSMFiltrateCellBrandId"]){
                SSMTableBrand *tableBrand = self.datas[i];
                filtrateTitleStr = tableBrand.name;
                itemTag = [tableBrand.tableBrandId integerValue];
            }
            CGSize filtrateItemSize = [self sizeWithText:filtrateTitleStr font:[UIFont systemFontOfSize:KFloat(14.f)] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            UIButton *filtrateItemTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            filtrateItemTextBtn.backgroundColor = [UIColor whiteColor];
            CGFloat filtrateTextBtnX = self.filtrateTextBtnMaxX + filtrateItemTextBtnFromLeft;
            CGFloat filtrateTextBtnY = 0;
            CGFloat filtrateTextBtnW = filtrateItemSize.width + 30;
            CGFloat filtrateTextBtnH = 30;
            if ((filtrateTextBtnX + filtrateTextBtnW) > (kScreenWidth - filtrateItemTextBtnFromLeft * 2) ) {
                self.filtrateTextBtnMaxX = 0;
                filtrateTextBtnX = self.filtrateTextBtnMaxX + filtrateItemTextBtnFromLeft;
                rows = rows + 1;
            }
            filtrateTextBtnY = filtrateItemTextBtnFromTop + (30 + filtrateItemGapWithOther) * rows;
            self.filtrateHeight.constant = (rows + 1) * 30 + rows * filtrateItemGapWithOther;
            filtrateItemTextBtn.frame = CGRectMake(filtrateTextBtnX, filtrateTextBtnY, filtrateTextBtnW, filtrateTextBtnH);
            filtrateItemTextBtn.clipsToBounds = YES;
            filtrateItemTextBtn.enabled = YES;
            filtrateItemTextBtn.layer.cornerRadius = 3;
            filtrateItemTextBtn.layer.borderWidth = 0.5;
            filtrateItemTextBtn.layer.borderColor = [UIColor colorWithHexString:@"#4A4A4A"].CGColor;
            filtrateItemTextBtn.titleLabel.font = [UIFont systemFontOfSize:KFloat(14.f)];
            [filtrateItemTextBtn setTitleColor:[UIColor colorWithHexString:@"#4A4A4A"] forState:UIControlStateNormal];
            [filtrateItemTextBtn setTitleColor:[UIColor colorWithHexString:@"#31B3EF"] forState:UIControlStateSelected];
            filtrateItemTextBtn.tag = 10 + itemTag + i;
            [filtrateItemTextBtn addTarget:self action:@selector(filtrateResultClicked:) forControlEvents:UIControlEventTouchUpInside];
            [filtrateItemTextBtn setTitle:filtrateTitleStr forState:UIControlStateNormal];
            self.filtrateTextBtnMaxX = CGRectGetMaxX(filtrateItemTextBtn.frame);
            [_bjView addSubview: filtrateItemTextBtn];
            
        }
        CGFloat lastBtnGapFrombottom = 35/2.0 * KWidth_ScaleH;
        UIButton *lastBtn = (UIButton *)[_bjView viewWithTag: (self.datas.count+10+itemTag - 1)];
        CGFloat cellHeight = lastBtn.bottom + lastBtnGapFrombottom;
        NSLog(@"");
        [SSMFiltrateCellResult shareService].cellHeight = cellHeight;
    
    }else {
        self.filtrateHeight.constant = 0;
    }
    
    
}

#pragma mark -- 按钮事件
-(void)filtrateResultClicked:(UIButton *)btn
{
    btn.selected = !btn.selected;
    NSString *locationCityStr;
    NSString *brandID;
    if ([self.reuseIdentifier isEqualToString:@"SSMFiltrateCellLocationId"]) {
        if (btn.selected) {
            btn.layer.borderColor = [UIColor colorWithHexString:@"#31B3EF"].CGColor;
            locationCityStr = btn.currentTitle;
            self.choiceCategoryNum = [NSNumber numberWithDouble:[self.choiceCategoryNum intValue] + 1];
        }else{
            btn.layer.borderColor = [UIColor colorWithHexString:@"#4A4A4A"].CGColor;
            locationCityStr = @"";
            self.choiceCategoryNum = [NSNumber numberWithDouble:[self.choiceCategoryNum intValue] - 1];
        }
        [SSMFiltrateCellResult shareService].location = locationCityStr;
    }else if ([self.reuseIdentifier isEqualToString:@"SSMFiltrateCellBrandId"]){
        if (btn.selected) {
            btn.layer.borderColor = [UIColor colorWithHexString:@"#31B3EF"].CGColor;
            brandID = [NSString stringWithFormat:@"%ld",btn.tag - 10];
            self.choiceCategoryNum = [NSNumber numberWithDouble:[self.choiceCategoryNum intValue] + 1];
        }else{
            btn.layer.borderColor = [UIColor colorWithHexString:@"#4A4A4A"].CGColor;
            brandID = @"";
            self.choiceCategoryNum = [NSNumber numberWithDouble:[self.choiceCategoryNum intValue] - 1];
        }
        [SSMFiltrateCellResult shareService].brandId = brandID;
    }
    
    if ([self.choiceCategoryNum intValue] > 1) {
        btn.layer.borderColor = [UIColor colorWithHexString:@"#4A4A4A"].CGColor;
        self.choiceCategoryNum = [NSNumber numberWithDouble:[self.choiceCategoryNum intValue] - 1];
        btn.enabled = NO;
        [MBProgressHUD showError:@"最多只能选一个哦!"];
        return;
    }
}

#pragma mark -- method
// 计算文字尺寸
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
