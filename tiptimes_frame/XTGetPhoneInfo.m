//
//  XTGetPhoneInfo.m
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-15.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "XTGetPhoneInfo.h"
#import "UIDevice+IdentifierAddition.h"

@implementation XTGetPhoneInfo
+(NSString *)getDeviceId{
    return  [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier];
}
@end
