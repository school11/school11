//
//  TTSignalManager.h
//  tiptimes_frame
//
//  Created by tiptimes on 14-9-4.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTSignalListener.h"

@interface TTSignalManager : NSObject
+ (instancetype)sharedManager;

-(void)sendSignal:(TTSignal *)signal;

-(void) addSignalListener:(id<TTSignalListener>)  obj;

-(void) removeSignalListener:(id<TTSignalListener>)  obj;
@end
