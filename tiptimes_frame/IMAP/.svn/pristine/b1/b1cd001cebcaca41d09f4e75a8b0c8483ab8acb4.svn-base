#import <Foundation/Foundation.h>
#import "ImapBodypart.h"


@interface ImapMessage : NSObject
{
	NSMutableDictionary *headers;
	ImapBodypart *bodyStructure;
}

@property (nonatomic, assign) int sequenceNumber;
@property (nonatomic, assign) int uid;
@property (nonatomic, retain) ImapBodypart *bodyStructure;
@property (nonatomic, readonly) NSDate *date;
@property (nonatomic, readonly) NSString *from;
@property (nonatomic, readonly) NSArray *fromAddresses;
@property (nonatomic, readonly) NSString *subject;

- (void) addImapContent:(NSDictionary *)dictionary;
- (ImapBodypart *) findContentPart;
- (NSArray *) findAttachments;
- (NSString *) codeForPart:(ImapBodypart *)part;

@end


