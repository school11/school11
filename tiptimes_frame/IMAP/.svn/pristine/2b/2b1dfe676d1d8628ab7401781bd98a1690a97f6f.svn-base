#import "ImapMessage.h"
#import "ImapReader.h"
#import "Imap.h"
#import "Base64.h"
#import "ImapEncoding.h"

@implementation ImapMessage

@synthesize sequenceNumber;
@synthesize uid;
@synthesize bodyStructure;
@synthesize date;
@synthesize from;
@synthesize subject;

- (id) init
{
	if (self = [super init])
	{
		headers = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (void) dealloc
{
	[headers release];
	[bodyStructure release];
	[super dealloc];
}

- (NSString *) subject
{
	return [headers objectForKey:@"subject"];
}

- (NSString *) from
{
	return [headers objectForKey:@"from"];
}

- (NSArray *) fromAddresses
{
	NSMutableArray *result = [NSMutableArray array];
	
	NSArray *ss = [[self from] componentsSeparatedByString:@","];
	for (NSString *s in ss)
	{
		NSString *name = @"";
		NSString *address;
	
		NSRegularExpression *regex1 = [NSRegularExpression 
			regularExpressionWithPattern:@"(\"?(.*?)\"? )?<(.*?)>" options:0 error:NULL];
		if ([regex1 numberOfMatchesInString:s options:0 range:NSMakeRange(0, s.length)] > 0)
		{
			NSArray *matches = [regex1 matchesInString:s options:0 range:NSMakeRange(0, s.length)];
			NSTextCheckingResult *match = [matches objectAtIndex:0];
			if (match.numberOfRanges > 3)
			{
				if ([match rangeAtIndex:2].location != NSNotFound)
					name = [s substringWithRange:[match rangeAtIndex:2]];
				address = [s substringWithRange:[match rangeAtIndex:3]];
			}
			else
			{
				address = [s substringWithRange:[match rangeAtIndex:1]];
			}
		}
		else
		{
			address = s;
		}
		
		[result addObject:[NSArray arrayWithObjects:name, address, NULL]];
	}
	
	return result;
}

- (NSDate *) date
{
	NSString *d = [headers objectForKey:@"date"];
	if (d == NULL)
		return NULL;
	
	NSRange rng = [d rangeOfString:@" ("];
	if (rng.location != NSNotFound)
		d = [d substringToIndex:rng.location];
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
	[formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZ"];
	NSDate *result = [formatter dateFromString:d];
	[formatter release];

	return result;
}

- (NSData *) decodeQuotedPrintable:(NSString *)s 
{
	NSMutableData *data = [NSMutableData data];
	char wsp = ' ';

	int i = 0;
	while (i < s.length)
	{
		unichar c = [s characterAtIndex:i];
		if (c == '=' && i < s.length-2)
		{
			NSScanner *scanner = [NSScanner scannerWithString:[s substringWithRange:NSMakeRange(i+1, 2)]];
			uint hex;
			if ([scanner scanHexInt:&hex])
			{
				[data appendBytes:&hex length:1];
				i += 2;
			}
		}
		else if (c == '_')
			[data appendBytes:&wsp length:1];
		else
			[data appendBytes:&c length:1];

		i++;
	}

	return data;
}

- (NSString *) processHeaderValue:(NSString *)value
{
	NSMutableString *result = [NSMutableString stringWithString:value];

	// RFC 2047 encoded-word
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"=\\?(.*?)\\?(.*?)\\?(.*?)\\?=" options:0 error:NULL];
	NSArray *matches = [regex matchesInString:value options:0 range:NSMakeRange(0, value.length)];
	for (int i = matches.count-1; i >= 0; i--)
	{
		NSTextCheckingResult *match = [matches objectAtIndex:i];
		
		NSString *encoding = [value substringWithRange:[match rangeAtIndex:1]];
		NSString *type = [value substringWithRange:[match rangeAtIndex:2]];
		NSString *text = [value substringWithRange:[match rangeAtIndex:3]];

		if ([type isEqual:@"B"])
		{
			NSData *strData = [Base64 decodeBase64WithString:text];
			NSString *str = [[NSString alloc] initWithData:strData 
				encoding:[ImapEncoding encodingFromName:encoding]];
			if (str != NULL)
				[result replaceCharactersInRange:match.range withString:str];
			[str release];
		}
		else if ([type isEqual:@"Q"])
		{
			NSData *strData = [self decodeQuotedPrintable:text];
			NSString *str = [[NSString alloc] initWithData:strData 
				encoding:[ImapEncoding encodingFromName:encoding]];
			if (str != NULL)
				[result replaceCharactersInRange:match.range withString:str];
			[str release];
		}
	}

	return result;
}

- (void) readHeaders:(NSData *)data
{
	// RFC 5322 (2322, 822)
	ImapReader *reader = [[ImapReader alloc] initWithData:data];
	
	while (![reader eof])
	{
		NSString *name = NULL;
		NSMutableString *s = [NSMutableString string];
		while (![reader eof])
		{
			char c = [reader currentChar];
			if (c == ':' && name == NULL)
			{
				name = [s lowercaseString];
				s = [NSMutableString string];
				[reader nextChar];
				[reader skipSpaces];
				continue;
			}
			else if (c == '\r')
			{
				[reader nextChar];
				continue;
			}
			else if (c == '\n' || [reader eof])
			{
				if ([reader eof])
					[s appendFormat:@"%c", c];
				else
					[reader nextChar];
					
				if ([reader currentChar] == ' ' || [reader currentChar] == '\t')
					[reader nextChar];
				else
				{
					if (name != NULL)
					{
						[headers setObject:[self processHeaderValue:s] forKey:name];
						name = NULL;
					}
					s = [NSMutableString string];
				}
				continue;
			}
			
			[s appendFormat:@"%c", c];
			[reader nextChar];
		}
	}
	
	[reader release];
}

- (void) checkDataForPart:(ImapBodypart *)part inImapContent:(NSDictionary *)dictionary
{
	NSString *code = [self codeForPart:part];
	
	NSData *data = [dictionary objectForKey:[NSString stringWithFormat:@"BODY[%@]", code]];
	if (data != NULL)
	{
		if ([part.encoding isEqual:@"base64"])
		{
			NSMutableData *partData = [NSMutableData data];
			ImapReader *reader = [[ImapReader alloc] initWithData:data];
			
			while (![reader eof])
			{
				NSString *line = [reader readString];
				[partData appendData:[Base64 decodeBase64WithString:line]];
			}
			
			[reader release];
			part.data = partData;
		}
		else if ([part.encoding isEqual:@"quoted-printable"])
		{
			NSMutableData *partData = [NSMutableData data];
			ImapReader *reader = [[ImapReader alloc] initWithData:data];
			
			while (![reader eof])
			{
				NSString *line = [reader readString];
				
				if ([line hasSuffix:@"="])
					line = [line substringToIndex:line.length-1];
				else
					line = [NSString stringWithFormat:@"%@\r\n", line];
				
				[partData appendData:[self decodeQuotedPrintable:line]];
			}
			
			[reader release];
			part.data = partData;
		}
		else
			part.data = data;
	}

	if (part.multipartType != NULL)
	{
		for (ImapBodypart *subpart in part.multipartList)
			[self checkDataForPart:subpart inImapContent:dictionary];
	}
}

- (void) addImapContent:(NSDictionary *)dictionary
{
	// Simple implementation to read only specific cases
	ImapFetchObject *obj;
	
	for (NSString *key in [dictionary allKeys])
	{
		if ([key rangeOfString:@"BODY[HEADER.FIELDS"].location != NSNotFound
			|| [key isEqual:@"RFC822.HEADER"])
			[self readHeaders:[dictionary objectForKey:key]];
	}
		
	obj = [dictionary objectForKey:@"UID"];
	if (obj != NULL)
		self.uid = obj.intValue;

	obj = [dictionary objectForKey:@"BODY"];
	if (obj != NULL)
	{
		ImapBodypart *bodypart = [[ImapBodypart alloc] init];
		if ([bodypart read:obj])
			self.bodyStructure = bodypart;
		[bodypart release];
	}
	
	[self checkDataForPart:self.bodyStructure inImapContent:dictionary];
}

- (ImapBodypart *) findContentPartInPart:(ImapBodypart *)container
{
	if (container.multipartType == NULL)
	{
		if ([container.contentType isEqual:@"text/plain"] 
			|| [container.contentType isEqual:@"text/html"])
			return container;
		else
			return NULL;
	}
	else
	{
		if ([container.multipartType isEqual:@"alternative"])
		{
			ImapBodypart *result = NULL;
			for (ImapBodypart *part in container.multipartList)
			{
				if ([part.contentType isEqual:@"text/plain"])
					result = part;
				else if ([part.contentType isEqual:@"text/html"])
					return part;
			}
			return result;
		}
		else if ([container.multipartType isEqual:@"mixed"])
		{
			if (container.multipartList.count > 0)
				return [self findContentPartInPart:[container.multipartList objectAtIndex:0]];
			else
				return NULL;
		}
	}
	return NULL;
}

- (ImapBodypart *) findContentPart
{
	return [self findContentPartInPart:self.bodyStructure];
}

- (NSArray *) findAttachments
{
	NSMutableArray *list = [NSMutableArray array];

	if ([self.bodyStructure.multipartType isEqual:@"mixed"])
	{
		for (int i = 1; i < self.bodyStructure.multipartList.count; i++)
		{
			ImapBodypart *part = [self.bodyStructure.multipartList objectAtIndex:i];
			if ([part.type isEqual:@"text"]	|| [part.type isEqual:@"image"]
				|| [part.contentType isEqual:@"application/rtf"]
				|| [part.contentType isEqual:@"application/pdf"])
				[list addObject:part];
		}
	}

	return list;
}

- (NSString *) codeForPart:(ImapBodypart *)part inPart:(ImapBodypart *)container
{
	if (container.multipartType == NULL)
		return NULL;

	int idx = [container.multipartList indexOfObject:part];
	if (idx != NSNotFound)
		return [NSString stringWithFormat:@"%i", idx+1];

	for (int i = 0; i < container.multipartList.count; i++)
	{
		NSString *code = [self codeForPart:part inPart:[container.multipartList objectAtIndex:i]];
		if (code != NULL)
			return [NSString stringWithFormat:@"%i.%@", i+1, code];
	}
	
	return NULL;
}

- (NSString *) codeForPart:(ImapBodypart *)part
{
	if (part == self.bodyStructure)
		return @"1";
	return [self codeForPart:part inPart:self.bodyStructure];
}

@end


