//
//  TTSignal.h
//  tiptimes_frame
//
//  Created by tiptimes on 14-9-4.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef   enum{
    unhandle,
    handleRemove,
    handleRemain
}TTSignalHandleType;



@interface TTSignal : NSObject
@property(assign, nonatomic) BOOL booleanValue;
@property(assign, nonatomic) double doubleValue;
@property(copy, nonatomic) NSString *strValue;
@property(assign, nonatomic) NSInteger integerValue;
@property(copy, nonatomic) NSString *action;
@property(copy, nonatomic) NSDictionary *dic;
@property(weak, nonatomic) id object;


@property(copy, nonatomic) NSString *filterStr;
@property(assign, nonatomic) int distrCount;


@end
