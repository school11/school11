//
//  ContactEntity.h
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-17.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ContactEntity : NSManagedObject

@property (nonatomic, retain) NSString * department;
@property (nonatomic, retain) NSString * role;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * subset;
@property (nonatomic, retain) NSString * telephone;
@property (nonatomic, retain) NSString * mobilephone;
@property (nonatomic, retain) NSString * email;

@property (nonatomic, retain)NSString *departmentOrder;
@property(nonatomic ,retain) NSString *userOrder;

@end
