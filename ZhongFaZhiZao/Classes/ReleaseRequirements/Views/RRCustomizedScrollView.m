//
//  RRCustomizedScrollView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/12.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "RRCustomizedScrollView.h"
#import "RRPropertyEditSubview.h"
#import "RRCustomSubview.h"
#import "RRTextViewEditSubview.h"


@interface RRCustomizedScrollView ()<UITextFieldDelegate>
{
    RRCustomSubview *_rrCustomSubview;
    RRTextViewEditSubview *_textViewEditSubview;
}
@property (nonatomic, strong) NSMutableArray *datasNameMarr;//存储名字数组
@property (nonatomic, strong) NSMutableArray *datasIdMarr;//存储ID数组

@property (nonatomic, copy) NSString *project_stage_id;//项目所处的阶段ID
@property (nonatomic, copy) NSString *project_demand_id;//项目需求类型ID
@property (nonatomic, copy) NSString *project_demand_child_id;//项目需求子类型ID
@property (nonatomic, copy) NSString *briefly;//需求
@property (nonatomic, copy) NSString *industry_id;//行业分类ID
@property (nonatomic, copy) NSString *details;//详情需求

@end

@implementation RRCustomizedScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化UI
        [self initUI];
        //监听当前控制器关闭的时候关闭键盘
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeRRViewController) name:@"closeRRViewController" object:nil];
        
    }
    return self;
}
//初始化UI
- (void)initUI{
    
    WS(weakSelf);
    NSArray *titleArr = @[@"项目所处阶段",@"项目需求类型",@"项目需求子类型",@"请选择您的行业"];
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
    RRPropertyEditSubview *lastView = (RRPropertyEditSubview *)[self viewWithTag:13];
    CGFloat textBJViewHeight = 377.5/2.0 * KWidth_ScaleH;
    _textViewEditSubview = [[RRTextViewEditSubview alloc] initWithFrame:CGRectMake(0, lastView.bottom, kScreenWidth, textBJViewHeight)];
    _textViewEditSubview.discribStr = @"一句话描述您的需求";
    self.briefly = @"一句话描述您的需求";
    _textViewEditSubview.placeholderStr = @"具体描述您的需求，方便我们能更快更好的为您服务";
    _textViewEditSubview.block = ^(UIView *currentView, NSString *content) {
        NSLog(@"%@",content);
        weakSelf.details = content;
    };
    [self addSubview:_textViewEditSubview];
    
    CGFloat rrCustomSubviewHeight = kScreenHeight - 784/2.0 * KWidth_ScaleH;
    CGFloat rrCustomSubviewGapFromTop = 20/2.0 * KWidth_ScaleH;
    _rrCustomSubview = [[RRCustomSubview alloc] initWithFrame:CGRectMake(0, _textViewEditSubview.bottom + rrCustomSubviewGapFromTop, kScreenWidth, rrCustomSubviewHeight)];
    _rrCustomSubview.block = ^(UIButton *btn, NSString *phoneNum, NSString *userName, NSString *vfCodeStr) {
        [weakSelf confirmReleaseRequestsUserName:userName withPhoneNum:phoneNum withVFCode:vfCodeStr];
    };
    
    [self addSubview:_rrCustomSubview];
}

#pragma mark -- loadData
- (void)loadSubRecruitsData:(NSString *)recruitsId{
    WS(weakSelf);
    //项目需求子类型
    NSString *apiToken = [KUserDefault objectForKey:APIToken];
    if (apiToken == nil) {
        return;
    }
    if (recruitsId == nil) {
        return;
    }
    NSMutableDictionary *tempPara = [NSMutableDictionary dictionary];
    [tempPara setObject:recruitsId forKey:@"id"];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",BaseTwoApi,RRSubCustomized_API,apiToken];
    [TNetworking getWithUrl:url params:tempPara success:^(id response) {
        [RRSubRequestChild mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"childId" : @"id"
                     };
        }];
        [RRSubRequestSun mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"sunId" : @"id"
                     };
        }];
        
        RRSubRequestResult *result = [RRSubRequestResult mj_objectWithKeyValues:response];
        if (result.success) {
            self.datasIdMarr = nil;
            self.datasNameMarr = nil;
            RRPropertyEditSubview *thirdView = (RRPropertyEditSubview *)[self viewWithTag:12];
            thirdView.isClickCoverBtn = YES;
            for (RRSubRequestSun *item in result.data.datas.sun) {
                [self.datasNameMarr addObject:item.name];
                [self.datasIdMarr addObject:item.sunId];
            }
            thirdView.theNameDatas = [self.datasNameMarr copy];
            thirdView.theIdDatas = [self.datasIdMarr copy];
            thirdView.block = ^(NSInteger itemId, NSString *itemName) {
                weakSelf.project_demand_child_id = [NSString stringWithFormat:@"%ld",(long)itemId];
            };

        }else{
            
            NSLog(@"%@",result.message);
        }
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
        
        [WKProgressHUD popMessage:@"请检查网络连接" inView:self duration:HUD_DURATION animated:YES];
    } showHUD:NO];
}

- (void)setDatas:(RRRequestDatas *)datas{
    
    if (_datas != datas) {
        _datas = datas;
        WS(weakSelf);
        //1.项目所处阶段
        self.datasIdMarr = nil;
        self.datasNameMarr = nil;
        RRPropertyEditSubview *firstView = (RRPropertyEditSubview *)[self viewWithTag:10];
        for (RRRequestProjectPhase *item in _datas.project_phase) {
            [self.datasNameMarr addObject:item.name];
            [self.datasIdMarr addObject:item.projectPhaseId];
        }
        firstView.theNameDatas = [self.datasNameMarr copy];
        firstView.theIdDatas = [self.datasIdMarr copy];
        firstView.block = ^(NSInteger itemId, NSString *itemName) {
            weakSelf.project_stage_id = [NSString stringWithFormat:@"%ld",(long)itemId];
        };
        //2.项目需求类型
        self.datasIdMarr = nil;
        self.datasNameMarr = nil;
        RRPropertyEditSubview *secondView = (RRPropertyEditSubview *)[self viewWithTag:11];
        for (RRRequestProjectType *item in _datas.project_type) {
            [self.datasNameMarr addObject:item.name];
            [self.datasIdMarr addObject:item.projectTypeId];
        }
        secondView.theNameDatas = [self.datasNameMarr copy];
        secondView.theIdDatas = [self.datasIdMarr copy];
        secondView.block = ^(NSInteger itemId, NSString *itemName) {
            weakSelf.project_demand_id = [NSString stringWithFormat:@"%ld",(long)itemId];
            [weakSelf loadSubRecruitsData:[NSString stringWithFormat:@"%ld",(long)itemId]];
        };
        
        //请选择您的行业
        self.datasIdMarr = nil;
        self.datasNameMarr = nil;
        RRPropertyEditSubview *fourView = (RRPropertyEditSubview *)[self viewWithTag:13];
        for (RRRequestIndustryCate *item in _datas.industry_cate) {
            [self.datasNameMarr addObject:item.name];
            [self.datasIdMarr addObject:item.industryCateId];
        }
        fourView.theNameDatas = [self.datasNameMarr copy];
        fourView.theIdDatas = [self.datasIdMarr copy];
        fourView.block = ^(NSInteger itemId, NSString *itemName) {
            weakSelf.industry_id = [NSString stringWithFormat:@"%ld",(long)itemId];
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
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
    
    if (self.project_stage_id == nil) {
        NSLog(@"project_stage_id的值%@为空",self.project_stage_id);
        [MBProgressHUD showError:@"请选择您当前项目阶段!"];
        return;
    }
    
    if (self.project_demand_id == nil) {
        NSLog(@"project_demand_id的值%@为空",self.project_demand_id);
        [MBProgressHUD showError:@"请选择您项目的需求!"];
        return;
    }
    
    if (self.project_demand_child_id == nil) {
        NSLog(@"project_demand_child_id的值%@为空",self.project_demand_child_id);
        [MBProgressHUD showError:@"请选择您项目的需求子类型!"];
        return;
    }
    
    if (self.briefly == nil) {
        NSLog(@"briefly的值%@为空",self.briefly);
        [MBProgressHUD showError:@"请用一句话描述你的需求!"];
        return;
    }
    
    if (self.industry_id == nil) {
        NSLog(@"industry_id的值%@为空",self.industry_id);
        [MBProgressHUD showError:@"请选择您当前的行业!"];
        return;
    }
    
    if (self.details.length > 0) {
//        NSLog(@"details的值%@为空",self.details);
//        [MBProgressHUD showError:@"请描述您的需求!"];
        [tempPara setObject:self.details forKey:@"details"];
    }
    [tempPara setObject:uidStr forKey:@"uid"];
    [tempPara setObject:self.project_stage_id forKey:@"project_stage_id"];
    [tempPara setObject:self.project_demand_id forKey:@"project_demand_id"];
    [tempPara setObject:self.project_demand_child_id forKey:@"project_demand_child_id"];
    [tempPara setObject:self.briefly forKey:@"briefly"];
    [tempPara setObject:self.industry_id forKey:@"industry_id"];
    [tempPara setObject:userName forKey:@"contact"];
    [tempPara setObject:phoneNum forKey:@"mobile"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseTwoApi,RRCustomizedConfirmRelease_API];
    
    // 发送请求
    [MBProgressHUD showMessage:@"正在发布..."];
    [TNetworking postWithUrl:url params:tempPara success:^(id response) {
        [MBProgressHUD hideHUD];
        if ([response[@"message"] isEqualToString:@"Created"]) {
            
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
