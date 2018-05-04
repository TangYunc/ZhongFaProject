//
//  Constant.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

//正式环境
NSString *const BaseApi = @"http://wap.cecb2b.com";

NSString *const BaseTwoApi = @"http://api.nzfa.com";

//生产环境
//NSString *const BaseApi = @"http://www.121mai.com/appv2.2";

//测试环境
//NSString *const BaseApi = @"http://cectest.cecb2b.com/waps";

//***************************APIToken************************//
NSString *const accessToken_API = @"http://api.nzfa.com/users/login";


//***************************首页************************//
NSString *const electronic_API = @"/api/getMarkets";
NSString *const HomePageSupplyChainList_API = @"/made/supplyChainList";
NSString *const HomePageScienceList_API = @"/made/science/list";
NSString *const HomePageIntelligenceList_API = @"/made/intelligence/list";
NSString *const HomePageSolutionList_API = @"/made/solution/list";
NSString *const HomePageadInfo_API = @"/api/adInfo/41,44";
NSString *const HomePageSearch_API = @"/made/search?q=&isFirst=true&icNum=0&nicNum=0&icUsedNum=0&nicUsedNum=0";
NSString *const HomePageGetClassify_API = @"/popups?access-token=";
NSString *const HomePageSubmitClassify_API = @"/popups?access-token=";
NSString *const HomePageRecommend_API = @"/indexs/recommend?access-token=";
NSString *const HomePageSmartHeadlineNews_API = @"/indexs/tt?access-token=";
NSString *const HomePageScienceResult_API = @"/indexs/tech?access-token=";
NSString *const HomePageSolve_API = @"/indexs/solution?access-token=";
NSString *const HomePageSmartShoppingMall_API = @"/indexs/shop?access-token=";
NSString *const HomePageSSM_API = @"/shops?access-token=";
NSString *const HomePageSSMClassify_API = @"/shops/cate?access-token=";
NSString *const HomePageSSMTable_API = @"/shops/search?access-token=";

//***************************发布需求************************//
NSString *const RRCustomized_API = @"/recruits?access-token=";
NSString *const RRSubCustomized_API = @"/recruits/subclass?access-token=";
NSString *const RRCustomizedConfirmRelease_API = @"/recruits?access-token=";//这里RRCustomized_API与RRCustomizedConfirmRelease_API接口是一样的，但是为了区别发布与表单获取，所以用了两个字段
NSString *const RRRecruits_API = @"/recruit-agents?access-token=";
NSString *const RRRecruitsConfirmRelease_API = @"/recruit-agents?access-token=";//这里RRRecruits_API与RRRecruitsConfirmRelease_API接口是一样的，但是为了区别发布与表单获取，所以用了两个字段
NSString *const RRAgency_API = @"/search-agents?access-token=";
NSString *const RRAgencyConfirmRelease_API = @"/search-agents?access-token=";//这里RRAgency_API与RRAgencyConfirmRelease_API接口是一样的，但是为了区别发布与表单获取，所以用了两个字段



//***************************推送************************//


//***************************融云************************//


//***************************金融服务************************//


//***************************搜索************************//


//***************************商品详情************************//


//***************************知识产权************************//



//***************************采购料单************************//
NSString *const PurchaseList_api = @"/cart/list";


//***************************我的************************//

NSString *const MineMember_api = @"/api/member";
NSString *const MineMyOrder_api = @"/order/myOrder";
NSString *const MineForThePayment_api = @"/order/myOrder?orderDataType=10";
NSString *const MineToSendTheGoods_api = @"/order/myOrder?orderDataType=30";
NSString *const MineForTheGoods_api = @"/order/myOrder?orderDataType=50";
NSString *const MineRefunding_api = @"/order/myOrder?orderDataType=40";

NSString *const MineAccountSecurity_api = @"/user/safe";
NSString *const MineReceivingAdressManagement_api = @"/express/list";

NSString *const MineGoodsCollection_api = @"/favorites/good/myFavorites";
NSString *const MineShopsCollection_api = @"/favorites/shop/myFavorites";



//***************************登陆注册************************//
NSString *const login_api = @"/api/login/member";
NSString *const getRongToken_api = @"/api/getRongToken";//融云

//推送
//保存消息推送用户token
NSString *const JPushSave_api = @"/api/pushUserToken/save";
NSString *const loginSmscode_api = @"/api/getLoginDynamicCode";
NSString *const messageLogin_api = @"/api/login/dynamic";
NSString *const getDynamicCode_api = @"/api/getDynamicCode";
NSString *const register_api = @"/api/register";


//交互
NSString *const memberHome_api = @"/member/home";
NSString *const memberLogin_api = @"/member/login";
NSString *const memberIndex_api = @"/made/index";

//other
NSString *const APIToken = @"APIToken";
NSString *const historySearch = @"HistorySearch";

NSString *const RRCityDataOnCurrentProvince_API = @"/regions/city?access-token=";

NSString *const AssessmentReview_API = @"http://192.168.1.223/index.php?r=project-info%2Fservice&id=395696247";
NSString *const  PatentApplication_API = @"http://192.168.1.223/index.php?r=project-info%2Fservice&id=395696165";
NSString *const TrademarkRegistration_API = @"http://192.168.1.223/index.php?r=project-info%2Fservice&id=395696241";
NSString *const ProjectApplication_API = @"http://192.168.1.223/index.php?r=project-info%2Fservice&id=395696245";
NSString *const HighRecognition_API = @"http://192.168.1.223/index.php?r=project-info%2Fservice&id=395696242";
NSString *const GuidViewHide = @"GuidViewHide";

