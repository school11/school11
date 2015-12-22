//
//  TTSignalListener.h
//  tiptimes_frame
//
//  Created by tiptimes on 14-9-4.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TTSignalListener <NSObject>
-(TTSignalHandleType)filterSignal:(TTSignal *)signal;
@end
