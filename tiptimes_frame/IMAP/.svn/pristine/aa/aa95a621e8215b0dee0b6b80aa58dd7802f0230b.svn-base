//
// imap4ios (c) 2012 Nikita Frolov
//

#import <Foundation/Foundation.h>
#import "ImapConnection.h"
#import "ImapMailbox.h"
#import "ImapFetchObject.h"

#define IMAP_CHANGEDMESSAGES @"IMAP_CHANGEDMESSAGES"


@interface ImapRequest : NSObject
{
}

@property (nonatomic, retain) NSString *code;
@property (nonatomic, retain) id client;
@property (nonatomic, assign) SEL action;
@property (nonatomic, retain) id tag;
@property (nonatomic, assign) bool login;

@end


@interface Imap : NSObject 
{
	ImapConnection *connection;
	NSMutableData *buffer;
	int connectId;
	int requestId;
	bool loggedIn;
	NSMutableArray *requests;
  int exists;
  int recent;
	ImapMailbox *selectedMailbox;
	NSMutableArray *messages;
	NSMutableArray *writeQueue;
}

@property (nonatomic, readonly) ImapConnection *connection;
@property (nonatomic, retain) NSMutableArray *mailboxes;
@property (nonatomic, assign) int exists;
@property (nonatomic, assign) int recent;
@property (nonatomic, assign) int uidvalidity;
@property (nonatomic, retain) ImapMailbox *selectedMailbox;
@property (nonatomic, retain) NSMutableArray *messages;

- (ImapMessage *) messageWithUid:(int)uid;
- (void) deselectMailbox;
- (void) reset;

- (bool) canLogin;
- (void) login:(id)client;
- (void) list:(id)client refName:(NSString *)refName mailboxName:(NSString *)mailboxName;
- (void) select:(id)client mailboxName:(NSString *)mailboxName;
- (void) examine:(id)client mailboxName:(NSString *)mailboxName;
- (void) fetch:(id)client firstMessage:(int)firstMessage lastMessage:(int)lastMessage filter:(NSString *)filter;
- (void) uidFetch:(id)client uid:(int)uid filter:(NSString *)filter;
- (void) logout:(id)client;

@end

extern Imap *imap;

