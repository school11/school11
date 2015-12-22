//
//  PiPeiCz.m
//  tiptimes_frame
//
//  Created by ycf on 15/12/15.
//  Copyright © 2015年 ycf. All rights reserved.
//

#import "PiPeiCz.h"

@implementation PiPeiCz

-(id)initWithDictionry:(NSDictionary *)fromDic  Todic:(NSDictionary *)todic
{
    self = [super init];
    if (self) {
        self.Faddress = [fromDic objectForKey:@"address"];
        self.FLatitude = [fromDic objectForKey:@"latitude"];
        self.Flongitude = [fromDic objectForKey:@"longitude"];
        self.Taddress = [todic objectForKey:@"address"];
        self.Tlati = [todic objectForKey:@"latitude"];
        self.Tlong = [todic objectForKey:@"longitude"];
        self.tId = [fromDic objectForKey:@"id"];
        self.fromId = [todic objectForKey:@"id"];
        
    }
    
    return self;
}
@end
