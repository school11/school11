//
//  XTFileUntil.m
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-19.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "TTFileUntil.h"

@implementation TTFileUntil
+(BOOL)  fileExistsWithDefaultPath:(NSString *)fileName{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/tp"];
    NSString *savePath = [path stringByAppendingPathComponent:fileName];
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断文件是否存在
    BOOL fileExists = [fileManager fileExistsAtPath:savePath];
    return fileExists;
}

+(NSString *)defaultFilePath{
    NSString *path =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/tp"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:path]){
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}
+(NSString *)defaultFilePathWithName:(NSString *)fileName{
    NSString *path = [self defaultFilePath];
    return  [path stringByAppendingPathComponent:fileName];
}

+(NSString *)lastFileName:(NSString *)filePath{
    NSArray *arrayStr = [filePath componentsSeparatedByString:@"/"];
    return  [arrayStr objectAtIndex:[arrayStr count]-1];
}

+(NSString *)fileType:(NSString *)filenName{
    NSArray *arrayStr = [filenName componentsSeparatedByString:@"."];
    if([arrayStr count] >0){
        return [arrayStr objectAtIndex:[arrayStr count]-1];
    }else{
        return  @"";
    }
}
@end
