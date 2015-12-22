//
//  XTDownLoadFile.m
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-18.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "TTDownLoadFile.h"
#import "TTFileUntil.h"

@implementation TTDownLoadFile{
    UIProgressView *_progressView;
}
//-(void)downLoadWithUrl:(NSString *)url fileName:(NSString *)name delegate:(id)dele{
//    ASINetworkQueue   *que = [[ASINetworkQueue alloc] init];
//    self.netWorkQueue = que;
//    [self.netWorkQueue reset];
//    [self.netWorkQueue setShowAccurateProgress:YES];
//    [self.netWorkQueue go];
//    //初始化Documents路径
//    NSString *path = [TTFileUntil defaultFilePath];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if(![fileManager fileExistsAtPath:path]){
//        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    //初始下载路径
//    NSURL *Url = [NSURL URLWithString:url];
//    //设置下载路径
//    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:Url];
//    NSLog(@"路径%@", Url);
//    //设置ASIHTTPRequest代理
//    request.delegate = dele;
//    
//    
//    //初始化保存ZIP文件路径
//    NSString *savePath = [path stringByAppendingPathComponent:name];
//    NSLog(@"savePath=%@",savePath);
//    //初始化临时文件路径
//    NSString *tempPath = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.temp",name]];
//    //设置文件保存路径
//    [request setDownloadDestinationPath:savePath];
//    //设置临时文件路径
//    [request setTemporaryFileDownloadPath:tempPath];
//    //设置是是否支持断点下载
//    [request setAllowResumeForFileDownloads:YES];
//    request.showAccurateProgress=YES;
//    //5.下载完毕后通知
//    [request setCompletionBlock:^{
//        NSLog(@"文件已经下载完毕");
//     }];
//    [request setFailedBlock:^(void) {
//        NSLog(@"文件下载失败");
//    }];
//    //设置基本信息
//    [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:name,@"fileName",nil]];
//    NSLog(@"UserInfo=%@",request.userInfo);
//    //添加到ASINetworkQueue队列去下载
//    [self.netWorkQueue addOperation:request];
//
//}


-(void)downLoadWithUrl:(NSString *)url  fileName:(NSString *)name delegate:(id)dele{
    ASINetworkQueue *queue = [[ASINetworkQueue alloc] init];
    [queue reset];
    [queue setShowAccurateProgress:YES];
    [queue go];
    //初始化Documents路径
    NSString *path = [TTFileUntil defaultFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:path]){
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //初始下载路径
    NSURL *Url = [NSURL URLWithString:url];
    //设置下载路径
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:Url];
    NSLog(@"%@", Url);
    //设置ASIHTTPRequest代理
    request.delegate = dele;
    //初始化保存ZIP文件路径
    NSString *savePath = [path stringByAppendingPathComponent:name];
    NSLog(@"savePath=%@",savePath);
    //初始化临时文件路径
    NSString *tempPath = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.temp",name]];
    //设置文件保存路径
    [request setDownloadDestinationPath:savePath];
    //设置临时文件路径
    [request setTemporaryFileDownloadPath:tempPath];
    //设置是是否支持断点下载
    [request setAllowResumeForFileDownloads:YES];
    //设置下载进度追踪代理
    [request setDownloadProgressDelegate:dele];
    request.showAccurateProgress=YES;
    //5.下载完毕后通知
    [request setCompletionBlock:^{
        NSLog(@"文件已经下载完毕");
    }];
    [request setFailedBlock:^(void) {
        NSLog(@"文件下载失败");
    }];
    //设置基本信息
    [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:name,@"fileName",nil]];
    NSLog(@"UserInfo=%@",request.userInfo);
    //添加到ASINetworkQueue队列去下载
    [queue addOperation:request];
    
}





@end

