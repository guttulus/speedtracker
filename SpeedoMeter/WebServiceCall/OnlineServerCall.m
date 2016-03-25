
//
//  ServerCalls.m
//  
//
//  Created by Apple on 02/07/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "OnlineServerCall.h"
#import "AppDelegate.h"
#import "Reachability.h"

static OnlineServerCall *singletonInstance;

@implementation OnlineServerCall

- (id)init
{
    self = [super init];
    
    if (self)
    {
        appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

#pragma mark Factory Method

+ (OnlineServerCall *)getSingletonInstance
{
  if (!singletonInstance)
  {
    singletonInstance = [[OnlineServerCall alloc] init];
  }
  return singletonInstance;
}


#pragma mark Network Check Methods

- (BOOL) connectedToNetwork
{
	Reachability *r = [Reachability reachabilityForInternetConnection];
    //[Reachability reachabilityWithHostName:@"kumoteamdemo.pagodabox.com"];
	NetworkStatus internetStatus = [r currentReachabilityStatus];
	BOOL internet;
    
	if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN))
    {
		internet = NO;
	}
    else
    {
		internet = YES;
	}
	return internet;
}

-(BOOL) checkInternet
{
	//Make sure we have internet connectivity
	if([self connectedToNetwork] != YES)
	{
		return NO;
	}
	else
    {
		return YES;
	}
}

#pragma mark Server Call

- (NSString *) getBaseUrlString:(NSString*)appName secret:(NSString*)appKey withClient:(NSString*)client
{
    NSString *responseStr;
    
    NSMutableURLRequest *request=(NSMutableURLRequest*)[NSMutableURLRequest requestWithURL:nil cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:600.0];
    
    NSString *tempUrlString = [NSString stringWithFormat:@"http://cdn.lemosys.com/speedtracker/apiaccess.php?api_key=74795e9b3f5844081d19fe46e40f4f0c&app_name=speedtracker&app_client=ios"];
    [request setURL:[NSURL URLWithString:tempUrlString]];

    //NSMutableData *postbody = [NSMutableData data];
    
    //[postbody appendData:[[NSString stringWithFormat:@"&api_key=%@",appKey]dataUsingEncoding:NSUTF8StringEncoding]];
   // [postbody appendData:[[NSString stringWithFormat:@"&app_name=%@",appName]dataUsingEncoding:NSUTF8StringEncoding]];
    //[postbody appendData:[[NSString stringWithFormat:@"&app_client=ios"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //NSString * dataLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postbody length]];
    
    //[request addValue:dataLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod: @"GET" ];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    //[request setHTTPBody: postbody ];
    
    NSLog(@"request===%@",[request allHTTPHeaderFields]);
    NSLog(@"URL=====%@",[request URL]);
    NSLog(@"request===%@",request);
    
    NSError *error = nil;
    NSURLResponse *urlResponse = nil;
    
    if([self checkInternet])
    {
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        if(error==nil)
        {
            responseStr= [[NSString alloc] initWithData:returnData encoding:NSASCIIStringEncoding];
            NSLog(@"ServerResponse===%@",responseStr);
        }
        else
        {
            NSLog(@"%@",error);
            responseStr = @"Server not responding!!!";
        }
        return responseStr;
    }
    else
    {
        return @"Network not Available.";
    }
}
@end
