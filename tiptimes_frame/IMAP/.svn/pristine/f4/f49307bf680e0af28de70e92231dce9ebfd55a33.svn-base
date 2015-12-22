#import "Imap.h"
#import "Utils.h"
#include <netinet/in.h>
#include "ImapReader.h"
#include "Settings.h"

//#define LOG(format, ...) NSLog(format, ## __VA_ARGS__)
#define LOG(format, ...) 

#define CONNECT_TIMEOUT  5.0

#define READFETCH_OK    0
#define READFETCH_MORE  1
#define READFETCH_ERROR 2


Imap *imap = NULL;

@implementation ImapRequest

@synthesize code;
@synthesize client;
@synthesize action;
@synthesize tag;
@synthesize login;

- (void) dealloc
{
	[code release];
	[client release];
	[tag release];
	[super dealloc];
}

@end


@implementation Imap

@synthesize mailboxes;
@synthesize exists;
@synthesize recent;
@synthesize uidvalidity;
@synthesize selectedMailbox;
@synthesize messages;
@synthesize connection;

- (id) init
{
	if (self = [super init])
	{
		connection = [[ImapConnection alloc] init];
		connection.delegate = self;
		
		mailboxes = [[NSMutableArray alloc] init];
		
		requests = [[NSMutableArray alloc] init];
		buffer = [[NSMutableData alloc] init];
		messages = [[NSMutableArray alloc] init];
		writeQueue = [[NSMutableArray alloc] init];
		
		[[NSNotificationCenter defaultCenter] addObserver:self 
			selector:@selector(application_WillResignActive:) 
			name:UIApplicationWillResignActiveNotification object:NULL];
	}
	return self;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];

	[connection release];
	[requests release];
  [mailboxes release];
  [selectedMailbox release];
	[buffer release];
	[messages release];
	[writeQueue release];
	[super dealloc];
}

- (void) write:(NSData *)message
{
	[connection write:message];
}

- (void) writeString:(NSString *)string
{
	LOG(@"C: %@", string);
	return [self write:[NSData dataWithBytes:[string UTF8String] length:string.length]];
}

- (void) reportError:(NSString *)error toClient:(id)client
{
	LOG(@"Error: %@", error);
	SEL selector = @selector(imap_Error:);
	if ([client respondsToSelector:selector])
		[client performSelector:selector withObject:error];
}

- (void) resetConnectionData
{
	loggedIn = false;
	for (ImapMessage *message in messages)
		message.sequenceNumber = 0;
	[writeQueue removeAllObjects];
}

- (void) closeRequestsWithError:(NSString *)error
{
	while (requests.count > 0)
	{
		ImapRequest *request = [requests objectAtIndex:0];
		[self reportError:error toClient:request.client];
		[requests removeObject:request];
	}

	[self resetConnectionData];
}

- (void) maintainConnection
{
	if (!connection.connected && !connection.connecting)
	{
		// Reconnect
		[connection connectToHost:settings.imapHost port:settings.imapPort useSSL:settings.imapSsl];

		[self login:NULL];

		// Select mailbox
		if (self.selectedMailbox != NULL)
			[self select:NULL mailboxName:self.selectedMailbox.name];

		// Get message sequence numbers
		if (messages.count > 0)
		{
			ImapMessage *firstMessage = [messages objectAtIndex:0];
			[self uidFetch:NULL uid:firstMessage.uid filter:@""];
		}

		if (messages.count > 1)
		{
			ImapMessage *lastMessage = [messages lastObject];
			[self uidFetch:NULL uid:lastMessage.uid filter:@""];
		}

		// Timeout check
		[self performSelector:@selector(connection_Timeout:) 
			withObject:[NSNumber numberWithInt:connectId] afterDelay:CONNECT_TIMEOUT];
	}
}

- (void) connection_Timeout:(NSNumber *)passedConnectId
{
	if (passedConnectId.intValue != connectId)
		return;

	[connection close];
	[self closeRequestsWithError:@"Connection timeout"];
}

- (void) imapConnection_Connected
{
	LOG(@"imapConnection_Connected");
	connectId++;
}

- (void) imapConnection_ClosedByServer
{
	LOG(@"imapConnection_ClosedByServer");
	[buffer setLength:0];
}

- (void) imapConnection_Error:(NSString *)error
{
	NSLog(@"imapConnection_Error: %@", error);
	[self closeRequestsWithError:error];
	connectId++;
}

- (void) startRequest:(id)client command:(NSString *)command action:(SEL)action tag:(id)tag
{
	bool loginRequest = [command hasPrefix:@"LOGIN"];

	if (!loginRequest)
		[self maintainConnection];

	requestId++;
	
	ImapRequest *request = [[ImapRequest alloc] init];
	request.code = [NSString stringWithFormat:@"A%0.03i", requestId];
	request.client = client;
	request.action = action;
  request.tag = tag;
	request.login = loginRequest;
	[requests addObject:request];
	[request release];
	
	NSString *output = [NSString stringWithFormat:@"%@ %@\r\n", request.code, command];
	
	if (loggedIn || loginRequest)
		[self writeString:output];
	else
		[writeQueue addObject:output];
}

- (ImapMailbox *) mailboxWithName:(NSString *)name
{
  int i = mailboxes.count-1;
  while (i >= 0 && ![[[mailboxes objectAtIndex:i] name] isEqual:name])
    i--;
  if (i >= 0)
    return [mailboxes objectAtIndex:i];
  return NULL;
}

- (void) receivedList:(ImapReader *)reader
{
	ImapMailbox *mailbox = [[ImapMailbox alloc] init];

	[reader readStringUntil:'('];

	NSString *flags = [reader readStringUntil:')'];
	[reader skipSpaces];

	mailbox.noinferiors = ([flags rangeOfString:@"\\Noinferiors"].location != NSNotFound);
	mailbox.noselect = ([flags rangeOfString:@"\\Noselect"].location != NSNotFound);
	mailbox.marked = ([flags rangeOfString:@"\\Marked"].location != NSNotFound);
	mailbox.unmarked = ([flags rangeOfString:@"\\Unmarked"].location != NSNotFound);

	if ([reader currentChar] == '"')
		mailbox.delimiter = [reader readQuotedString];
	else
		mailbox.delimiter = [reader readStringUntilSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	[reader skipSpaces];
		
	if ([reader currentChar] == '"')
		mailbox.name = [reader readQuotedString];
	else
		mailbox.name = [reader readStringUntilSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

	ImapMailbox *existing = [self mailboxWithName:mailbox.name];
	if (existing != NULL)
		[mailboxes replaceObjectAtIndex:[mailboxes indexOfObject:existing] withObject:mailbox];
	else
		[mailboxes addObject:mailbox];
	
	LOG(@"added mailbox %@", mailbox.name);
}

- (void) receivedExists:(int)amount
{
	self.exists = amount;
	LOG(@"stored EXISTS");
}

- (void) receivedRecent:(int)amount
{
	self.recent = amount;
	LOG(@"stored RECENT");
}

- (void) receivedUidValidity:(int)value
{
	if (self.uidvalidity != value)
	{
		self.uidvalidity = value;
		
		if (messages.count > 0)
		{
			[messages removeAllObjects];
			[[NSNotificationCenter defaultCenter] postNotificationName:IMAP_CHANGEDMESSAGES object:self];
		}
	}
	LOG(@"stored UIDVALIDITY");
}

- (ImapFetchObject *) readFetchData:(ImapReader *)reader
{
	ImapFetchObject *obj = [[ImapFetchObject alloc] init];

	if ([reader currentChar] == '(')
	{
		obj.type = IMAPFETCHOBJECT_LIST;
		NSMutableArray *list = [NSMutableArray array];
		
		[reader nextChar];
		while ([reader currentChar] != ')')
		{
			ImapFetchObject *sub = [self readFetchData:reader];
			if (sub == NULL || [reader eof])
				return NULL;
			[list addObject:sub];
			[reader skipSpaces];
		}
		
		[reader nextChar];
		obj.objects = list;
		return obj;
	}
	
	if ([reader currentChar] == '"')
	{
		obj.type = IMAPFETCHOBJECT_STRING;
		obj.stringValue = [reader readQuotedString];
		return obj;
	}
	
	if ([reader currentChar] >= '0' && [reader currentChar] <= '9')
	{
		obj.type = IMAPFETCHOBJECT_NUMBER;
		NSNumber *n = [reader readNumber];
		if (n == NULL)
			return NULL;
		obj.intValue = [n intValue];
		return obj;
	}

	if ([reader skipChar:'N'] && [reader skipChar:'I'] && [reader skipChar:'L'])
	{
		obj.type = IMAPFETCHOBJECT_NIL;
		return obj;
	}
	
	return NULL;
}

- (int) readFetch:(ImapReader *)reader sequenceNumber:(int)sequenceNumber
{
	if ([reader readStringUntil:'('] == NULL)
		return READFETCH_ERROR;
	
	NSMutableDictionary *parts = [NSMutableDictionary dictionary];
	
	while (![reader eof] && [reader currentChar] != ')')
	{
		// Part name
		NSMutableString *partName = [NSMutableString string];
		while (![reader eof] && [reader currentChar] != ' ' && [reader currentChar] != '[')
		{
			[partName appendFormat:@"%c", [reader currentChar]];
			[reader nextChar];
		}
		if ([reader currentChar] == '[')
		{
			NSString *args = [reader readStringUntil:']'];
			if (args == NULL)
				return READFETCH_ERROR;
			[partName appendFormat:@"%@]", args];
		}
		[reader skipSpaces];
	
		// {size}\r\n data\r\n ?
		if ([reader currentChar] == '{')
		{
			[reader nextChar];
			NSNumber *nSkipLen = [reader readNumber];
			if (nSkipLen == NULL || [reader currentChar] != '}')
				return READFETCH_ERROR;
			[reader readStringUntil:'\n'];
			NSData *partData = [reader readData:nSkipLen.intValue];
			if (partData == NULL)
				return READFETCH_MORE;
			[parts setObject:partData forKey:partName];
		}
		
		// Inline object
		else
		{
			ImapFetchObject *obj = [self readFetchData:reader];
			if (obj == NULL)
				return READFETCH_ERROR;
			[parts setObject:obj forKey:partName];
		}
		
		[reader skipSpaces];
	}

	// Read UID
	ImapFetchObject *uidObj = [parts objectForKey:@"UID"];
	if (uidObj == NULL || uidObj.type != IMAPFETCHOBJECT_NUMBER)
	{
		NSLog(@"No UID in FETCH response");
		return READFETCH_ERROR;
	}
	int uid = uidObj.intValue;

	// Create message
	ImapMessage *message;

	int i = 0; 
	while (i < messages.count && [[messages objectAtIndex:i] uid] < uid)
		i++;
	if (i < messages.count)
	{
		ImapMessage *existing = [messages objectAtIndex:i];
		if (existing.uid == uid)
			message = existing;
		else
		{
			message = [[ImapMessage alloc] init];
			[messages insertObject:message atIndex:i];
		}
	}
	else
	{
		message = [[ImapMessage alloc] init];
		[messages addObject:message];
	}

	message.sequenceNumber = sequenceNumber;
	[message addImapContent:parts];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:IMAP_CHANGEDMESSAGES object:self];
	LOG(@"message from %@", message.from);
	
	return READFETCH_OK;
}

// TODO: does not work properly when sequence ids shifted between sessions
- (void) receivedExpunge:(int)sequenceNumber
{
	self.exists--;
	
	int i = 0;
	while (i < messages.count)
	{
		ImapMessage *msg = [messages objectAtIndex:i];
		if (msg.sequenceNumber == sequenceNumber)
		{
			[messages removeObjectAtIndex:i];
			continue;
		}
		
		if (msg.sequenceNumber > sequenceNumber)
			msg.sequenceNumber--;
		i++;
	}
	
	[[NSNotificationCenter defaultCenter] postNotificationName:IMAP_CHANGEDMESSAGES object:self];
	LOG(@"expunged %i", sequenceNumber);
}

- (void) receivedBye
{
	[self resetConnectionData];
	LOG(@"bye bye");
}

- (void) imapConnection_GotData:(NSData *)receivedData
{
	[buffer appendData:receivedData];

	NSMutableString *s = [NSMutableString string];
	for (int i = 0; i < receivedData.length; i++)
		[s appendFormat:@"%c", ((char *)receivedData.bytes)[i]];
	LOG(@"%@", s);

	ImapReader *reader = [[ImapReader alloc] initWithData:buffer];
	
	while (![reader eof])
	{
		// Tagged response
		if ([reader skipChar:'*'])
		{
			[reader skipSpaces];
			NSString *word1 = [reader readStringUntilSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

			if ([word1 isEqual:@"LIST"])
				[self receivedList:reader]; // TODO
			
			else if ([word1 isEqual:@"BYE"])
				[self receivedBye];
			
			else
			{
				NSString *word2 = [reader readStringUntilSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
				
				if ([word2 isEqual:@"EXISTS"])
					[self receivedExists:[word1 intValue]];
					
				else if ([word2 isEqual:@"RECENT"])
					[self receivedRecent:[word1 intValue]];
					
				else if ([word2 isEqual:@"[UIDVALIDITY"])
					[self receivedUidValidity:[[reader readStringUntil:']'] intValue]];

				else if ([word2 isEqual:@"EXPUNGE"])
					[self receivedExpunge:[word1 intValue]];
					
				else if ([word2 isEqual:@"FETCH"])
				{
					int rsp = [self readFetch:reader sequenceNumber:[word1 intValue]];
					if (rsp == READFETCH_MORE)
					{
						LOG(@"incomplete data");
						break;
					}
					else if (rsp == READFETCH_ERROR)
						NSLog(@"Error reading FETCH");
				}
			}
		}
	
		// Command response
		else if ([reader currentChar] == 'A')
		{
			NSString *code = [reader readStringUntil:' '];
			NSString *status = [reader readStringUntil:' '];
			NSString *message = [reader readString];
		
			int j = requests.count-1;
			while (j >= 0 && ![code isEqual:((ImapRequest *)[requests objectAtIndex:j]).code])
				j--;
			if (j >= 0)
			{
				// Found request, check response status
				ImapRequest *request = [requests objectAtIndex:j];

				if ([status isEqual:@"OK"])
					[self performSelector:request.action withObject:request];
				else
					[self reportError:message toClient:request.client];

				[requests removeObjectAtIndex:j];

				if (![status isEqual:@"OK"] && request.login)
				{
					[connection close];
					[self closeRequestsWithError:message];
					return;
				}
			}
		}

		// Next line
		[reader readStringUntil:'\n'];
		
		// Remove handled data from buffer
		[buffer replaceBytesInRange:NSMakeRange(0, reader.pos) withBytes:NULL length:0];
		reader.pos = 0;
	}
}

- (ImapMessage *) messageWithUid:(int)uid
{
	int i = messages.count-1;
	while (i >= 0 && [[messages objectAtIndex:i] uid] != uid)
		i--;
	if (i >= 0)
		return [messages objectAtIndex:i];
	return NULL;
}

- (void) application_WillResignActive:(NSNotification *)notification
{
	if (connection.connected)
		[self logout:NULL];
}

- (void) deselectMailbox
{
	uidvalidity = 0;
	self.selectedMailbox = NULL;
	[messages removeAllObjects];
}

- (void) reset
{
	[self deselectMailbox];
	[self.mailboxes removeAllObjects];
}


- (bool) canLogin
{
	return (settings.imapHost != NULL && settings.imapPort > 0 && settings.imapUsername != NULL
		&& settings.imapPassword != NULL);
}

- (void) login:(id)client 
{
	[self startRequest:client 
		command:[NSString stringWithFormat:@"LOGIN %@ %@", settings.imapUsername, settings.imapPassword]
		action:@selector(endLogin:) tag:NULL];
}

- (void) endLogin:(ImapRequest *)request
{
	loggedIn = true;
	
	for (NSString *string in writeQueue)
		[self writeString:string];
	[writeQueue removeAllObjects];
	
	if (request.client != NULL)
		[request.client performSelector:@selector(imap_LoginFinished)];
}

- (void) list:(id)client refName:(NSString *)refName mailboxName:(NSString *)mailboxName;
{
	[self startRequest:client 
		command:[NSString stringWithFormat:@"LIST \"%@\" \"%@\"", refName, mailboxName]
		action:@selector(endList:) tag:NULL];
}

- (void) endList:(ImapRequest *)request
{
	if (request.client != NULL)
		[request.client performSelector:@selector(imap_ListFinished)];
}

- (void) select:(id)client mailboxName:(NSString *)mailboxName
{
	[self startRequest:client 
		command:[NSString stringWithFormat:@"SELECT \"%@\"", mailboxName]
		action:@selector(endSelect:) tag:mailboxName];
}

- (void) endSelect:(ImapRequest *)request
{
	self.selectedMailbox = [self mailboxWithName:request.tag];
	LOG(@"selected %@", self.selectedMailbox.name);
	
	if (request.client != NULL)
		[request.client performSelector:@selector(imap_SelectFinished)];
}

- (void) examine:(id)client mailboxName:(NSString *)mailboxName
{
	[self startRequest:client 
		command:[NSString stringWithFormat:@"EXAMINE \"%@\"", mailboxName]
		action:@selector(endExamine:) tag:mailboxName];
}

- (void) endExamine:(ImapRequest *)request
{
	if (request.client != NULL)
		[request.client performSelector:@selector(imap_ExamineFinished)];
}

- (void) fetch:(id)client firstMessage:(int)firstMessage lastMessage:(int)lastMessage filter:(NSString *)filter
{
	NSString *set;
	if (firstMessage == lastMessage)
		set = [NSString stringWithFormat:@"%i", firstMessage];
	else
		set = [NSString stringWithFormat:@"%i:%i", firstMessage, lastMessage];

	[self startRequest:client
		command:[NSString stringWithFormat:@"FETCH %@ (UID %@)", set, filter]
		action:@selector(endFetch:) tag:NULL];
}

- (void) endFetch:(ImapRequest *)request
{
	if (request.client != NULL)
		[request.client performSelector:@selector(imap_FetchFinished)];
}

- (void) uidFetch:(id)client uid:(int)uid filter:(NSString *)filter
{
	[self startRequest:client
		command:[NSString stringWithFormat:@"UID FETCH %i (UID%@%@)", uid, 
			(filter.length > 0 ? @" " : @""), filter]
		action:@selector(endUidFetch:) tag:NULL];
}

- (void) endUidFetch:(ImapRequest *)request
{
	if (request.client != NULL)
		[request.client performSelector:@selector(imap_UidFetchFinished)];
}

- (void) logout:(id)client
{
	if (!loggedIn)
		return;
		
	[self reset];
		
	[self startRequest:client
		command:@"LOGOUT"
		action:@selector(endLogout:) tag:NULL];
}

- (void) endLogout:(ImapRequest *)request 
{
	if (request.client != NULL)
		[request.client performSelector:@selector(imap_LogoutFinished)];
}

@end



