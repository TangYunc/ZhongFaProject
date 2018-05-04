//
//  ZYJHeadLineView.m
//  ZYJHeadLineView
//
//  Created by 张彦杰 on 16/12/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZYJHeadLineView.h"

#define HotBtnWidth 43/2.0 * KWidth_ScaleW
#define HotBtnHeight 22/2.0 * KWidth_ScaleH
#define HotBtnGapWithOther 14/2.0 * KWidth_ScaleH

@interface ZYJHeadLineView(){
    NSTimer *_timer;     //定时器
    int count;
    int flag; //标识当前是哪个view显示(currentView/hidenView)
    NSMutableArray *_dataArr;
}
@property (nonatomic,strong) UIView *currentView;   //当前显示的view
@property (nonatomic,strong) UIView *hidenView;     //底部藏起的view
@property (nonatomic,strong) UILabel *currentLabel;
@property (nonatomic,strong) UIButton *currentBtn;
@property (nonatomic,strong) UIButton *hidenBtn;
@property (nonatomic,strong) UILabel *hidenLabel;
@property (nonatomic,strong) UILabel *currentTwoLabel;
@property (nonatomic,strong) UIButton *currentTwoBtn;
@property (nonatomic,strong) UIButton *hidenTwoBtn;
@property (nonatomic,strong) UILabel *hidenTwoLabel;
@end



@implementation ZYJHeadLineView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        
    }
    return self;
}
- (void)createUI
{
    count = 0;
    flag = 0;
    
    self.layer.masksToBounds = YES;
    
    //创建定时器
    [self createTimer];
    [self createCurrentView];
    [self createHidenView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dealTap:)];
    [self addGestureRecognizer:tap];
    //改进
    UILongPressGestureRecognizer*longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(dealLongPress:)];
    [self addGestureRecognizer:longPress];
    
    
}
- (void)setVerticalShowDataArr:(NSMutableArray *)dataArr
{
    _dataArr = dataArr;
    NSLog(@"dataArr-->%@",dataArr);
    ZYJHeadLineModel *model = _dataArr[count];
    [self.currentBtn setTitle:model.type forState:UIControlStateNormal];
    self.currentLabel.text = model.title;
    [self.currentTwoBtn setTitle:model.type forState:UIControlStateNormal];
    self.currentTwoLabel.text = model.title;
}


-(void)dealLongPress:(UILongPressGestureRecognizer*)longPress{
    
    if(longPress.state==UIGestureRecognizerStateEnded){
        
        _timer.fireDate=[NSDate distantPast];
        
        
    }
    if(longPress.state==UIGestureRecognizerStateBegan){
        
        _timer.fireDate=[NSDate distantFuture];
    }
    
    
    
    
}
- (void)dealTap:(UITapGestureRecognizer *)tap
{
    self.clickBlock(count);
}

- (void)createTimer
{
    _timer=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(dealTimer) userInfo:nil repeats:YES];
}

#pragma mark - 跑马灯操作
-(void)dealTimer
{
    count++;
    if (count == _dataArr.count) {
        count = 0;
    }
    
    if (flag == 1) {
        ZYJHeadLineModel *currentModel = _dataArr[count];
        [self.currentBtn setTitle:currentModel.type forState:UIControlStateNormal];
        self.currentLabel.text = currentModel.title;
        
        [self.currentTwoBtn setTitle:currentModel.type forState:UIControlStateNormal];
        self.currentTwoLabel.text = currentModel.title;
    }
    
    if (flag == 0) {
        ZYJHeadLineModel *hienModel = _dataArr[count];
        [self.hidenBtn setTitle:hienModel.type forState:UIControlStateNormal];
        self.hidenLabel.text = hienModel.title;
        
        [self.hidenTwoBtn setTitle:hienModel.type forState:UIControlStateNormal];
        self.hidenTwoLabel.text = hienModel.title;
    }
    
    
    if (flag == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.currentView.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            flag = 1;
            self.currentView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            self.hidenView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }else{
        
        [UIView animateWithDuration:0.5 animations:^{
            self.hidenView.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            flag = 0;
            self.hidenView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.width);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            self.currentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)createCurrentView
{
    ZYJHeadLineModel *model = _dataArr[count];
    
    self.currentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.currentView];
    
    //此处是类型按钮(不需要点击)
    self.currentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.currentBtn.frame = CGRectMake(10, 3, HotBtnWidth, HotBtnHeight);
    self.currentBtn.layer.masksToBounds = YES;
    self.currentBtn.layer.cornerRadius = 2.5;
//    self.currentBtn.layer.borderWidth = 1;
//    self.currentBtn.layer.borderColor = [UIColor redColor].CGColor;
    [self.currentBtn setBackgroundColor:[UIColor colorWithHexString:@"#FF6600"]];
    [self.currentBtn setTitle:model.type forState:UIControlStateNormal];
    [self.currentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.currentBtn.titleLabel.font = [UIFont systemFontOfSize:8.f];
    [self.currentView addSubview:self.currentBtn];
    
    //内容标题
    self.currentLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.currentBtn.frame.origin.x+self.currentBtn.frame.size.width+10, self.currentBtn.top, self.currentView.frame.size.width-(self.currentBtn.frame.origin.x+self.currentBtn.frame.size.width+10+10), HotBtnHeight)];
    self.currentLabel.text = model.title;
    self.currentLabel.textAlignment = NSTextAlignmentLeft;
    self.currentLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.currentLabel.font = [UIFont systemFontOfSize:12.f];
    [self.currentView addSubview:self.currentLabel];
    
    
    //此处是类型按钮(不需要点击)
    self.currentTwoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.currentTwoBtn.frame = CGRectMake(10, self.currentBtn.bottom + HotBtnGapWithOther, HotBtnWidth, HotBtnHeight);
    self.currentTwoBtn.layer.masksToBounds = YES;
    self.currentTwoBtn.layer.cornerRadius = 2.5;
//    self.currentTwoBtn.layer.borderWidth = 1;
//    self.currentTwoBtn.layer.borderColor = [UIColor redColor].CGColor;
    [self.currentTwoBtn setBackgroundColor:[UIColor colorWithHexString:@"#FF6600"]];
    [self.currentTwoBtn setTitle:model.type forState:UIControlStateNormal];
    [self.currentTwoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.currentTwoBtn.titleLabel.font = [UIFont systemFontOfSize:8.f];
    [self.currentView addSubview:self.currentTwoBtn];
    
    //内容标题
    self.currentTwoLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.currentTwoBtn.frame.origin.x+self.currentTwoBtn.frame.size.width+10, self.currentTwoBtn.top, self.currentView.frame.size.width-(self.currentTwoBtn.frame.origin.x+self.currentTwoBtn.frame.size.width+10+10), HotBtnHeight)];
    self.currentTwoLabel.text = model.title;
    self.currentTwoLabel.textAlignment = NSTextAlignmentLeft;
    self.currentTwoLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.currentTwoLabel.font = [UIFont systemFontOfSize:12.f];
    [self.currentView addSubview:self.currentTwoLabel];
}

- (void)createHidenView
{
    self.hidenView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.hidenView];
    
    //此处是类型按钮(不需要点击)
    self.hidenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.hidenBtn.frame = CGRectMake(10, 3, HotBtnWidth, HotBtnHeight);
    self.hidenBtn.layer.masksToBounds = YES;
    self.hidenBtn.layer.cornerRadius = 2.5;
//    self.hidenBtn.layer.borderWidth = 1;
//    self.hidenBtn.layer.borderColor = [UIColor redColor].CGColor;
    [self.hidenBtn setBackgroundColor:[UIColor colorWithHexString:@"#FF6600"]];
    [self.hidenBtn setTitle:@"" forState:UIControlStateNormal];
    [self.hidenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.hidenBtn.titleLabel.font = [UIFont systemFontOfSize:8.f];
    [self.hidenView addSubview:self.hidenBtn];
    
    //内容标题
    self.hidenLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.hidenBtn.frame.origin.x+self.hidenBtn.frame.size.width+10, self.hidenBtn.top, self.hidenView.frame.size.width-(self.hidenBtn.frame.origin.x+self.hidenBtn.frame.size.width+10+10), HotBtnHeight)];
    self.hidenLabel.text = @"";
    self.hidenLabel.textAlignment = NSTextAlignmentLeft;
    self.hidenLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.hidenLabel.font = [UIFont systemFontOfSize:12.f];
    [self.hidenView addSubview:self.hidenLabel];
    
    
    //此处是类型按钮(不需要点击)
    self.hidenTwoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.hidenTwoBtn.frame = CGRectMake(10, self.currentBtn.bottom + HotBtnGapWithOther, HotBtnWidth, HotBtnHeight);
    self.hidenTwoBtn.layer.masksToBounds = YES;
    self.hidenTwoBtn.layer.cornerRadius = 2.5;
    [self.hidenTwoBtn setBackgroundColor:[UIColor colorWithHexString:@"#FF6600"]];
//    self.hidenTwoBtn.layer.borderWidth = 1;
//    self.hidenTwoBtn.layer.borderColor = [UIColor redColor].CGColor;
    [self.hidenTwoBtn setTitle:@"" forState:UIControlStateNormal];
    [self.hidenTwoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.hidenTwoBtn.titleLabel.font = [UIFont systemFontOfSize:8.f];
    [self.hidenView addSubview:self.hidenTwoBtn];
    
    //内容标题
    self.hidenTwoLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.hidenTwoBtn.frame.origin.x+self.hidenTwoBtn.frame.size.width+10, self.hidenTwoBtn.top, self.hidenView.frame.size.width-(self.hidenTwoBtn.frame.origin.x+self.hidenTwoBtn.frame.size.width+10+10), HotBtnHeight)];
    self.hidenTwoLabel.text = @"";
    self.hidenTwoLabel.textAlignment = NSTextAlignmentLeft;
    self.hidenTwoLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.hidenTwoLabel.font = [UIFont systemFontOfSize:12.f];
    [self.hidenView addSubview:self.hidenTwoLabel];
}

#pragma mark - 停止定时器
- (void)stopTimer
{
    //停止定时器
    //在invalidate之前最好先用isValid先判断是否还在线程中：
    if ([_timer isValid] == YES) {
        [_timer invalidate];
        _timer = nil;
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

