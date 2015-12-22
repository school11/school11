#import <Foundation/Foundation.h>

@interface ImapConnection : NSObject <NSStreamDelegate>
{
	NSInputStream *inputStream;
	NSOutputStream *outputStream;
	NSMutableArray *writeQueue;
	bool passedWrite;
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, readonly) bool connected;
@property (nonatomic, readonly) bool connecting;

- (void) connectToHost:(NSString *)host port:(int)port useSSL:(bool)useSSL;
- (void) write:(NSData *)data;
- (void) close;

@end
