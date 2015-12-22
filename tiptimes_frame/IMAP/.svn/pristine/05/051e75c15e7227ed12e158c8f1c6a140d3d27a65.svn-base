#import <Foundation/Foundation.h>
#import "ImapFetchObject.h"


@interface ImapBodypart : NSObject
{
}

@property (nonatomic, retain) NSString *multipartType;
@property (nonatomic, retain) NSArray *multipartList;

@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *subtype;
@property (nonatomic, retain) NSDictionary *parameters;
@property (nonatomic, retain) NSString *contentId;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *encoding;
@property (nonatomic, assign) int size;

@property (nonatomic, retain) NSData *data;

@property (nonatomic, readonly) NSString *contentType;

- (bool) read:(ImapFetchObject *)src;
- (NSString *) stringWithCharset;
- (NSData *) dataWithCharset;

@end