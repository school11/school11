#import "ImapReader.h"


@implementation ImapReader

@synthesize data;
@synthesize pos;

- (id) initWithData:(NSData *)d
{
	if ((self = [super init]))
	{
		self.data = d;
	}
	return self;
}

- (void) dealloc
{
	[data release];
	[super dealloc];
}

- (bool) eof
{
	return (pos >= data.length);
}

- (char) currentChar
{
	if (pos >= data.length)
		return 0;
	return ((char *)data.bytes)[pos];
}

- (bool) nextChar
{
	if (pos >= data.length)
		return false;
	pos++;
	return true;
}

- (bool) skip:(int)length
{
	if (pos + length > data.length)
		return false;
	pos += length;
	return true;
}

- (bool) skipChar:(char)c
{
	if ([self eof] || [self currentChar] != c)
		return false;
	[self nextChar];
	return true;		
} 

- (bool) skipSpaces
{
	int count = 0;
	while ([self skipChar:' '])
		count++;
	return (count > 0);
}

- (NSData *) readData:(int)length;
{
	if (pos + length > data.length)
		return NULL;
	NSData *result = [NSData dataWithBytes:((UInt8 *)data.bytes)+pos length:length];
	pos += length;
	return result;
}

- (NSString *) readStringUntil:(char)en
{
	NSMutableString *s = [NSMutableString string];
	while (![self eof])
	{
		char c = [self currentChar];
		[self nextChar];
		if (c == en)
			return s;
		[s appendFormat:@"%c", c];
	}
	return s;
}

- (NSString *) readStringUntilSet:(NSCharacterSet *)set
{
	NSMutableString *s = [NSMutableString string];
	while (![self eof])
	{
		char c = [self currentChar];
		[self nextChar];
		if ([set characterIsMember:c])
			return s;
		[s appendFormat:@"%c", c];
	}
	return s;
}

- (NSString *) readString
{
	NSString *result = [self readStringUntil:'\r'];
	[self skipChar:'\n'];
	return result;
}

- (NSString *) readQuotedString
{
	if ([self eof] || [self currentChar] != '"')
		return NULL;
	[self nextChar];
	return [self readStringUntil:'"'];
}

- (NSNumber *) readNumber
{
	NSMutableString *s = [NSMutableString string];
	while (![self eof] && [self currentChar] >= '0' && [self currentChar] <= '9')
	{
		[s appendFormat:@"%c", [self currentChar]];
		[self nextChar];
	}
	if (s.length > 0)
		return [NSNumber numberWithInt:[s intValue]];
	else
		return NULL;
}

@end

