
//
//  Header.h
//  xiante
//
//  Created by tiptimes on 14-7-5.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#ifndef xiante_Header_h
#define xiante_Header_h
#define compeletUrl(a) [XTHttpUtilURL compeletUrl:a]



#define filter(flags)\
-(int)filterSignal:(TTSignal *)signal{\
    NSLog(@"信号源%@",signal.filterStr);\
    NSLog(@"flags%@",flags);\
    if([signal.filterStr isEqualToString:flags]){\
        NSLog(@"到了吗%@",signal.filterStr);\
        return [self handleSignal:signal]; \
    }else{\
        NSLog(@"没到%@",signal.filterStr);\
        return unhandle;\
    }\
}

#define S  [TTSignalManager sharedManager]
#endif
