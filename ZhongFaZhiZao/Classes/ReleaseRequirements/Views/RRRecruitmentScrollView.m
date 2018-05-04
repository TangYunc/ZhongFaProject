//
//  RRRecruitmentScrollView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/12.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "RRRecruitmentScrollView.h"
#import "RRPropertyEditSubview.h"
#import "RRCustomSubview.h"
#import "RRTextViewEditSubview.h"
#import "ScrollPickView.h"

@interface RRRecruitmentScrollView ()<UITextFieldDelegate>
{
    RRCustomSubview *_rrCustomSubview;
    UITextField *_companyNameTF;
    UITextField *_brandTF;
}
@property (nonatomic, assign) Float32 keyboardHeight;
@property (nonatomic, assign) Float32 inputViewMaxY;
@end

@implementation RRRecruitmentScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化UI
        [self initUI];
        
        // 监听键盘变化
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
        // 增加一个键盘监听方法（为了能够在键盘弹起完成后，让视图内容滚动）
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChanged) name:UIKeyboardDidChangeFrameNotification object:nil];
        //监听当前控制器关闭的时候关闭键盘
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeRRViewController) name:@"closeRRViewController" object:nil];
    }
    return self;
}
//初始化UI
- (void)initUI{
    
    WS(weakSelf);
    NSArray *titleArr = @[@"公司名称",@"请选择您的行业",@"招代理品牌",@"招代理地区",@"代理模式"];
    NSInteger tempCount = titleArr.count;
    CGFloat propertyEditViewHeight = 99/2.0 * KWidth_ScaleH;
    for (NSInteger i = 0; i < tempCount; i++) {
        
        RRPropertyEditSubview *propertyEditView = [[RRPropertyEditSubview alloc] initWithFrame:CGRectMake(0, i * propertyEditViewHeight, kScreenWidth, propertyEditViewHeight)];
        propertyEditView.block = ^{
            [weakSelf endEditing:YES];
        };
        propertyEditView.tag = 10 + i;
        propertyEditView.titleStr = titleArr[i];
        [self addSubview:propertyEditView];
    }
    //2.
    RRPropertyEditSubview *companyNameView = (RRPropertyEditSubview *)[self viewWithTag:10];
    companyNameView.showAuxiliaryIcon = NO;
    companyNameView.isClickCoverBtn = NO;
    CGFloat textFieldWidth = 522/2.0 * KWidth_ScaleW;
    CGFloat textFieldHeight = 66/2.0 * KWidth_ScaleH;
    CGFloat TextFieldGapFromTop = (companyNameView.height - textFieldHeight) / 2.0;
    _companyNameTF = [[UITextField alloc] initWithFrame:CGRectMake(0, TextFieldGapFromTop, textFieldWidth, textFieldHeight)];
    _companyNameTF.right = companyNameView.right - 27/2.0 * KWidth_ScaleW;
    // 输入框样式
    _companyNameTF.borderStyle = UITextBorderStyleRoundedRect;
    // 清除文本视图按钮
    _companyNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    // 设置字体的大小
    _companyNameTF.font = [UIFont boldSystemFontOfSize:14.f];
    // 设置字体颜色
    _companyNameTF.textColor = [UIColor colorWithHexString:@"#666666"];
    // 我们可能需要监听文本框的一些操作的时候，系统给我们提供了一个协议，可以让我们监听一些设置
    _companyNameTF.delegate = self;
    [companyNameView addSubview:_companyNameTF];
    
    RRPropertyEditSubview *brandView = (RRPropertyEditSubview *)[self viewWithTag:12];
    brandView.showAuxiliaryIcon = NO;
    brandView.isClickCoverBtn = NO;
    _brandTF = [[UITextField alloc] initWithFrame:CGRectMake(0, TextFieldGapFromTop, textFieldWidth, textFieldHeight)];
    _brandTF.right = brandView.right - 27/2.0 * KWidth_ScaleW;
    _brandTF.borderStyle = UITextBorderStyleRoundedRect;
    _brandTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _brandTF.font = [UIFont boldSystemFontOfSize:14.f];
    _brandTF.textColor = [UIColor colorWithHexString:@"#666666"];
    _brandTF.delegate = self;
    [brandView addSubview:_brandTF];
    
    RRPropertyEditSubview *locationView = (RRPropertyEditSubview *)[self viewWithTag:13];
    locationView.showScroll = NO;
    
    RRPropertyEditSubview *lastView = (RRPropertyEditSubview *)[self viewWithTag:14];
    NSArray *discribArr = @[@"代理要求",@"代理政策"];
    NSArray *placeholderArr = @[@"具体描述您的代理要求",@"具体描述您的代理政策"];
    NSInteger theTempCount = discribArr.count;
    CGFloat textBJViewHeight = 377.5/2.0 * KWidth_ScaleH;
    for (NSInteger i = 0; i < theTempCount; i++) {
        
        RRTextViewEditSubview *textViewEditSubview = [[RRTextViewEditSubview alloc] initWithFrame:CGRectMake(0, lastView.bottom + i * textBJViewHeight, kScreenWidth, textBJViewHeight)];
        textViewEditSubview.discribStr = discribArr[i];
        textViewEditSubview.tag = 50 + i;
        textViewEditSubview.placeholderStr = placeholderArr[i];
        [self addSubview:textViewEditSubview];
    }
    
    RRTextViewEditSubview *textViewEditSubview = (RRTextViewEditSubview *)[self viewWithTag:51];
    CGFloat rrCustomSubviewHeight = kScreenHeight - 784/2.0 * KWidth_ScaleH;
    CGFloat rrCustomSubviewGapFromTop = 20/2.0 * KWidth_ScaleH;
    _rrCustomSubview = [[RRCustomSubview alloc] initWithFrame:CGRectMake(0, textViewEditSubview.bottom + rrCustomSubviewGapFromTop, kScreenWidth, rrCustomSubviewHeight)];
    [self addSubview:_rrCustomSubview];
}

#pragma mark -- 手势
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.inputViewMaxY = CGRectGetMaxY(textField.superview.frame);
    [self scrollToBottom];
    
    return YES;
}
#pragma 根据keyboardChanged滚动scrollView
-(void)keyboardChanged:(NSNotification *)notification {
    // UIKeyboardFrameEndUserInfoKey =>将要变化的大小
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardHeight = keyboardRect.size.height;
}

-(void)keyboardDidChanged
{
    [self scrollToBottom];
}


-(void)scrollToBottom
{
    Float32 keyboardMaxY = kScreenHeight - self.keyboardHeight;
    Float32 scrollOffset = self.inputViewMaxY - keyboardMaxY;
    if (scrollOffset >= 0) {
        [self setContentOffset:CGPointMake(0, scrollOffset) animated:YES];
    }
    
}

#pragma mark -- 通知
- (void)closeRRViewController{
    
    [self endEditing:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
