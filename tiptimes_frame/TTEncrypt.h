//
//  TTEncrypt.h
//  tiptimes_frame
//
//  Created by tiptimes on 15-4-13.
//  Copyright (c) 2015年 tiptimes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTEncrypt : NSObject
+(NSString *) parse:(NSString *)url parameterMap:(NSDictionary *)dic ;
+(NSMutableDictionary *)parseToNSDictionary:(NSArray *)arr ; 


@end
