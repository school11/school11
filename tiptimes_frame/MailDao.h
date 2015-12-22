//
//  MailDao.h
//  xiante
//
//  Created by tiptimes on 14-8-17.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "CoreDataDao.h"
#import "Demo_MailData.h"
#import "MailEntity.h"
@interface MailDao : CoreDataDao
-(NSMutableArray *)findAll;
-(int) create:(Demo_MailData *)model;
-(int) update:(Demo_MailData *)model;
-(int) remove:(Demo_MailData *)model;
-(NSMutableArray *)findDraftsMail;
-(NSMutableArray *)findSendsMail;
-(NSMutableArray *)findTrashMail;
@end
