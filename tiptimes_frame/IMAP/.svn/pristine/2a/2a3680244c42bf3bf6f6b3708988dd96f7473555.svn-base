#import <Foundation/Foundation.h>
#import "ImapMessage.h"


@interface ImapMailbox : NSObject 
{
  bool noinferiors;
  bool noselect;
  bool marked;
  bool unmarked;
  NSString *delimiter;
  NSString *name;
}

@property (nonatomic, assign) bool noinferiors;
@property (nonatomic, assign) bool noselect;
@property (nonatomic, assign) bool marked;
@property (nonatomic, assign) bool unmarked;
@property (nonatomic, retain) NSString *delimiter;
@property (nonatomic, retain) NSString *name;

+ (NSString *) decodeName:(NSString *)name;

@end
