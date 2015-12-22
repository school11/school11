//
//  TTSignalBuild.m
//  tiptimes_frame
//
//  Created by tiptimes on 14-9-4.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "TTSignalBuild.h"

@implementation TTSignalBuild{
    TTSignal *signal;
}

-(id)init{
    self= [super init];
    if(self){
        signal = [[TTSignal alloc] init];
    }
    return self;
}

-(instancetype) boolValue:(BOOL)bv{
    signal.booleanValue = bv;
    return self;
}

-(instancetype) action:(NSString *)str{
    signal.action = str;
    return self;
}
-(instancetype) doubleValue:(double)dv{
    signal.doubleValue = dv;
    return self;
}
-(instancetype) strValue:(NSString *)str{
    signal.strValue = str;
    return self;
}

-(instancetype) integerValue:(NSInteger)integer{
    signal.integerValue = integer;
    return self;
}

-(instancetype) dicValue:(NSDictionary *)dic{
    signal.dic = dic;
    return self;
}

-(instancetype) objectValue:(id)obj{
    signal.object = obj;
    return self;
}
-(instancetype) filterStr:(NSString *)fg{
    signal.filterStr = fg;
    return self;
}

-(TTSignal *) build{
    return signal;
}

+(TTSignalBuild *)signalBuild{
    return [[TTSignalBuild alloc] init];
}
@end
