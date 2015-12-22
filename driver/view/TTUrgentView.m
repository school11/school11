//
//  TTUrgentView.m
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/21.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import "TTUrgentView.h"

@implementation TTUrgentView

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self ) {
        [self createUI];
    }
    return self;
}

-(void) createUI{
    
    
    
    //紧急收车  标题
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, 50)];
    titleLabel.text = @"紧急收车";
    titleLabel.font = [UIFont systemFontOfSize:19];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    //发生意外交通事故
    UILabel * trafficLabel = [[UILabel alloc] initWithFrame:CGRectMake(78, 65, 183, 33)];
    trafficLabel.text = @"发生意外交通事故";
    trafficLabel.font = [UIFont systemFontOfSize:14];
    trafficLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:trafficLabel];
    //发生意外的非人为事件
    UILabel * notMakeLabel = [[UILabel alloc] initWithFrame:CGRectMake(78, 110, 183, 33)];
    notMakeLabel.text = @"发生意外的非人为事件";
    notMakeLabel.font = [UIFont systemFontOfSize:14];
    notMakeLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:notMakeLabel];
    //其他
    UILabel * otherLabel = [[UILabel alloc] initWithFrame:CGRectMake(78, 155, 183, 33)];
    otherLabel.text = @"其他";
    otherLabel.font = [UIFont systemFontOfSize:14];
    otherLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:otherLabel];
    
    //发生紧急意外交通事件
    UIButton * trafficBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    trafficBtn.frame = CGRectMake(10, 61, 30, 30);
    [trafficBtn setBackgroundColor: [UIColor orangeColor]];
    [trafficBtn addTarget:self action:@selector(trafficClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:trafficBtn];
    //发生意外的非人为事件
    UIButton * notMakeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    notMakeBtn.frame = CGRectMake(10, 106, 30, 30);
    [notMakeBtn setBackgroundColor: [UIColor orangeColor]];
    [notMakeBtn addTarget:self action:@selector(notMakeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:notMakeBtn];
    //其他
    UIButton * otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    otherBtn.frame = CGRectMake(10, 152, 30, 30);
    [otherBtn setBackgroundColor: [UIColor orangeColor]];
    [otherBtn addTarget:self action:@selector(otherClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:otherBtn];
    //收车
    UIButton * pushCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pushCarBtn.frame = CGRectMake(8, 219, 253, 41);
    [pushCarBtn setBackgroundColor: [UIColor orangeColor]];
    [pushCarBtn setTitle:@"收车" forState:UIControlStateNormal];
    [pushCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [pushCarBtn addTarget:self action:@selector(pushCarClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:pushCarBtn];
    
    
}

-(void) trafficClick:(UIButton *)btn{
    NSLog(@"发生紧急意外交通事件");
}

-(void) notMakeClick:(UIButton *)btn{
    NSLog(@"发生意外的非人为事件");
}
-(void) otherClick:(UIButton *)btn{
    NSLog(@"其他");
}
-(void) pushCarClick:(UIButton *)btn{
    NSLog(@"收车");
}
@end
