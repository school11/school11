//
//  XTDownLoadFile.h
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-18.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
@interface TTDownLoadFile : NSObject
@property ASINetworkQueue *netWorkQueue;

//-(void)downLoadWithUrl:(NSString *)url  fileName:(NSString *)fn delegate:(id)dele;
-(void)downLoadWithUrl:(NSString *)url  fileName:(NSString *)fn delegate:(id)dele;
@end
