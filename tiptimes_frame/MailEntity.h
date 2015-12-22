//
//  MailEntity.h
//  xiante
//
//  Created by tiptimes on 14-8-17.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MailEntity : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * from;
@property (nonatomic, retain) NSString * to;
@property (nonatomic, retain) NSString * flag;
@property (nonatomic, retain) NSString * attachments;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSString * creatdate;

@end
