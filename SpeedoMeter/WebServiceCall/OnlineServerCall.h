//
//  ServerCalls.h
//  

#import <Foundation/Foundation.h>
#import "AlertView.h"
@class AppDelegate;

@interface OnlineServerCall : NSObject
{
    AppDelegate *appDelegate;
}

+ (OnlineServerCall *)getSingletonInstance;

- (NSString *) getBaseUrlString:(NSString*)appName secret:(NSString*)appKey withClient:(NSString*)client;

@end
