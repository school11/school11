//
//  TTTestViewController.h
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/12.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import "TTBaseViewController.h"

@interface TTTestViewController : TTBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray *imgArry;

@property(nonatomic,strong)NSArray *titileArray;





//
@property(nonatomic,retain) NSString * uidStr;//司机的uid账号
@property(nonatomic,retain) NSString * typeStr;
@property(nonatomic,retain) NSString * directionStr;

@property(nonatomic,retain) NSMutableArray * isOnArr;
@property(nonatomic,retain) NSMutableArray * isPayArr;

@property(nonatomic,retain) NSMutableArray * schoolArr;
@property(nonatomic,retain) NSMutableArray * subwayArr;



@end
