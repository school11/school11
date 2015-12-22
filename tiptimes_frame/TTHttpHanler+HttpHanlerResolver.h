//
//  TTHttpHanler+HttpHanlerResolver.h
//  tiptimes_frame
//
//  Created by tiptimes on 14-11-19.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "TTHttpHanler.h"
#import "MJExtension.h"
#import "TTNoData.h"

@interface TTHttpHanler (HttpHanlerResolver)

-(void) httpHanlerWithUrl:(NSString *) url  param:(NSDictionary *)param datatype:(id) type notifName:(NSString *)notif;

-(void) httpHanlerWithUrl:(NSString *) url action:(NSString *)action  param:(NSDictionary *)param datatype:(id) type notifName:(NSString *)notif;

@end
