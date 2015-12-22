//
//  MailDao.m
//  xiante
//
//  Created by tiptimes on 14-8-17.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "MailDao.h"


@implementation MailDao
-(NSMutableArray *)findAll{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *ed = [NSEntityDescription entityForName:@"MailEntity" inManagedObjectContext:cxt];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:ed];
    
    NSError *error = nil;
    
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    
    NSMutableArray *reslistData = [[NSMutableArray alloc] init];
    
    for (MailEntity *mo in  listData){
        Demo_MailData *data = [[Demo_MailData alloc ]init];
        data.content = mo.content;
        data.from = mo.from;
        data.to = mo.to;
        data.flag = mo.flag;
        data.attachments = mo.attachments;
        data.subject = mo.subject;
        data.creatdate = mo.creatdate;
        [reslistData addObject:data];
    }
    
    return reslistData;

}
-(int) create:(Demo_MailData *)model{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    MailEntity *entity = [NSEntityDescription insertNewObjectForEntityForName:@"MailEntity" inManagedObjectContext:cxt];
    entity.content = model.content;
    entity.from = model.from;
    entity.to = model.to;
    entity.flag = model.flag;
    entity.attachments = model.attachments;
    entity.subject =model.subject;
    entity.creatdate= model.creatdate;
    
    NSError *saveingError = nil;
    if ([self.managedObjectContext save:&saveingError]){
        NSLog(@"插入数据成功！");
    }else{
        NSLog(@"插入数据失败");
        return -1;
    }
    
    return 0;

}
-(int) update:(Demo_MailData *)model{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    NSEntityDescription *ed = [NSEntityDescription entityForName:@"MailEntity" inManagedObjectContext:cxt];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:ed];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"creatdate = %@", model.creatdate];
    [request setPredicate:pre];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    if(listData.count > 0){
        MailEntity *entity = [listData lastObject];
        entity.content = model.content;
        entity.from = model.from;
        entity.to = model.to;
        entity.flag = model.flag;
        entity.attachments = model.attachments;
        entity.subject =model.subject;
        entity.creatdate = model.creatdate;
        
        NSError *se = nil;
        if([self.managedObjectContext save:&se]){
            NSLog(@"修改成功");
        }else{
           NSLog(@"修改失败");
            return -1;
        }
    }
    return 0;
}
-(int) remove:(Demo_MailData *)model{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    NSEntityDescription *ed = [NSEntityDescription entityForName:@"MailEntity" inManagedObjectContext:cxt];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:ed];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"creatdate = %@", model.creatdate];
    [request setPredicate:pre];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    if(listData.count > 0){
        MailEntity *entity = [listData lastObject];
        [self.managedObjectContext deleteObject:entity];
        
        NSError *se = nil;
        if([self.managedObjectContext save:&se]){
            NSLog(@"删除成功");
        }else{
            NSLog(@"删除失败");
            return -1;
        }
    }
    return 0;
}
-(NSMutableArray *)findTrashMail{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *ed = [NSEntityDescription entityForName:@"MailEntity" inManagedObjectContext:cxt];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:ed];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"flag = %@", "sss"];
    [request setPredicate:pre];
    [request setEntity:ed];
    
    NSError *error = nil;
    
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    
    NSMutableArray *reslistData = [[NSMutableArray alloc] init];
    
    for (MailEntity *mo in  listData){
        Demo_MailData *data = [[Demo_MailData alloc ]init];
        data.content = mo.content;
        data.from = mo.from;
        data.to = mo.to;
        data.flag = mo.flag;
        data.attachments = mo.attachments;
        data.subject = mo.subject;
        data.creatdate = mo.creatdate;
        [reslistData addObject:data];
    }
    
    return reslistData;

}

-(NSMutableArray *)findDraftsMail{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *ed = [NSEntityDescription entityForName:@"MailEntity" inManagedObjectContext:cxt];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:ed];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"flag = %@", @"ss"];
    [request setPredicate:pre];
    [request setEntity:ed];
    
    NSError *error = nil;
    
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    
    NSMutableArray *reslistData = [[NSMutableArray alloc] init];
    
    for (MailEntity *mo in  listData){
        Demo_MailData *data = [[Demo_MailData alloc ]init];
        data.content = mo.content;
        data.from = mo.from;
        data.to = mo.to;
        data.flag = mo.flag;
        data.attachments = mo.attachments;
        data.subject = mo.subject;
        data.creatdate = mo.creatdate;
        [reslistData addObject:data];
    }
    
    return reslistData;
}

-(NSMutableArray *)findSendsMail{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *ed = [NSEntityDescription entityForName:@"MailEntity" inManagedObjectContext:cxt];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:ed];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"flag = %@", @"ss"];
    [request setPredicate:pre];
    [request setEntity:ed];
    
    NSError *error = nil;
    
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    
    NSMutableArray *reslistData = [[NSMutableArray alloc] init];
    
    for (MailEntity *mo in  listData){
        Demo_MailData *data = [[Demo_MailData alloc ]init];
        data.content = mo.content;
        data.from = mo.from;
        data.to = mo.to;
        data.flag = mo.flag;
        data.attachments = mo.attachments;
        data.subject = mo.subject;
        data.creatdate = mo.creatdate;
        [reslistData addObject:data];
    }
    
    return reslistData;
}
@end
