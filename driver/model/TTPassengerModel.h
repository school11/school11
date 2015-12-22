//
//  TTPassengerModel.h
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/15.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTPassengerModel : NSObject

@property(nonatomic,retain) NSString * uidStr;//乘客uid
@property(nonatomic,retain) NSString * nameStr;//乘客名字
@property(nonatomic,retain) NSString * teleStr;//乘客电话号码
@property(nonatomic,assign) NSString * isPay;//乘客是否支付
@property(nonatomic,retain) NSString * payTimeStr;//乘客支付时间
@property(nonatomic,retain) NSString * payMoney;//乘客所支付钱数
@property(nonatomic,assign) BOOL isOn;//乘客是否上车
@property(nonatomic,retain) NSString * coordStr;//乘客所在经纬度
@property(nonatomic,retain) NSString * addressStr;//乘客所在地址名称

@end
