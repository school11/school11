#import "ImapMailbox.h"
#import "ImapReader.h"
#import "Base64.h"


@implementation ImapMailbox

@synthesize noinferiors;
@synthesize noselect;
@synthesize marked;
@synthesize unmarked;
@synthesize delimiter;
@synthesize name;

- (id) init
{
	if (self = [super init])
	{
	}
	return self;
}

- (void) dealloc
{
	[delimiter release];
	[name release];
	[super dealloc];
}

+ (NSString *) decodeName:(NSString *)src
{
	// RFC 2152
	NSMutableString *s = [NSMutableString string];
	NSMutableString *code = [NSMutableString string];
	
	bool base64 = false;
	for (int i = 0; i < src.length; i++)
	{
		char c = [src characterAtIndex:i];
		if (c == '&')
			base64 = true;
		else if (c == '-')
		{
			base64 = false;
			NSString *decoded = [[NSString alloc] initWithData:[Base64 decodeBase64WithString:code]
				encoding:NSUnicodeStringEncoding];
			[s appendString:decoded];
			[decoded release];
			code = [NSMutableString string];
		}
		else
		{
			if (c == ',')
				c = '/';
			if (base64)
				[code appendFormat:@"%c", c];
			else
				[s appendFormat:@"%c", c];
		}
	}
	
	return s;
}

@end

