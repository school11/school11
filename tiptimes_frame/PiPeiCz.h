//
//  PiPeiCz.h
//  tiptimes_frame
//
//  Created by ycf on 15/12/15.
//  Copyright © 2015年 ycf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PiPeiCz : NSObject

@property (nonatomic,strong)NSString *Faddress;
@property (nonatomic,strong)NSString *FLatitude;
@property (nonatomic,strong)NSString *Flongitude;
@property (nonatomic,strong)NSString *Taddress;
@property (nonatomic,strong)NSString *Tlati;
@property (nonatomic,strong)NSString *Tlong;
@property (nonatomic,strong)NSString *Price;
@property (nonatomic,strong)NSString *tId;
@property (nonatomic,strong)NSString *fromId;

-(id)initWithDictionry:(NSDictionary *)fromDic  Todic:(NSDictionary *)todic;
@end
