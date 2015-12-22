#import <Foundation/Foundation.h>


@interface ImapReader : NSObject
{
}

@property (nonatomic, retain) NSData *data;
@property (nonatomic, assign) int pos;

- (id) initWithData:(NSData *)data;

- (bool) eof;
- (char) currentChar;
- (bool) nextChar;
- (bool) skip:(int)length;
- (bool) skipChar:(char)c;
- (bool) skipSpaces;
- (NSData *) readData:(int)length;
- (NSString *) readStringUntil:(char)c;
- (NSString *) readStringUntilSet:(NSCharacterSet *)set;
- (NSString *) readString;
- (NSString *) readQuotedString;
- (NSNumber *) readNumber;

@end