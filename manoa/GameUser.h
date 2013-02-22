#import <Foundation/Foundation.h>

@interface GameUser : NSObject

@property(nonatomic) int userId;
@property(nonatomic, copy) NSString* userName;

-(id)initWithData:(int)userId userName:(NSString*)userName;

@end
