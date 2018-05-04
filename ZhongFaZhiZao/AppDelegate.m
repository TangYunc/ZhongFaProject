//
//  AppDelegate.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarController.h"
#import "MainWebViewController.h"
#import "LaunchIntroductionView.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif




#define RONGCLOUD_IM_APPKEY @"6tnym1brnm7b7"


@interface AppDelegate ()<JPUSHRegisterDelegate,RCIMUserInfoDataSource,RCIMConnectionStatusDelegate,WXApiDelegate>{
    
    MainWebViewController *rootVC;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //注册第三方SDK
    [self configureSDKsWithApplication:application options:launchOptions];
    
    
    
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor blackColor];
    [_window makeKeyAndVisible];
    
    //2.创建标签控制器
    RootTabBarController *rootTBC = [[RootTabBarController alloc] init];
    _window.rootViewController = rootTBC;
    
    //开始
    [self start];
    return YES;
}
-(void)start{
    
    [NSThread sleepForTimeInterval:1.0];//设置启动页面时间
    //    引导页 放在makeKeyAndVisible后
    
    //    非点击引导页，右滑进入调用
    //    [LaunchIntroductionView sharedWithImages:@[@"guid01.jpg",@"guid02.jpg",@"guid03.jpg",@"guid04.jpg"]];
    
        //    点击引导页  设置小圆点颜色等
    [LaunchIntroductionView sharedWithImages:@[@"FirstLoadingScreen",@"ThirdLoadingScreen",@"FourthLoadingScreen",@"FifthLoadingScreen"] buttonImage:@"login" buttonFrame:CGRectMake(0,  0, kScreenWidth, kScreenHeight)];
    //    launch.currentColor = [UIColor redColor];
    //    launch.nomalColor = [UIColor greenColor];
}

- (void)configureSDKsWithApplication:(UIApplication *)application options:(NSDictionary *)launchOptions
{
    
#pragma mark - umeng分享
    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    // 打开图片水印
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    [UMSocialGlobal shareInstance].isClearCacheWhenGetUserInfo = NO;
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"583920d2f43e480ef6000267"];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
    
#pragma mark - Rongcloud
    [[RCIM sharedRCIM]initWithAppKey:RONGCLOUD_IM_APPKEY];
    
    /**
     * 推送处理1
     */
    if ([application
         respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, iOS 8
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge |
                                                                  UIUserNotificationTypeSound |
                                                                  UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didReceiveMessageNotification:)
     name:RCKitDispatchMessageNotification
     object:nil];
    
    //    [RCIM sharedRCIM].userInfoDataSource = [RCDataManager shareManager];
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    [[RCIM sharedRCIM]setUserInfoDataSource:self];
    //    设置接收消息代理
    //    [RCIM sharedRCIM].receiveMessageDelegate = self;
    
    
#pragma mark - to do 初始化APNs
    
    //Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    
    
#pragma mark - to do初始化JPush
    
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    //    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    NSString *advertisingId = nil;
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"cc8b5670fefb1a425851c61d"
                          channel:@"App Store"
                 apsForProduction:1
            advertisingIdentifier:advertisingId];
    
    
    //    创建通知 证明jpush已经连接成功
    NSNotificationCenter *jpushdefaultCenter = [NSNotificationCenter defaultCenter];
    [jpushdefaultCenter addObserver:self selector:@selector(networkDidLogin:)  name:kJPFNetworkDidLoginNotification object:nil];
    
    
    //    设置别名和标签
    //    JPUSHService setTags:<#(NSSet *)#> alias:<#(NSString *)#> callbackSelector:<#(SEL)#> object:<#(id)#>
    
    
    
#pragma mark - umeng统计设置
    /**************************umeng统计*************************/
    [UMConfigure initWithAppkey:@"583920d2f43e480ef6000267" channel:@"App Store"];
    /* appkey: 开发者在友盟后台申请的应用获得（可在统计后台的 “统计分析->设置->应用信息” 页面查看）*/
    // 统计组件配置
    [MobClick setScenarioType:E_UM_NORMAL];
    // [MobClick setScenarioType:E_UM_GAME];  // optional: 游戏场景设置
    
    
    //    集成测试前打开
    
    //    [MobClick setLogEnabled:YES];
    
    
    /*****************************Bugly***************************/
    
    [Bugly startWithAppId:@"cbecd6df67"];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)configUSharePlatforms
{
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx12e7a4deae04bf2f" appSecret:@"7a2b375d76d3a27e751ac0d46cc780c0" redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105940047"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3445863821"  appSecret:@"6bf6c33751681230e0a3f0d8c67ddf54" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
    [WXApi registerApp:@"wx12e7a4deae04bf2f"];
}

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

//获取registrationID
- (void)networkDidLogin:(NSNotification *)notification {
    
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        
        if (resCode == 0) {
            
            //            保存本地
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:registrationID forKey:@"registerid"];
            
            //            传给服务器
            NSDictionary *parameters = @{@"xiaomiToken":@"",@"jiguangToken":registrationID,@"huaweiToken":@""};
            [TNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",BaseApi,JPushSave_api] params:parameters success:^(id response) {
                if ([response[@"resultCode"]integerValue] == 1000) {
                    
                    NSLog(@"推送token成功");
                    
                    NSLog(@"regit ID ======%@",registrationID);
                }else if ([response[@"resultCode"]integerValue] == 1001){
                    
                    NSLog(@"推送token1001");
                    
                }else if ([response[@"resultCode"]integerValue] == 1008){
                    
                    NSLog(@"推送token1008");
                }
            } fail:^(NSError *error) {
                NSLog(@"%@",error);
                NSLog(@"推送token error");
            } showHUD:NO];
        }
        else{
            
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService resetBadge];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [JPUSHService resetBadge];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - umeng分享
//#define __IPHONE_10_0    100000
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 100000
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    /*
     返回的结果示例:
     po url 微信支付
     wx12e7a4deae04bf2f://pay/?returnKey=&ret=0
     
     po url 第三方登录
     wx12e7a4deae04bf2f://oauth?code=001J9HPU1SYnGS05xpOU1hpHPU1J9HPS&lang=zh_HK&country=CN&state=
     
     po url 微信分享
     wx12e7a4deae04bf2f://platformId=wechat
     */
    if ([[url absoluteString] hasPrefix:@"wx12e7a4deae04bf2f://pay"]) {
        
        BOOL WXPayResult = [WXApi handleOpenURL:url delegate:self];
        return WXPayResult;
        
    }else{
        // 友盟SDK的回调
        //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
        BOOL UMShareResult = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
        if (!UMShareResult) {
            // 其他如支付宝支付等SDK的回调
        }
        return UMShareResult;
    }
    
}

#endif

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    // 首先判断是不是微信支付的回调
    // NOTE:微信的支付回调就是按下面格式开头的，前面是APPId,判断URL是不是这个开头
    if ([[url absoluteString] hasPrefix:@"wx12e7a4deae04bf2f://pay"]) {
        
        BOOL WXPayResult = [WXApi handleOpenURL:url delegate:self];
        return WXPayResult;
        
    }else{
        // 友盟SDK的回调
        //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
        BOOL UMShareResult = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
        if (!UMShareResult) {
            // 其他如支付宝支付等SDK的回调
            /*
             //跳转支付宝钱包进行支付，处理支付结果
             if ([url.host isEqualToString:@"safepay"]) {
             
             [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
             
             //NSLog(@"result = %@",resultDic);
             if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
             
             // 后台验证支付结果
             [[NSNotificationCenter defaultCenter]postNotificationName:ALIPAYRESULT object:nil userInfo:@{@"result":resultDic[@"result"]}];
             }
             }];
             return YES;
             }
             */
        }
        return UMShareResult;
    }
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([[url absoluteString] hasPrefix:@"wx12e7a4deae04bf2f://pay"]) {
        
        BOOL WXPayResult = [WXApi handleOpenURL:url delegate:self];
        return WXPayResult;
        
    }else{
        // 友盟SDK的回调
        //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
        BOOL UMShareResult = [[UMSocialManager defaultManager] handleOpenURL:url];
        if (!UMShareResult) {
            // 其他如支付宝支付等SDK的回调
        }
        return UMShareResult;
    }
}

#pragma mark - to do注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
    
    
    // Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    
    NSLog(@"devicetoken = %@",deviceToken);
}


#pragma mark - to do实现注册APNs失败接口（可选）
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark - to do添加处理APNs通知回调方法
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    //    UNNotificationRequest *request = notification.request; // 收到推送的请求
    //    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        //        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        //            //程序运行时收到通知，先弹出消息框
        //
        //            [self getPushMessageAtStateActive:userInfo];
        //
        //        }
        //
        //        else{
        //
        [self pushToViewControllerWhenClickPushMessageWith:userInfo];
        //        }
        
        
    }
    else{
        
        //        本地通知
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
    
    //    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        //        NSLog(@"推送数据为================%@",userInfo);
        //
        //
        //        self.pushDic = [[NSMutableDictionary alloc]initWithDictionary:userInfo];
        //
        //        NSLog(@"pushDic == %@",self.pushDic);
        //
        //        NSLog(@"URL======= %@",self.pushDic[@"URL"]);
        
        //        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        //程序运行时收到通知，先弹出消息框
        //            [self getPushMessageAtStateActive:userInfo];
        //
        //            [[NSNotificationCenter defaultCenter] postNotificationName:@"ApplicationState" object:@"0"];
        
        //        }
        //
        //        else{
        
        //        userInfo需要传入的字段  URL  TITLE  SUMMURY  IMGURL  DATE
        
        self.pushDic = [[NSMutableDictionary alloc]initWithDictionary:userInfo];
        
        //
        //        NSString *path = [NSString stringWithFormat:@"%@/Documents/data.db",NSHomeDirectory()];
        //        FMDatabase *database = [FMDatabase databaseWithPath:path];
        
        //        [database open];
        
        //        }
        
        
        [ZhongFaDataBase addPushMessage:self.pushDic];
        
        [self pushToViewControllerWhenClickPushMessageWith:userInfo];
        //        }
        
        
    }
    else{
        
        //        本地通知
    }
    completionHandler();  // 系统要求执行这个方法
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    //    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
    //        //程序运行时收到通知，先弹出消息框
    //
    //        [self getPushMessageAtStateActive:userInfo];
    //
    //    }
    //
    //    else{
    //程序已经关闭或者在后台运行
    [self pushToViewControllerWhenClickPushMessageWith:userInfo];
    
    //    }
    
    [application setApplicationIconBadgeNumber:0];
    
    [JPUSHService handleRemoteNotification:userInfo];
    
    
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    
    // 取得Extras字段内容
    NSString *customizeField1 = [userInfo valueForKey:@"customizeExtras"]; //服务端中Extras字段，key是自己定义的
    NSLog(@"content =[%@], badge=[%ld], sound=[%@], customize field  =[%@]",content,badge,sound,customizeField1);
    
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}


//jpush跳转方法
- (void)pushToViewControllerWhenClickPushMessageWith:(NSDictionary *)msgDic{
    
    self.pushDic = [[NSMutableDictionary alloc]initWithDictionary:msgDic];
    
    //
    //    MainWebViewController *vc = [[MainWebViewController alloc]init];
    //
    //    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    
    if ([msgDic objectForKey:@"URL"]) {
        
        rootVC.urlStr = msgDic[@"URL"];
        
        //        [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
        
    }
    
    
}

#pragma mark -- 程序运行时收到通知
-(void)getPushMessageAtStateActive:(NSDictionary *)pushMessageDic{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                             message:[[pushMessageDic objectForKey:@"aps"]objectForKey:@"alert"]
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"查看"
                                                            style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                                
                                                                [self pushToViewControllerWhenClickPushMessageWith:pushMessageDic];
                                                            }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                                               
                                                           }];
    
    [alertController addAction:confirmAction];
    [alertController addAction:cancelAction];
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    
    
}


//判断状态 后台、前台、未打开


#pragma mark - to do Alipay
/*- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
 {
 
 //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
 if ([url.host isEqualToString:@"safepay"]) {
 [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
 //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
 NSLog(@"result = %@",resultDic);
 }];
 }
 if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
 
 [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
 //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
 NSLog(@"result = %@",resultDic);
 }];
 }
 return YES;
 }*/

#pragma mark - to do 与上面二选一
/*
 // NOTE: 9.0以后使用新API接口
 - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
 {
 if ([url.host isEqualToString:@"safepay"]) {
 // 支付跳转支付宝钱包进行支付，处理支付结果
 [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
 NSLog(@"result = %@",resultDic);
 }];
 
 // 授权跳转支付宝钱包进行支付，处理支付结果
 [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
 NSLog(@"result = %@",resultDic);
 // 解析 auth code
 NSString *result = resultDic[@"result"];
 NSString *authCode = nil;
 if (result.length>0) {
 NSArray *resultArr = [result componentsSeparatedByString:@"&"];
 for (NSString *subResult in resultArr) {
 if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
 authCode = [subResult substringFromIndex:10];
 break;
 }
 }
 }
 NSLog(@"授权结果 authCode = %@", authCode?:@"");
 }];
 }
 return YES;
 }
 */


#pragma mark - 网络状态变化 RongClond

/**
 *  网络状态变化。
 *
 *  @param status 网络状态。
 */
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"您"
                              @"的帐号在别的设备上登录，您被迫下线！"
                              delegate:nil
                              cancelButtonTitle:@"知道了"
                              otherButtonTitles:nil, nil];
        [alert show];
        
    }
}

- (void)didReceiveMessageNotification:(NSNotification *)notification {
    
    RCMessage *message = notification.object;
    if (message.messageDirection == MessageDirection_RECEIVE && [[message.content class] persistentFlag] & MessagePersistent_ISCOUNTED) {
        [UIApplication sharedApplication].applicationIconBadgeNumber =
        [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
    }
    
    //    [UIApplication sharedApplication].applicationIconBadgeNumber =
    //    [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
}

-(void)onResp:(BaseResp*)resp
{
    NSString *strMsg;
//    strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"%@",strMsg);
                //                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"%@",strMsg);
                
                break;
        }
    }
}
@end
