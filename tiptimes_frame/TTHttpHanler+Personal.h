//
//  XTHttpHanler+Personal.h
//  xiante
//
//  Created by tiptimes on 14-7-31.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "TTHttpHanler.h"

@interface TTHttpHanler (Personal)

-(void)personalWith:(NSDictionary*)param notifName :(NSString *) notif ;
-(void) personalNicknameWith:(NSDictionary *)param  notifName : (NSString *) notif;
-(void)personalHeadPictureWith:(NSDictionary*)param notifName :(NSString *) notif files:(NSDictionary *) file ;

@end
