//
//  KWOfficeApi.h
//  KingsoftOfficeSDK
//
//  Created by tang feng on 14-3-18.
//  Copyright (c) 2014年 KingSoft Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@protocol KWOfficeApiDelegate <NSObject>

@required

#pragma mark - wps回传文件数据
- (void)KWOfficeApiDidReceiveData:(NSDictionary*)dict;

#pragma mark - wps编辑完成返回 结束与WPS链接
- (void)KWOfficeApiDidFinished;

#pragma mark - 非正常退出
-(void)KWOfficeApiDidAbort;

#pragma mark - 断开链接
- (void)KWOfficeApiDidCloseWithError:(NSError*)error;

@end


#pragma mark -
@interface KWOfficeApi : NSObject

@property(nonatomic,assign)id <KWOfficeApiDelegate>delegate;

#pragma mark - 实例化接口
+(id)sharedInstance;

#pragma mark - 设置链接端口 默认端口：9616
+ (void)setPort:(NSInteger)port;

#pragma mark - 设置打印日志
+ (void)setDebugMode:(BOOL)debugMode;

#pragma mark - 注册App
+(void)registerApp:(NSString *)keyStr;

#pragma mark - setApplicationDidEnterBackground
-(BOOL)setApplicationDidEnterBackground:(UIApplication *)application;

#pragma mark - 设置文件data(NSData)、文件名fileName，切换回第三方App的URL名(callback), 操作文件权限(rightsDict)，并启动wps链接
-(BOOL)sendFileData:(NSData *)data withFileName:(NSString *)fileName callback:(NSString *)callback delegate:(id)delegate policy:(NSDictionary *)rightsDict error:(NSError **)errPtr;

@end
