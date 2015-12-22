//
//  ContractDao.h
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-17.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "CoreDataDao.h"
#import "Demo_ContractData.h"

@interface ContractDao : CoreDataDao

-(NSMutableArray *)findAll;
-(int) create:(Demo_ContractData *)model;
-(int) removeAll;
@end
