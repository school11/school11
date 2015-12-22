#import "ImapConnection.h"
#import "NSStream+GetStreamsToHost.h"

@implementation ImapConnection

@synthesize delegate;
@synthesize connecting;

- (id) init
{
	if (self = [super init])
	{
		writeQueue = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void) dealloc
{
	[self close];
	[writeQueue release];
	[super dealloc];
}

- (void) connectToHost:(NSString *)host port:(int)port useSSL:(bool)useSSL
{
	connecting = true;

	[NSStream getStreamsToHostNamed:host port:port inputStream:&inputStream outputStream:&outputStream];

	if (!inputStream || !outputStream)
	{
		NSLog(@"Failed to create streams");
		return;
	}

	[inputStream retain];
	[inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	inputStream.delegate = self;
	[inputStream open];

	[outputStream retain];
	[outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	outputStream.delegate = self;
	[outputStream open];
	
	if (useSSL)
	{            
		[inputStream setProperty:NSStreamSocketSecurityLevelNegotiatedSSL forKey:NSStreamSocketSecurityLevelKey];
		[outputStream setProperty:NSStreamSocketSecurityLevelNegotiatedSSL forKey:NSStreamSocketSecurityLevelKey];  
	}
}

- (void) close
{
	[inputStream close];
  [inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[inputStream release];
	inputStream = NULL;

	[outputStream close];
  [outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[outputStream release];
	outputStream = NULL;
}

- (void) write:(NSData *)data
{
	if (self.connected && passedWrite)
	{
		[outputStream write:data.bytes maxLength:data.length];
		passedWrite = false;
	}
	else
	{
		[writeQueue addObject:data];
	}
}

- (bool) connected
{
	NSStreamStatus is = [inputStream streamStatus];
	NSStreamStatus os = [outputStream streamStatus];
	return (is != NSStreamStatusNotOpen && is != NSStreamStatusOpening 
		&& is != NSStreamStatusClosed && is != NSStreamStatusError
		&& os != NSStreamStatusNotOpen && os != NSStreamStatusOpening 
		&& os != NSStreamStatusClosed && os != NSStreamStatusError);
}

- (bool) connecting
{
	NSStreamStatus is = [inputStream streamStatus];
	NSStreamStatus os = [outputStream streamStatus];
	return (is == NSStreamStatusOpening || os == NSStreamStatusOpening);
}


// NSStreamDelegate

- (void) stream:(NSStream *)sender handleEvent:(NSStreamEvent)streamEvent
{
	switch (streamEvent)
	{
		case NSStreamEventOpenCompleted:
		{
			if (sender == outputStream)
				[delegate performSelector:@selector(imapConnection_Connected)];
			break;
		}
	
		case NSStreamEventHasBytesAvailable:
		{
			NSInputStream *stream = (NSInputStream *)sender;

			NSMutableData *data = [NSMutableData data];
			uint8_t buffer[1024];
			while ([stream hasBytesAvailable])
			{
				int len = [stream read:buffer maxLength:sizeof(buffer)];
				if (len > 0)
					[data appendBytes:buffer length:len];
			}
			
			[delegate performSelector:@selector(imapConnection_GotData:) withObject:data];
			break;
		}
		
		case NSStreamEventHasSpaceAvailable:
		{
			if (writeQueue.count > 0)
			{
				NSOutputStream *stream = (NSOutputStream *)sender;
				
				NSData *data = [writeQueue objectAtIndex:0];
				[stream write:data.bytes maxLength:data.length];
				[writeQueue removeObjectAtIndex:0];
			}
			else
			{
				passedWrite = true;
			}
			break;
		}
		
		case NSStreamEventErrorOccurred:
		{
			[writeQueue removeAllObjects];
			[delegate performSelector:@selector(imapConnection_Error:) 
				withObject:[sender.streamError localizedDescription]];
			break;
		}

		case NSStreamEventEndEncountered:
		{
			[writeQueue removeAllObjects];
			[delegate performSelector:@selector(imapConnection_ClosedByServer)];
			[self close];
			break;
		}
		
		default:
			break;
	}
}

@end
