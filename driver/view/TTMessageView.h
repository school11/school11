//
//  TTUrgentView.h
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/14.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTMessageView : UIView
@property(nonatomic,retain) NSString * uidStr;//司机的uid账号
@property(nonatomic,retain) NSMutableArray * dataSource;

@property(nonatomic,retain) NSMutableArray * peopleAddArr;//每个乘客的地址数组
@property(nonatomic,retain) NSMutableArray * addressArr;//起止地点的坐标的数组

@property(nonatomic,retain) UILabel * destinationLb;//起止点
@property(nonatomic,retain) NSString * startAddStr;//起点的名称
@property(nonatomic,retain) NSString * endAddStr;//终点的名称

@property(nonatomic,retain) NSString * timeStr;//订单时间
@property(nonatomic,retain) NSString * addString;


@end
