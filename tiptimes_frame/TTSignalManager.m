//
//  TTSignalManager.m
//  tiptimes_frame
//
//  Created by tiptimes on 14-9-4.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "TTSignalManager.h"


@implementation TTSignalManager{
    NSMutableArray *signaListener;
    NSMutableArray *signals;
}
+ (instancetype)sharedManager{
    static id instance = nil;
    static dispatch_once_t onceToken = 0l;
    dispatch_once(&onceToken, ^{
        instance = [[TTSignalManager alloc] init];
    });
    return instance;
}

-(id)init{
    self = [super init];
    if(self){
        signaListener = [[NSMutableArray alloc] initWithCapacity:20];
        signals = [[NSMutableArray alloc] initWithCapacity:20];
    }
    return self;
}



-(void)sendSignal:(TTSignal *)signal{
    BOOL remainflag = YES;
    for(NSValue *listenerValue in signaListener){
        id<TTSignalListener> listener = [listenerValue nonretainedObjectValue];
        TTSignalHandleType type = [listener filterSignal:signal];
        if(type == unhandle){
            continue;
        }else if(type == handleRemove){
            remainflag = NO;
            break;
        }else{
            signal.distrCount++;
        }
    }
    
    if(remainflag == YES){
        [signals addObject:signal];
    }
}

-(void) addSignalListener:(id<TTSignalListener>) obj{
    NSValue *value = [NSValue valueWithNonretainedObject:obj];
    [signaListener addObject:value];
    NSMutableArray *removeSignals = [[NSMutableArray alloc] initWithCapacity:1];
    
    for(TTSignal *signal in signals){
        TTSignalHandleType type = [obj filterSignal:signal];
        if(type == unhandle){
            continue;
        }else if(type == handleRemove){
            [removeSignals addObject:signal];
        }else{
            signal.distrCount++;
        }
    }
    
    [signals removeObjectsInArray:removeSignals];
}

-(void) removeSignalListener:(id<TTSignalListener>) obj{
    int i;
    for(i=0; i<signaListener.count; i++){
        id<TTSignalListener> listener = [[signaListener objectAtIndex:i] nonretainedObjectValue];
        if(listener == obj){
            break;
        }
    }
    if(i<signaListener.count){
        [signaListener removeObjectAtIndex:i];
    }
}


@end