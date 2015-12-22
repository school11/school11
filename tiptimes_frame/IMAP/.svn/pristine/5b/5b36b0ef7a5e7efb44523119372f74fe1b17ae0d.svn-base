#import "ImapBodypart.h"
#import "ImapEncoding.h"


@implementation ImapBodypart

@synthesize multipartType;
@synthesize multipartList;
@synthesize type;
@synthesize subtype;
@synthesize parameters;
@synthesize contentId;
@synthesize description;
@synthesize encoding;
@synthesize size;
@synthesize data;

- (void) dealloc
{
	[multipartType release];
	[multipartList release];
	[type release];
	[subtype release];
	[parameters release];
	[contentId release];
	[description release];
	[encoding release];
	[data release];
	[super dealloc];
}

- (bool) read:(ImapFetchObject *)obj
{
	if (obj.type != IMAPFETCHOBJECT_LIST || obj.objects.count == 0)
		return false;
		
	ImapFetchObject *firstObject = [obj.objects objectAtIndex:0];
	if (firstObject.type == IMAPFETCHOBJECT_LIST)
	{
		// Multipart
		NSMutableArray *list = [NSMutableArray array];
		self.multipartList = list;

		int i = 0;
		while (i < obj.objects.count)
		{
			ImapFetchObject *partObject = [obj.objects objectAtIndex:i];
			if (partObject.type != IMAPFETCHOBJECT_LIST)
				break;
			
			ImapBodypart *subpart = [[ImapBodypart alloc] init];
			[list addObject:subpart];
			[subpart release];
			
			if (![subpart read:partObject])
				return false;
				
			i++;
		}
		
		if (i == obj.objects.count)
			return false;

		ImapFetchObject *lastObject = [obj.objects objectAtIndex:i];
		if (lastObject.type != IMAPFETCHOBJECT_STRING)
			return false;
		self.multipartType = [lastObject.stringValue lowercaseString];
	}
	else
	{
		// Single part
		// ("TEXT" "PLAIN" ("CHARSET" "KOI8-R") NIL NIL "BASE64" 1502 19)
		if (obj.objects.count < 6)
			return false;
		
		ImapFetchObject *obj0 = [obj.objects objectAtIndex:0];
		if (obj0.type != IMAPFETCHOBJECT_STRING)
			return false;
		self.type = [obj0.stringValue lowercaseString];

		ImapFetchObject *obj1 = [obj.objects objectAtIndex:1];
		if (obj1.type != IMAPFETCHOBJECT_STRING)
			return false;
		self.subtype = [obj1.stringValue lowercaseString];

		ImapFetchObject *obj2 = [obj.objects objectAtIndex:2];
		if (obj2.type != IMAPFETCHOBJECT_LIST)
			return false;
		NSMutableDictionary *dic = [NSMutableDictionary dictionary];
		self.parameters = dic;
		for (int i = 0; i < obj2.objects.count; i += 2)
		{
			ImapFetchObject *objName = [obj2.objects objectAtIndex:i];
			ImapFetchObject *objValue = [obj2.objects objectAtIndex:i+1];
			
			if (objName.type == IMAPFETCHOBJECT_STRING && objValue.type == IMAPFETCHOBJECT_STRING)
				[dic setObject:objValue.stringValue forKey:[objName.stringValue lowercaseString]];
		}			

		ImapFetchObject *obj3 = [obj.objects objectAtIndex:3];
		if (obj3.type != IMAPFETCHOBJECT_NIL)
		{
			if (obj3.type != IMAPFETCHOBJECT_STRING)
				return false;
			self.contentId = obj3.stringValue;
		}

		ImapFetchObject *obj4 = [obj.objects objectAtIndex:4];
		if (obj4.type != IMAPFETCHOBJECT_NIL)
		{
			if (obj4.type != IMAPFETCHOBJECT_STRING)
				return false;
			self.description = obj4.stringValue;
		}

		ImapFetchObject *obj5 = [obj.objects objectAtIndex:5];
		if (obj5.type != IMAPFETCHOBJECT_NIL)
		{
			if (obj5.type != IMAPFETCHOBJECT_STRING)
				return false;
			self.encoding = [obj5.stringValue lowercaseString];
		}

		ImapFetchObject *obj6 = [obj.objects objectAtIndex:6];
		if (obj6.type != IMAPFETCHOBJECT_NUMBER)
			return false;
		self.size = obj6.intValue;
	}
	
	return true;
}

- (NSString *) contentType
{
	return [NSString stringWithFormat:@"%@/%@", self.type, self.subtype];
}

- (NSString *) stringWithCharset
{
	NSString *charset = [self.parameters objectForKey:@"charset"];
	return [[[NSString alloc] initWithData:self.data 
		encoding:[ImapEncoding encodingFromName:charset]] autorelease];
}

- (NSData *) dataWithCharset
{
	if (![self.type isEqual:@"text"])
		return self.data;
	NSString *charset = [self.parameters objectForKey:@"charset"];
		return self.data;
	
	NSString *str = [[NSString alloc] initWithData:self.data 
		encoding:[ImapEncoding encodingFromName:charset]];
	NSData *result = [str dataUsingEncoding:NSUTF8StringEncoding];
	[str release];
	return result;
}

@end

