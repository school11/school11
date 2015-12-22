//
//  XTAppDelegate.m
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-14.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "TTAppDelegate.h"
#import "ContractDao.h"
#import "APService.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import "IQKeyBoardManager.h"
#import "IQSegmentedNextPrevious.h"
#import "TTUser.h"
#import "TTBaseViewController.h"
#import "TTJumpViewController.h"

#import "TTDoString.h"

#import "TTTestViewController.h"

#import "TTDoString.h"
#import "iflyMSC/IFlyMSC.h"
#import "Definition.h"

static NSString *filename;
@implementation TTAppDelegate{
    NSString *key_id;
    NSString *if_push;
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    

    _tMainVC = [[TTTestViewController alloc] init];
    //取消icon角标  取消本地通知
    application.applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    
    //设置顶部状态栏字体为白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //键盘自适应,防止遮挡
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    //微信,朋友圈
    //[UMSocialData setAppKey:@"5549cc9c67e58e114400288e"];
    [UMSocialWechatHandler setWXAppId:@"wxc43f8bfea4f53f50" appSecret:@"8e83356b5f3182d51f9a6ae882fb425c" url:@"http://www.tiptimes.com"];
    //qq，qq空间
    [UMSocialQQHandler setQQWithAppId:@"1104716639" appKey:@"Lx7iyyI8bc9ZUvqG" url:@"http://www.tiptimes.com"];
    
//极光推送
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];
    
    //设置sdk的log等级，log保存在下面设置的工作路径中
    [IFlySetting setLogFile:LVL_ALL];
    
    //打开输出在console的log开关
    [IFlySetting showLogcat:YES];
    
    //设置sdk的工作路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    [IFlySetting setLogFilePath:cachePath];
    
    //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID_VALUE];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
    

    

    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
    NSLog(@"111");
    NSString* codeStr;
    if (notification)
    {
        NSLog(@"Recieved Notification %@",notification);
        NSDictionary* infoDic = notification.userInfo;
        NSLog(@"userInfo description=%@",[infoDic description]);
        codeStr = [infoDic objectForKey:@"key"];
        key_id = codeStr;
        NSLog(@"codeStr %@",codeStr);
    }
    
    // 应用正处理前台状态下，不会收到推送消息，因此在此处需要额外处理一下
    NSLog(@"ZHUANGTAI:%ld",(long)application.applicationState);
    if (application.applicationState == UIApplicationStateActive) {
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"备忘提醒" message:notification.alertBody delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定",nil];
        [view show];
    }else{
        
    }
    
    application.applicationIconBadgeNumber -= 1;
    
    //3、取消一个本地推送
    UIApplication *app = [UIApplication sharedApplication];
    //获取本地推送数组
    NSArray *localArr = [app scheduledLocalNotifications];
    
    //声明本地通知对象
    UILocalNotification *localNoti;
    
    if (localArr) {
        for (UILocalNotification *noti in localArr) {
            NSDictionary *dict = noti.userInfo;
            if (dict) {
                NSString *inKey = [dict objectForKey:@"key"];
                if ([inKey isEqualToString:codeStr]) {
                    if (localNoti){
                        localNoti = nil;
                    }
                    break;
                }
            }
        }
        
        //判断是否找到已经存在的相同key的推送
        if (!localNoti) {
            //不存在 初始化
            localNoti = [[UILocalNotification alloc] init];
        }
        
        if (localNoti) {
            //不推送 取消推送
            [app cancelLocalNotification:localNoti];
            return;
        }
    }
    
}

//弹出框委托协议
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
       // NSLog(@"数字：%ld",(long)buttonIndex);
       if(buttonIndex == 1){
        
       }
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//        [[KWOfficeApi sharedInstance] setApplicationDidEnterBackground:application];//必须使用
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        [application setApplicationIconBadgeNumber:0];

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
       //at     [[NSNotificationCenter defaultCenter] postNotificationName:APPFORE object:nil];
    NSLog(@"%@", @"applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

//友盟
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"dataCore" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"dataCore.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"__ceshi___%@",deviceToken);
    // Required
    [APService registerDeviceToken:deviceToken];
}


////点击消息后执行
//-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo
//completionHandler:(void (^)())completionHandler {
//    _isLaunchedByNotification = YES;
//    [APService handleRemoteNotification:userInfo];
//    NSLog(@"收到通知:%@",userInfo);
//    
//    
//    [self networkDidReceiveMessageWithUserInfo:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
//}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"error:::%@", error);
}
#pragma mark -
//avoid compile error for sdk under 7.0
#ifdef __IPHONE_7_0
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    
   
    
    
    
    
    [self networkDidReceiveMessageWithUserInfo:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
#endif
- (void)networkDidSetup:(NSNotification *)notification {

    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification {

    NSLog(@"未连接。。。");
}

- (void)networkDidRegister:(NSNotification *)notification {

    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {
    NSLog(@"已登录");
}

- (void)networkDidReceiveMessageWithUserInfo:(NSDictionary *)userInfo {
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
//    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
//    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    NSString *id = [userInfo valueForKey:@"id"];
    NSString * type = [userInfo valueForKey:@"type"];
    NSLog(@"content =[%@], id=[%@], type=[%@]",content,id,type);
    
    //点开通知跳转到指定页面
    NSLog(@"收到通知:%@",userInfo);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[TTJumpViewController storyName] bundle:nil];
    UIViewController * viewController;
    if([type integerValue]==1){
        viewController = [storyboard instantiateViewControllerWithIdentifier:@"TieziViewController"];
    }else{
        viewController = [storyboard instantiateViewControllerWithIdentifier:@"WtxqViewController"];
    }
    if([TTBaseViewController getNav] == nil){
        NSLog(@"没有配置导航控制器!");
        return ;
    }
    [TTDoString setIfTs:1];
    [TTDoString setId:[id intValue]];
    [[TTBaseViewController getNav] pushViewController:viewController animated:YES];
    
    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_APNS object:userInfo];
}


- (void)networkDidReceiveMessage:(NSNotification *)notification1 {

}

//#pragma mark - KWOfficeApi delegate
////wps回传文件数据
//-(void)KWOfficeApiDidReceiveData:(NSDictionary *)dict
//{
//    //解析file数据
//    NSData *fileData = [dict objectForKey:@"Body"];
//    if(filename !=nil){
//  //       [self writeFile:[[XTFileUntil defaultFilePath] stringByAppendingPathComponent:filename] writeData:fileData];
//    }
// //   XTCommData *data = [[XTCommData alloc] init];
// //   data.boolValue = YES;
// //   [[NSNotificationCenter defaultCenter] postNotificationName:NOTIC_WPS object:data userInfo:nil];
//}
//
////wps编辑完成返回 结束与WPS链接
//- (void)KWOfficeApiDidFinished
//{
//    NSLog(@"wps编辑完成返回 结束与WPS链接");
//}
//
////wps退出后台
//- (void)KWOfficeApiDidAbort
//{
//    NSLog(@"wps编辑结束，并退出后台");
//}
////断开链接
//- (void)KWOfficeApiDidCloseWithError:(NSError*)error
//{
//    NSLog(@"错误 与 wps 断开链接 %@",error);
//}


//#pragma mark - 写本地文件
//
//
//
////nsdata转文件
//-(BOOL)writeFile:(NSString *)path writeData:(NSData *)data{
//    BOOL isSuccess=[data writeToFile:path atomically:NO];
//    return isSuccess;
//}
//
//-(void)KWAOfficepiDidCloseWithError:(NSError *)error
//{
//    NSLog(@"DemoOa 的 KWOfficeApi 断开");
//}
//
//#pragma mark - 进入wps
//- (void)runWpsExcelAppEvent:(NSNotification*)notification
//{
////    NSString *path = [XTFileUntil defaultFilePathWithName:notification.object];
////    NSData *data = [NSData dataWithContentsOfFile:path];
////    if (data == nil)
////        return;
////    
////    NSError *error = nil;
////    BOOL isOk = [[KWOfficeApi sharedInstance] sendFileData:data
////                                              withFileName:path.lastPathComponent
////                                                  callback:nil
////                                                  delegate:self
////                                                    policy:@{@"et.document.iseditmode":@"1",@"et.document.isLockSaveAs":@"1" }
////                                                     error:&error];
////    if (isOk) {
////        NSLog(@"进入wps app");
////    }
////    else
////    {
////        NSLog(@"进入wps app 失败 %@", error);
////        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请确定安装了wps企业版" delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles: nil];
////        [alertView show];
////    }
//}
//
//- (void)runWpsPPTAppEvent:(NSNotification*)aNotification
//{
////    NSBundle *bundle = [NSBundle mainBundle];
////    NSString *path = [bundle pathForResource:@"休闲时光" ofType:@"ppt"];
////    NSData *data = [NSData dataWithContentsOfFile:path];
////    if (data == nil)
////        return;
////    
////    NSError *error = nil;
////    BOOL isOk = [[KWOfficeApi sharedInstance] sendFileData:data
////                                              withFileName:path.lastPathComponent
////                                                  callback:nil
////                                                  delegate:self
////                                                    policy:@{@"ppt.document.iseditmode":@"1", @"ppt.document.isLockSaveAs":@"1"}
////                                                     error:&error];
////    if (isOk) {
////        NSLog(@"进入wps app");
////    }
////    else
////    {
////        NSLog(@"进入wps app 失败 %@", error);
////    }
//}
//
//-(void)runWpsAppEvent:(NSNotification *)notification
//{
//    NSString *path = [TTFileUntil defaultFilePathWithName:notification.object];
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    if (data == nil)
//        return;
//    
//    NSError *error = nil;
//    BOOL isOk = [[KWOfficeApi sharedInstance] sendFileData:data
//                                              withFileName:path.lastPathComponent
//                                                  callback:nil
//                                                  delegate:self
//                                                    policy:@{
//                                                             @"wps.document.iseditmode": @"0",
//                                                             @"wps.document.isLockSaveAs":@"0",
//                                                             @"wps.document.localization":@"0",
//                                                             }
//                                                     error:&error];
//    if (isOk) {
//        NSLog(@"进入wps app");
//        filename = notification.object;
//    }
//    else
//    {
//        TTCommData *d = [[TTCommData alloc] init];
//        d.booleanValue = NO;
//        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIC_WPS object:d userInfo:nil];
//        NSLog(@"进入wps app 失败 %@", error);
//
//    }
//}





@end
