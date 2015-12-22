//
//  XTContractData.h
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-17.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "CoreDataDao.h"


@interface Demo_ContractData :TTBaseDateModel
@property (nonatomic, strong) NSString * department;
@property (nonatomic, strong) NSString * role;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, copy) NSString *namePinyin;

@property (nonatomic, strong) NSString * subset;
@property (nonatomic, strong) NSString * telephone;
@property (nonatomic, strong) NSString * mobilephone;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong)NSString *departmentOrder;
@property(nonatomic ,strong) NSString *userOrder;

@end
