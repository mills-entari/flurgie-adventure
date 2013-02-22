#import "GameDataManager.h"

@interface GameDataManager()
{
@private
    BOOL mSaveDataRemote;
    //NSMutableArray* mGameDataList;
    //NSMutableData* mReceiveData;
    NSMapTable* mConnDataMap; // Stores NSURLConnection/NSMutableData pairs.
}

//void doSendGameDataRemote(void* args);

@end

@implementation GameDataManager

-(id)init
{
	if (self = [super init])
	{
		mSaveDataRemote = YES;
        //mGameDataList = [[NSMutableArray alloc] initWithCapacity:4];
        mConnDataMap = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory capacity:2];
	}
	
	return self;
}

-(void)saveGameData:(GameZoneData*)gameData
{
    if (gameData != nil)
    {
        // Save locally.
        // Add it to a queue that is checked on a separate thread for remote save.
        
        // For test will do it on same thread.
        [self saveGameDataRemote:gameData];
    }
}

-(void)saveGameDataLocal:(GameZoneData*)gameData
{
}

-(void)saveGameDataRemote:(GameZoneData*)gameData
{
    NSData* jsonData = [self convertGameZoneDataToJSON:gameData];
    
    if (jsonData != nil)
    {
        [self doSendGameDataRemote:jsonData];
        
//        dispatch_async(kBgQueue, ^
//        {
//            [self doSendGameDataRemote:jsonData];
//        });
        
//        dispatch_async_f(kBgQueue, jsonData, doSendGameDataRemote);
    }
}

-(NSData*)convertGameZoneDataToJSON:(GameZoneData*)gameData
{
    NSData* jsonData = nil;
    
    if (gameData != nil)
    {
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
        NSString* zoneCreatedDateStr = [dateFormatter stringFromDate:gameData.zoneCreatedDate];
        
        NSDictionary* dictData = [NSDictionary dictionaryWithObjectsAndKeys:
                                  gameData.gameZoneId, @"levelId",
                                  [NSNumber numberWithBool:gameData.isZoneComplete], @"isCompleted",
                                  [NSNumber numberWithInt:gameData.gameZoneMode], @"levelType",
                                  zoneCreatedDateStr, @"levelCreatedDate",
                                  //[NSNumber numberWithInt:gameData.playerUserId], @"gameUserId",
                                  gameData.gameUser.userName, @"gameUserName",
                                  gameData.timeValues, @"resultTimes", nil];
        
        NSError* error = nil;
        //jsonData = [NSJSONSerialization dataWithJSONObject:dictData options:NSJSONWritingPrettyPrinted error:&error];
        jsonData = [NSJSONSerialization dataWithJSONObject:dictData options:kNilOptions error:&error];
    }
    
    return jsonData;
}

-(void)doSendGameDataRemote:(NSData*)jsonData
{
    NSString* jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    //DLog("%@", jsonStr);
    
    NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:kAddLevelResultsForUserNameURL];
//    NSString* boundary = [[NSString alloc] initWithFormat:@"--manoa_%@", [[NSProcessInfo processInfo] globallyUniqueString]];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // Tell the server to expect 8-bit encoded content as we're sending UTF-8 data, and UTF-8 is an 8-bit encoding.
//    [urlRequest addValue:@"8bit" forHTTPHeaderField:@"Content-Transfer-Encoding"];
    
    // Set the content-type header to multipart MIME.
//    [urlRequest addValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField: @"Content-Type"];
    
    // Create a dictionary for all the fields you want to send in the POST request.
//    NSDictionary* postData = [NSDictionary dictionaryWithObjectsAndKeys:
//                              @"ADD", @"procedure",
//                              jsonStr, @"gameData", nil];
    
    // Set the body of the POST request to the multipart MIME encoded dictionary.
    //NSString* postStr = [self multipartMIMEStringWithDictionary:postData boundary:boundary];
    //NSString* postStr = [[NSString alloc] initWithFormat:@"procedure=ADD&gameData=%@", jsonStr];
    NSString* postStr = [[NSString alloc] initWithFormat:@"gameData=%@", [jsonStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //DLog("%@", postStr);
    [urlRequest setHTTPBody:[postStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    //DLog("Creating connection to send game data remotely.");
    
    @synchronized(mConnDataMap)
    {
        // Creating the connection starts the request automatically.
        NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
        
        if (connection != nil)
        {
            NSMutableData* receiveData = [[NSMutableData alloc] init];
            [mConnDataMap setObject:receiveData forKey:connection];
        }
    }
}

//-(NSString*)multipartMIMEStringWithDictionary:(NSDictionary*)dict boundary:(NSString*)boundary
//{
//    NSMutableString* result = [NSMutableString string];
//    
//    for (NSString* key in dict)
//    {
//        [result appendFormat:@"%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n%@\r\n", boundary, key, [dict objectForKey:key]];
//    }
//    
//    [result appendFormat:@"%@--\r\n", boundary];
//    
//    return result;
//}

//void doSendGameDataRemote(void* args)
//{
//    NSData* jsonData = (NSData*)args;
//    NSString* jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
//    DLog(@"%@", jsonStr);
//    
//    NSData* responseData = [NSData dataWithContentsOfURL:kAddLevelResultsForUserNameURL];
//}

@end

@implementation GameDataManager(GameOptionsDelegate)

-(void)autoSendGameDataOptionModified:(GameOptions*)gameOptions
{
    if (gameOptions.autoSendGameData != mSaveDataRemote)
    {
    }
}

@end

//@implementation GameDataManager(GameZoneDelegate)
//
//-(void)gameZoneFinished:(GameZone*)gameZone gameZoneData:(GameZoneData*)gameZoneData
//{
//    if (gameZoneData != nil)
//    {
//        [self saveGameData:gameZoneData];
//    }
//}
//
//@end

@implementation GameDataManager(NSURLConnectionDelegate)

//-(NSCachedURLResponse*)connection:(NSURLConnection*)connection willCacheResponse:(NSCachedURLResponse*)cachedResponse
//{
//    return nil;
//}

-(void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response
{
    //DLog("didReceiveResponse");
    
    if (connection != nil)
    {
        NSMutableData* receiveData = [mConnDataMap objectForKey:connection];
        
        if (receiveData != nil)
        {
            // Erase all previous data.
            [receiveData setLength:0];
        }
    }
}

-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    //DLog("didReceiveData");
    
    if (connection != nil)
    {
        NSMutableData* receiveData = [mConnDataMap objectForKey:connection];
        
        if (receiveData != nil)
        {
            // Add the data.
            [receiveData appendData:data];
        }
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    if (connection != nil)
    {
        NSMutableData* receiveData = [mConnDataMap objectForKey:connection];
        
        if (receiveData != nil)
        {
            //DLog("Succeeded! Received %d bytes of data", [receiveData length]);
            //NSString* receiveStr = [[NSString alloc]initWithData:receiveData encoding:NSUTF8StringEncoding];
            //DLog("Recieved Data: %@", receiveStr);
        }
        
        [mConnDataMap removeObjectForKey:connection];
    }
}

-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    DLog("Connection failed! Error - %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    if (connection != nil)
    {
        [mConnDataMap removeObjectForKey:connection];
    }
}

@end
