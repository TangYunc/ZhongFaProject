//
//  HeaderBJView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/9.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "HeaderBJView.h"
#import "NewHomePageCollectionSectionHeaderView.h"
#import "ClassifyPopView.h"
@interface HeaderBJView ()
{
    UIView *_line;
    CGFloat imageWidth;
}
@property (nonatomic, strong) UIScrollView *headerScrollView;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NewHomePageCollectionSectionHeaderView *headerView;
@end

@implementation HeaderBJView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化子视图
        [self _initSubViews];
        //通知
        //监听点击智造商城滑动视图的状态
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(smartMallScrollIndex:) name:@"smartMallScrollIndex" object:nil];
        
    }
    return self;
}
- (void)_initSubViews{
    
    //1.
    [self setUpSectionHeaderView];
    _titleArr = @[@"智能制造装备",@"工业软件",@"工业机器人",@"电子元器件",@"工业软件",@"工业机器人",@"电子元器件"];
    if (_titleArr.count != 0) {
        
        [self setUpTheHeaderItmes];
    }
}

//SectionheaderView
- (void)setUpSectionHeaderView{
    
    NewHomePageCollectionSectionHeaderView *headerView = [[NewHomePageCollectionSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80/2.0 * KWidth_ScaleH)];
    headerView.sectionType = @"SamrtShoppingMall";
    headerView.userInteractionEnabled = YES;
    [headerView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerViewClick)]];
    [self addSubview:headerView];
    self.headerView = headerView;
}
//头部的item
- (void)setUpTheHeaderItmes{
    
    //页内容的scrollView
    _headerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,self.headerView.bottom,kScreenWidth,76/2.0 *  KWidth_ScaleH)];
    _headerScrollView.showsVerticalScrollIndicator = NO;
    _headerScrollView.showsHorizontalScrollIndicator = NO;
    _headerScrollView.bounces = NO;
    _headerScrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_headerScrollView];
    CGFloat width = 15;
    for (int i = 0;i < _titleArr.count; i++) {
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        titleLabel.text = [_titleArr objectAtIndex:i];
        titleLabel.font = [UIFont systemFontOfSize:12.f];
        CGSize widthSize = [titleLabel sizeThatFits:CGSizeMake(MAXFLOAT,_headerScrollView.height)];
        titleLabel.frame = CGRectMake(width,0,widthSize.width+20,_headerScrollView.frame.size.height);
        width = widthSize.width + width + 20;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.userInteractionEnabled = YES;
        titleLabel.tag = 2000+i;
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0,titleLabel.frame.size.height-1,_headerScrollView.width,1)];
        bottomLineView.backgroundColor = UIColorFromRGBA(245, 245, 245, 1.0);
        [_headerScrollView addSubview:bottomLineView];
        
        if (i == 0) {
            titleLabel.textColor = UIColorFromRGBA(233, 46, 46, 1.0);
            CGFloat imageHeight = 2;
            imageWidth = titleLabel.width - 20;
            _line = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.frame.size.width/2.0-(imageWidth)/2.0,titleLabel.frame.size.height-imageHeight - 1,imageWidth,imageHeight)];
            _line.backgroundColor = UIColorFromRGBA(251, 52, 52, 1.0);
            _line.layer.cornerRadius = 1;
            [_headerScrollView addSubview:_line];
            _line.centerX = titleLabel.center.x;
            
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClicked:)];
        [titleLabel addGestureRecognizer:tap];
        [_headerScrollView addSubview:titleLabel];
    }
    [_headerScrollView setContentSize:CGSizeMake(width,0)];
}
#pragma mark -- 手势
- (void)headerViewClick{
    
    NSLog(@"点击的是智造商城");
    BOOL isShowClassify = [KUserDefault objectForKey:ShowClassifyPopView];
    if (!isShowClassify) {
        
        ClassifyPopView *classifyPopView = [[ClassifyPopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        classifyPopView.alertVC = self.viewControler;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:classifyPopView];
    }
}
- (void)titleLabelClicked:(UITapGestureRecognizer*)sender{
    UILabel *titleLabel = (UILabel*)sender.view;
    //    CGSize widthSize = [titleLabel sizeThatFits:CGSizeMake(MAXFLOAT,self.smallScrollView.height)];
    for (UILabel *label in _headerScrollView.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            if (label.tag == sender.view.tag) {
                label.textColor = UIColorFromRGBA(233, 46, 46, 1.0);
                label.userInteractionEnabled = NO;
                CGRect imageViewRect = _line.frame;
                CGFloat X = imageViewRect.origin.x;
                X = label.center.x;
                
                imageViewRect.origin.x = X - (titleLabel.width -  20)/2.0;
                imageViewRect.size.width = titleLabel.width -  20;
                _line.frame = imageViewRect;
                //                [UIView animateWithDuration:0.1f animations:^{
                //                }];
            }
            else{
                label.textColor = UIColorFromRGBA(99, 99, 99, 1.0);
                label.userInteractionEnabled = YES;
            }
        }
    }
    
    NSInteger index = titleLabel.tag-2000;
//    __weak typeof(self)weakSelf = self;
//    [_pageViewController setViewControllers:@[_viewControllers[index]] direction:(index>_currentIndex?UIPageViewControllerNavigationDirectionForward:UIPageViewControllerNavigationDirectionReverse) animated:YES completion:^(BOOL finished) {
//        weakSelf.currentIndex = index;
//    }];
    
    CGFloat offsetx = titleLabel.center.x - _headerScrollView.frame.size.width * 0.5;
    CGFloat offsetMax = _headerScrollView.contentSize.width - _headerScrollView.frame.size.width;
    if (offsetx > offsetMax) {
        offsetx = offsetMax;
    }
    else if (offsetx < 0){
        offsetx = 0;
    }
    if (_titleArr.count <= 4) {
        offsetx = 0;
    }
    CGPoint offset = CGPointMake(offsetx, _headerScrollView.contentOffset.y);
    [_headerScrollView setContentOffset:offset animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTabItemRefreshData" object:@(index)];
    });
    
}

#pragma mark -- 通知
- (void)smartMallScrollIndex:(NSNotification *)notify{
    
    id scrollIndex = notify.object;
    if ([scrollIndex isKindOfClass:[NSNumber class]]) {
        
        NSInteger index = [scrollIndex integerValue];
        UILabel *titleLabel = [_headerScrollView viewWithTag:2000 + index];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClicked:)];
        [titleLabel addGestureRecognizer:tap];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
