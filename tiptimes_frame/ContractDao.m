//
//  ContractDao.m
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-17.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "ContractDao.h"
#import "ContactEntity.h"

@implementation ContractDao
-(NSMutableArray *)findAll{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *ed = [NSEntityDescription entityForName:@"ContactEntity" inManagedObjectContext:cxt];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:ed];
    
    NSError *error = nil;
    
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    
    NSMutableArray *reslistData = [[NSMutableArray alloc] init];
    
    for (ContactEntity *mo in  listData){
        Demo_ContractData *data = [[Demo_ContractData alloc ]init];
        data.department = mo.department;
        data.role = mo.role;
        data.name = mo.name;
        data.subset = mo.subset;
        data.telephone = mo.telephone;
        data.mobilephone = mo.mobilephone;
        data.email = mo.email;
        data.userOrder = mo.userOrder;
        data.departmentOrder = mo.departmentOrder;
        [reslistData addObject:data];
    }
    
    return reslistData;
}

-(int) create:(Demo_ContractData *)model{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    ContactEntity *entity = [NSEntityDescription insertNewObjectForEntityForName:@"ContactEntity" inManagedObjectContext:cxt];
    entity.department = model.department;
    entity.role = model.role;
    entity.name = model.name;
    entity.subset = model.subset;
    entity.telephone = model.telephone;
    entity.mobilephone = model.mobilephone;
    entity.email = model.email;
    entity.departmentOrder = model.departmentOrder;
    entity.userOrder  = model.userOrder;
    
    NSError *saveingError = nil;
    if ([self.managedObjectContext save:&saveingError]){
        NSLog(@"插入数据成功！");
    }else{
        NSLog(@"插入数据失败");
        return -1;
    }
    
    return 0;
}
-(int)removeAll{
    int flag = 0;
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ContactEntity" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:entity];
    NSError *error = nil;
    NSArray *datas = [context executeFetchRequest:request error:&error];
    if (!error && datas && [datas count]){
        for (NSManagedObject *obj in datas){
            [context deleteObject:obj];
            flag++;
        }
        if (![context save:&error]){
            NSLog(@"error:%@",error);
        }
    }
    
    return flag;
}

@end
