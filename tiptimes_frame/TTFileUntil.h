//
//  XTFileUntil.h
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-19.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTFileUntil : NSObject
+(BOOL)  fileExistsWithDefaultPath:(NSString *)fileName;
+(NSString *)defaultFilePathWithName:(NSString *)fileName;

+(NSString *)lastFileName:(NSString *)filePath;
+(NSString *)fileType:(NSString *)filenName;
+(NSString *)defaultFilePath;
@end
