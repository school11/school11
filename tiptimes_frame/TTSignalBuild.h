//
//  TTSignalBuild.h
//  tiptimes_frame
//
//  Created by tiptimes on 14-9-4.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTSignalBuild : NSObject
+(TTSignalBuild *)signalBuild;

-(instancetype) boolValue:(BOOL)bv;
-(instancetype) doubleValue:(double)dv;
-(instancetype) strValue:(NSString *)str;
-(instancetype) integerValue:(NSInteger)integer;
-(instancetype) action:(NSString *)str;
-(instancetype) objectValue:(id)obj;
-(instancetype) filterStr:(NSString *)fg;
-(instancetype) dicValue:(NSDictionary *)dic;

-(TTSignal *) build;

@end
