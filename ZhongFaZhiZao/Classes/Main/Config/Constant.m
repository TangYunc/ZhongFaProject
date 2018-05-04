//
//  Constant.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

//正式环境
NSString *const BaseApi = @"http://wap.cecb2b.com";

//生产环境
//NSString *const BaseApi = @"http://www.121mai.com/appv2.2";

//测试环境
//NSString *const BaseApi = @"http://cectest.cecb2b.com/waps";


//***************************首页************************//
NSString *const electronic_API = @"/api/getMarkets";
NSString *const HomePageSupplyChainList_API = @"/made/supplyChainList";
NSString *const HomePageScienceList_API = @"/made/science/list";
NSString *const HomePageIntelligenceList_API = @"/made/intelligence/list";
NSString *const HomePageSolutionList_API = @"/made/solution/list";
NSString *const HomePageadInfo_API = @"/api/adInfo/41,44";
NSString *const HomePageSearch_API = @"/made/search?q=&isFirst=true&icNum=0&nicNum=0&icUsedNum=0&nicUsedNum=0";

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


