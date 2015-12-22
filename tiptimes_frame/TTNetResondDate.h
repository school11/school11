//
//  XTNetResondDate.h
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-15.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTNetResondDate : NSObject
@property (assign , nonatomic) BOOL isNormal;
@property (strong, nonatomic) NSString *action;
@property (strong, nonatomic) NSString *msg;
@property (strong, nonatomic) NSDictionary *respondDate;
@property (strong, nonatomic) id respondObject;
@end
