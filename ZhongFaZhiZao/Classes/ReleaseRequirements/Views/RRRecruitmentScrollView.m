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

@property (nonatomic, strong) NSMutableArray *datasNameMarr;//存储名字数组
@property (nonatomic, strong) NSMutableArray *datasIdMarr;//存储ID数组

@property (nonatomic, copy) NSString *brand_name;//公司名称
@property (nonatomic, copy) NSString *industry_id;//行业分类ID
@property (nonatomic, copy) NSString *brand_desc;//品牌介绍

@property (nonatomic, copy) NSString *province_id;//省ID
@property (nonatomic, copy) NSString *city;//城市ID
@property (nonatomic, copy) NSString *cooperation_model_name;//代理模式
@property (nonatomic, copy) NSString *cooperation_desc;//代理需求
@property (nonatomic, copy) NSString *policy_support_desc;//代理政策


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
        propertyEditView.block = ^(NSInteger itemId, NSString *itemName) {
            
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
    RRTextViewEditSubview *ComendtextView = (RRTextViewEditSubview *)[self viewWithTag:50];
    ComendtextView.block = ^(UIView *currentView, NSString *content) {
        weakSelf.cooperation_desc = content;
    };
    RRTextViewEditSubview *textViewEditSubview = (RRTextViewEditSubview *)[self viewWithTag:51];
    textViewEditSubview.block = ^(UIView *currentView, NSString *content) {
        weakSelf.policy_support_desc = content;
    };
    CGFloat rrCustomSubviewHeight = kScreenHeight - 784/2.0 * KWidth_ScaleH;
    CGFloat rrCustomSubviewGapFromTop = 20/2.0 * KWidth_ScaleH;
    _rrCustomSubview = [[RRCustomSubview alloc] initWithFrame:CGRectMake(0, textViewEditSubview.bottom + rrCustomSubviewGapFromTop, kScreenWidth, rrCustomSubviewHeight)];
    _rrCustomSubview.block = ^(UIButton *btn, NSString *phoneNum, NSString *userName, NSString *vfCodeStr) {
        [weakSelf endEditing:YES];
        [weakSelf confirmReleaseRequestsUserName:userName withPhoneNum:phoneNum withVFCode:vfCodeStr];
    };
    [self addSubview:_rrCustomSubview];
}

- (void)setDatas:(RRRecruitmentDatas *)datas{
    
    if (_datas != datas) {
        _datas = datas;
        WS(weakSelf);
        //1.请选择您的行业
        self.datasIdMarr = nil;
        self.datasNameMarr = nil;
        RRPropertyEditSubview *secondView = (RRPropertyEditSubview *)[self viewWithTag:11];
        for (RRRecruitmentIndustryCate *item in _datas.industry_cate) {
            [self.datasNameMarr addObject:item.name];
            [self.datasIdMarr addObject:item.industryCateId];
        }
        secondView.theNameDatas = [self.datasNameMarr copy];
        secondView.theIdDatas = [self.datasIdMarr copy];
        secondView.block = ^(NSInteger itemId, NSString *itemName) {
            [weakSelf endEditing:YES];
            weakSelf.industry_id = [NSString stringWithFormat:@"%ld",(long)itemId];
        };
        //2.招代理地区
        self.datasIdMarr = nil;
        self.datasNameMarr = nil;
        RRPropertyEditSubview *fourView = (RRPropertyEditSubview *)[self viewWithTag:13];
        fourView.theProvinceDatas = _datas.province_list;
        for (RRRecruitmentProvinceList *item in _datas.province_list) {
            [self.datasNameMarr addObject:item.name];
            [self.datasIdMarr addObject:item.provinceListId];
        }
        fourView.theNameDatas = [self.datasNameMarr copy];
        fourView.theIdDatas = [self.datasIdMarr copy];
        fourView.cityBlock = ^(NSString *provinceId, NSString *cityId) {
            [weakSelf endEditing:YES];
            weakSelf.province_id = provinceId;
            weakSelf.city = cityId;
        };
        
        //代理模式
        self.datasIdMarr = nil;
        self.datasNameMarr = nil;
        RRPropertyEditSubview *fiveView = (RRPropertyEditSubview *)[self viewWithTag:14];
        
        NSString *nameOne = _datas.cooperation_list.one;
        NSString *nameTwo = _datas.cooperation_list.two;
        NSString *nameThree = _datas.cooperation_list.three;
        NSString *nameFour = _datas.cooperation_list.four;
        [self.datasNameMarr addObjectsFromArray:@[nameOne,nameTwo,nameThree,nameFour]];
        [self.datasIdMarr addObjectsFromArray:@[@"1",@"2",@"3",@"4"]];
        fiveView.theNameDatas = [self.datasNameMarr copy];
        fiveView.theIdDatas = [self.datasIdMarr copy];
        fiveView.block = ^(NSInteger itemId, NSString *itemName) {
            [weakSelf endEditing:YES];
            weakSelf.cooperation_model_name = [NSString stringWithFormat:@"%ld",(long)itemId];
        };
    }
}

- (NSMutableArray *)datasNameMarr{
    if (!_datasNameMarr) {
        _datasNameMarr = [NSMutableArray array];
    }
    return _datasNameMarr;
}
- (NSMutableArray *)datasIdMarr{
    if (!_datasIdMarr) {
        _datasIdMarr = [NSMutableArray array];
    }
    return _datasIdMarr;
}

#pragma mark -- 手势
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
//内容发生改变编辑
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *text = textField.text;
    NSString *text2 = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([text2 isEqual:@""]){
        return;
    }
    if (textField == _companyNameTF) {
        self.brand_name = text2;
    }else if (textField == _brandTF){
        self.brand_desc = text2;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"%@",textField.text);
    return YES;
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

#pragma mark -- method
- (void)confirmReleaseRequestsUserName:(NSString *)userName withPhoneNum:(NSString *)phoneNum withVFCode:(NSString *)vfCodeStr{
    
    // 1.请求参数
    NSMutableDictionary *tempPara = [NSMutableDictionary dictionary];
    NSString *uidStr = [KUserDefault objectForKey:@"uid"];
    
    //检验
    if (uidStr == nil) {
        NSLog(@"uidStr的值%@为空",uidStr);
        [MBProgressHUD showError:@"请登录!"];
        return;
    }
    
    if (self.brand_name == nil) {
        NSLog(@"brand_name的值%@为空",self.brand_name);
        [MBProgressHUD showError:@"请选择您公司的名称!"];
        return;
    }
    
    if (self.industry_id == nil) {
        NSLog(@"industry_id的值%@为空",self.industry_id);
        [MBProgressHUD showError:@"请选择您当前的行业!"];
        return;
    }
    
    if (self.brand_desc == nil) {
        NSLog(@"brand_desc的值%@为空",self.brand_desc);
        [MBProgressHUD showError:@"请填写您的代理品牌!"];
        return;
    }
//    self.province_id = @"5";
//    self.city = @"5";
    if (self.province_id == nil) {
        NSLog(@"province_id的值%@为空",self.province_id);
        [MBProgressHUD showError:@"请选择您当前的省份!"];
        return;
    }
    if (self.city == nil) {
        NSLog(@"city的值%@为空",self.city);
        [MBProgressHUD showError:@"请选择您当前的城市!"];
        return;
    }
    
    if (self.cooperation_model_name == nil) {
        NSLog(@"cooperation_model_name的值%@为空",self.cooperation_model_name);
        [MBProgressHUD showError:@"请选择您当前代理模式!"];
        return;
    }
    if (self.cooperation_desc == nil) {
        [MBProgressHUD showError:@"请填写您的代理要求!"];
        return;
    }
    
    if (self.policy_support_desc.length > 0) {
        [tempPara setObject:self.policy_support_desc forKey:@"policy_support_desc"];
    }
    [tempPara setObject:uidStr forKey:@"uid"];
    [tempPara setObject:self.brand_name forKey:@"brand_name"];
    [tempPara setObject:self.industry_id forKey:@"industry_id"];
    [tempPara setObject:self.brand_desc forKey:@"brand_desc"];
    [tempPara setObject:self.province_id forKey:@"province_id"];
    [tempPara setObject:self.city forKey:@"city"];
    [tempPara setObject:self.cooperation_model_name forKey:@"cooperation_model_name"];
    [tempPara setObject:self.cooperation_desc forKey:@"cooperation_desc"];
    [tempPara setObject:userName forKey:@"contacts"];
    [tempPara setObject:phoneNum forKey:@"mobile"];
    
    NSString *apiToken = [KUserDefault objectForKey:APIToken];
    if (apiToken == nil) {
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@%@",BaseTwoApi,RRRecruitsConfirmRelease_API,apiToken];
    
    // 发送请求
    [MBProgressHUD showMessage:@"正在发布..."];
    [TNetworking postWithUrl:url params:tempPara success:^(id response) {
        [MBProgressHUD hideHUD];
        if ([response[@"message"] isEqualToString:@"Created"]) {
            [MBProgressHUD showSuccess:@"发布成功!"];
        }else{
            if (response[@"message"]) {
                [MBProgressHUD showError:response[@"message"]];
            }
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [WKProgressHUD popMessage:@"请检查网络连接" inView:self duration:HUD_DURATION animated:YES];
    } showHUD:NO];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
