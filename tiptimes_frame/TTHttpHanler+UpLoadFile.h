//
//  TTHttpHanler+UpLoadFile.h
//  tiptimes_frame
//
//  Created by tiptimes on 15/11/18.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import "TTHttpHanler.h"
#import "MJExtension.h"

@interface TTHttpHanler (UpLoadFile)
//上传多个文件无action
-(void)httpHanlerWithUrl:(NSString *) url param:(NSDictionary*)param datatype:(id) type  notifName :(NSString *) notif files:(NSDictionary *)file;
//上传多个文件有action
-(void)httpHanlerWithUrl:(NSString *) url param:(NSDictionary*)param  action:(NSString *)ac datatype:(id) type  notifName :(NSString *) notif files:(NSDictionary *)file;

@end
