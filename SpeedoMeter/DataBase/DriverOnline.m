
//
//  DriverOnline.m
//  Spot Deals
//
//  Created by lemosys on 21/04/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//
//http://codingserver.com/speedtracker.com/webservices/updateSpeed
//
//post parameter.
//latititude,longitude,speed,user_id
//
//single post karna
//
//result aisa milega
//
//{"status":1,"message":"New Updated speed.","result":{"name":"cppatidar","speed":45,"location":"vijaynagar","id":142}}
#import "DriverOnline.h"
#import "AddUser.h"
#import "AppResourceObject.h"
#import "DriverOffline.h"
#import "SetLatlong.h"
#import "InviteFriends.h"
#import "NotificationMessege.h"

#import "AppDelegate.h"

#pragma mark Server Database Opration Constants

//http://speedtracker.in/webservices/

#define SIGNUP                                        @"addUser"
#define GETUSER                                      @"authentication"
#define CHANGEPASSWORD                       @"changePassword"
#define FORGETPASSWORD                        @"forgetPassword/"
#define ADDTRIP                                        @"addUserTrips"
#define ADDTRIPSTATUS                             @"addTripStatus/"
#define RADARLATLONGPOSOITION              @"getSpeedRadarList"
#define FBFRIENDS                         @"userFbFriend/"
#define FBFRIENDSINSPEEDTRACKER            @"userFbFriendInSpeedTracker"

#define INVITEFRIENDS                   @"inviteFriends"
#define GETALLNOTIFICATION                   @"getAllNotification"
#define GETNOTIFICATIONSTATUS                   @"acceptRequest"
#define GETALLFRIENDS              @"getUserAcceptedFriend"
#define UPDATESPEEDWITHLOCATION      @"updateSpeed"
#define CONNECTTOFACEBOOK                   @"updateFbId"

//http://codingserver.com/speedtracker.com/webservices/updateFbId

//postparameter-
//user_id,facebook_id

/*
 getUserAcceptedFriend
 accepted
 rejected
post variable-user_id,notification_id,is_accepted=accepted
1)http://codingserver.com/speedtracker.com/webservices/rejectRequest

post variabel sender=user_id

2)http://codingserver.com/speedtracker.com/webservices/acceptRequest
post variable=user_id
*/
//http://codingserver.com/speedtracker.com/webservices/inviteFriends
//
//post variable sender - user_id
//postvariable receiver - email
//
//http://codingserver.com/speedtracker.com/webservices/getAllNotification
//post variable-user_id

@implementation DriverOnline

@synthesize speedUpdateStatus;

- (id)init{

    self = [super init];
    if (self) {
        
        dbPathString = [(AppDelegate* )[[UIApplication sharedApplication] delegate] baseUrlString];


    }
    return self;
}


- (BOOL) setTripDetail{

    return TRUE;
}

- (NSMutableArray *)getCurrentLocation{
    NSMutableArray *data;
    return data;
}
- (BOOL) deleteTripDetail :(int)tripId{
    return TRUE;
}

- (NSMutableArray *)getSetting{
    NSMutableArray *data;
    return data;

}
- (BOOL) deleteuserDetail:(int)userId{
    return TRUE;
}
- (BOOL)setLatlong:(NSMutableArray *)record{
    return TRUE;
}
- (NSMutableArray *)getAllTripDetail{
    NSMutableArray *data;
    return data;
}
- (NSString *)getTotalSpeed{

    NSString *str;
    return str;
}
- (BOOL)updateSpeedDetail:(NSString *)speed
{
    return TRUE;
}
- (BOOL) updateTripDetail:(Trip *)trip{
    return TRUE;
}
- (BOOL)updatelatlongStatus:(int)status{
    return TRUE;
}
- (NSMutableArray *)getLatlong:(double)latitude withLongtitude:(double)longtitude{
    NSMutableArray *data;
    return data;

}
- (BOOL)updateSetting:(Setting *)setting{

    return TRUE;
}

- (NSMutableArray *)getLatlongStatus{
    NSMutableArray *data;
    return data;
}

- (BOOL)setLatlong:(NSString *)latitude withLongtitude:(NSString *)longtitude withlocation:(NSString *)location{
    return TRUE;
}
-  (BOOL)updateUserDetail{

    return TRUE;
}

- (BOOL)SetUser_Detail:(AddUser *)signUP{

    return TRUE;
}

- (NSMutableArray *)getUserDetail{

    NSMutableArray *data;
    return data;
}

- (NSMutableArray *)getTripDetail :(int)tripId{
    NSMutableArray *data;
    return data;
}


- (BOOL)SetUserDetail:(AddUser *)Add{
    appResourceObject = [AppResourceObject sharedAppResource];
    NSString *strURl = [dbPathString stringByAppendingString:SIGNUP];
    NSMutableString *postVariables = [[NSMutableString alloc] init];
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:Add.email_ID forKey:@"email"];
    [dic setValue:Add.password forKey:@"password"];
    [dic setValue:Add.deviceID forKey:@"device_id"];
    [dic setValue:Add.deviceToken forKey:@"device_token"];
    [dic setValue:Add.facebook_id forKey:@"facebook_id"];
    [dic setValue:Add.facebook_token forKey:@"facebook_token_id"];
     [dic setValue:[NSString stringWithFormat:@"%f",Add.usercurrentLat] forKey:@"latitude"];
     [dic setValue:[NSString stringWithFormat:@"%f",Add.usercurrentLang] forKey:@"longitude"];
     [dic setValue:Add.usercurrentLocation forKey:@"location"];
    [array addObject:dic];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array
                                                       options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //latitude,longitude,location
    NSLog(@"----------%@",jsonString);
    [postVariables appendFormat:@"&userjsonData=%@",jsonString];
    NSLog(@"postvariable%@",postVariables);

    NSData *postData = [NSData dataWithBytes:[postVariables UTF8String] length:[postVariables length]];

    NSMutableURLRequest *request;
    NSData *response;
    NSMutableArray *remoteData;

    if ([AppResourceObject sharedAppResource].connectionStatus) {

        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strURl]];
        NSLog(@"request%@",request);
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody:postData];
        NSLog(@"request%@",request);
        NSError *error;
     
        response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        NSLog(@"responce%@",response);
        NSLog(@"error%@",error);

        if (!error) {
            if (response!=nil) {
                NSString* newStr = [[NSString alloc] initWithData:response
                                                         encoding:NSUTF8StringEncoding];
                NSLog(@"%@", newStr);
                NSString  *arrDataSource=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
                
                NSLog(@"string is %@",arrDataSource);
                
                
                NSString *string = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
                
                NSString *jsonString = [[NSString alloc] initWithData:response encoding: NSUTF8StringEncoding];
                
                NSLog(@"str=%@",jsonString);
                remoteData = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
                
                
                NSLog(@"remotedata%@",string);
                NSLog(@"error%@",error);
  
            }
        }
        
    }

    if (remoteData.count>0) {

        [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"status"] forKey:@"registrationStaus"];
        [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"is_connected"] forKey:@"connectedTofacebook"];
        [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"user_id"] forKey:@"user_id"];
        [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"name"] forKey:@"username"];
        
        NSMutableArray *array = [remoteData valueForKey:@"user_data"];
        [[NSUserDefaults standardUserDefaults] setObject:[array valueForKey:@"image"] forKey:@"userImage"];
        
        
        AddUser *obj=[[AddUser alloc]init];
        obj.user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
        obj.user_status=[[NSUserDefaults standardUserDefaults]objectForKey:@"status"];
        [[[DriverOffline alloc] init] SetUser_Detail:obj];
        NSMutableArray *fb_detail = [[[DriverOffline alloc] init] getFacebookStatus];
        if (fb_detail.count==0) {
            [[[DriverOffline alloc] init] setFacebookStatus];
        }

    }else{

        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"registrationStaus"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"user_id"];

    }

    return TRUE;
}

- (BOOL)getUserDetail:(AddUser *)Add{
    
    
    NSString *strURl = [dbPathString stringByAppendingString:GETUSER];
    NSMutableString *postVariables = [[NSMutableString alloc] init];
    [postVariables appendFormat:@"&username=%@",Add.email_ID];
    [postVariables appendFormat:@"&password=%@",Add.password];
    NSLog(@"post is %@",postVariables);
    NSData *postData = [NSData dataWithBytes:[postVariables UTF8String] length:[postVariables length]];

    NSMutableURLRequest *request;
    NSData *response;
    NSMutableArray *remoteData;

    if ([AppResourceObject sharedAppResource].connectionStatus) {

        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strURl]];
     NSLog(@"post is %@",request);
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody:postData];
        NSLog(@"request is %@",request);
        NSError *error;
        
        response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        NSLog(@"response is %@",response);
        
        NSLog(@"error is %@",error);

        if (!error)
        {
            if (response != nil)
            {
                NSString* newStr = [[NSString alloc] initWithData:response
                                                         encoding:NSUTF8StringEncoding];
                NSLog(@"%@", newStr);
                NSString  *arrDataSource=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
                
                NSLog(@"string is %@",arrDataSource);
                
                remoteData = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments|NSJSONReadingMutableLeaves error:&error];
                NSLog(@"error is %@",error);
                

                
            }
        }
       
       
    }if (remoteData.count>0) {


    [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"message"] forKey:@"message"];
    [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"status"] forKey:@"status"];
        NSLog(@"%@",[remoteData valueForKey:@"is_connected"]);
    [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"is_connected"] forKey:@"connectedTofacebook"];
    if ([[remoteData valueForKey:@"status"] integerValue]==1) {

        NSMutableArray *array = [remoteData valueForKey:@"user_data"];

        [[NSUserDefaults standardUserDefaults] setObject:[array valueForKey:@"user_id"] forKey:@"user_id"];
           [[NSUserDefaults standardUserDefaults] setObject:[array valueForKey:@"name"] forKey:@"username"];
          [[NSUserDefaults standardUserDefaults] setObject:[array valueForKey:@"image"] forKey:@"userImage"];
     [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"status"] forKey:@"status"];
        AddUser *obj=[[AddUser alloc]init];
        obj.user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
        obj.user_status=[[NSUserDefaults standardUserDefaults]objectForKey:@"status"];
        [[[DriverOffline alloc] init] SetUser_Detail:obj];
       
    }else{

        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"user_id"];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"status"];

    }
}
    return TRUE;

}

- (NSMutableArray *)changePassword:(NSString *)string withConfirmPassword:(NSString *)string2
{

    NSString *strURl = [dbPathString stringByAppendingString:CHANGEPASSWORD];
  
    
    
    NSMutableString *postVariables = [[NSMutableString alloc] init];
    [postVariables appendFormat:@"&user_id=%@",[NSString stringWithFormat:@"%d",(int)[[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] integerValue]]];
    
    [postVariables appendFormat:@"&old_password=%@",[NSString stringWithFormat:@"%@",string]];
    [postVariables appendFormat:@"&new_password=%@",[NSString stringWithFormat:@"%@",string2]];
    
    
    NSMutableString *str = [[NSMutableString alloc] init];
    [str appendString:strURl];
    [str appendString:postVariables];
    NSLog(@"string is %@",str);
    NSData *postData = [NSData dataWithBytes:[postVariables UTF8String] length:[postVariables length]];
    
    NSMutableURLRequest *request;
    NSData *response;
    NSMutableArray *remoteData;
    
    if ([AppResourceObject sharedAppResource].connectionStatus) {
        
        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strURl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody:postData];
        NSError *error;
        response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
      
        NSLog(@"responce%@",response);
        if (!error) {
            if (response!=nil) {
                NSString* newStr = [[NSString alloc] initWithData:response
                                                         encoding:NSUTF8StringEncoding];
                NSLog(@"%@", newStr);
                NSString  *arrDataSource=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
                
                NSLog(@"string is %@",arrDataSource);
                
                
                NSString *str=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
                NSLog(@"rremote data is %@",str);
                NSLog(@"error data is %@",error);
                remoteData = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
                NSLog(@"rremote data is %@",remoteData);
                NSLog(@"error data is %@",error);
                
            }
        }
       
    }
    NSLog(@"rremote data is %@",remoteData);
    NSMutableArray *data = [[NSMutableArray alloc] init];
    
    if (remoteData.count>0) {
        
        [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"message"] forKey:@"passwordupdatedMessage"];
        [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"status"] forKey:@"passwordupdatedStatus"];
    
    }
    return data;
    
}

- (NSMutableArray *)forgetPassword:(NSString *)string;
{
    NSString *strURl = [dbPathString stringByAppendingString:FORGETPASSWORD];
    
    NSMutableString *postVariables = [[NSMutableString alloc] init];
    [postVariables appendFormat:@"&email=%@",[NSString stringWithFormat:@"%@",string]];
    
    NSMutableString *str = [[NSMutableString alloc] init];
    [str appendString:strURl];
    [str appendString:postVariables];
    NSLog(@"string is %@",str);
    NSData *postData = [NSData dataWithBytes:[postVariables UTF8String] length:[postVariables length]];
    
    NSMutableURLRequest *request;
    NSData *response;
    NSMutableArray *remoteData;
    
    if ([AppResourceObject sharedAppResource].connectionStatus) {
        
        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strURl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody:postData];
        NSError *error;
        response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        NSLog(@"responce%@",response);
        // NSString *str=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
        // NSLog(@"rremote data is %@",str);
        // NSLog(@"error data is %@",error);
        if (!error) {
            if (response!=nil) {
                NSString* newStr = [[NSString alloc] initWithData:response
                                                         encoding:NSUTF8StringEncoding];
                NSLog(@"%@", newStr);
                NSString  *arrDataSource=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
                
                NSLog(@"string is %@",arrDataSource);
                
                NSString *string = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
                NSLog(@"string is %@",string);
                NSLog(@"error data is %@",error);
                
                remoteData = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
                NSLog(@"rremote data is %@",remoteData);
                NSLog(@"error data is %@",error);
 
            }
        }
        
    }
    NSLog(@"rremote data is %@",remoteData);
    NSMutableArray *data = [[NSMutableArray alloc] init];
    
    if (remoteData.count>0) {
        
        [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"message"] forKey:@"forgetpasswordupdatedMessage"];
        [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"status"] forKey:@"forgetpasswordupdatedStatus"];
        
    }
    return data;
    
}

- (BOOL)addTrip:(NSMutableArray *)trip_detail{

    NSString *strURl = [dbPathString stringByAppendingString:ADDTRIP];
   
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:trip_detail
                                                       options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    NSMutableString *postVariables = [[NSMutableString alloc] init];
   // [postVariables appendFormat:@"&tripstatusjsonData=%@",jsonString];
     [postVariables appendFormat:@"&usertripaddjson=%@",jsonString];

    NSMutableString *str = [[NSMutableString alloc] init];
    [str appendString:strURl];
    [str appendString:postVariables];
    NSLog(@"string is %@",str);
    NSData *postData = [NSData dataWithBytes:[postVariables UTF8String] length:[postVariables length]];

    NSMutableURLRequest *request;
    NSData *response;
    NSMutableArray *remoteData;

    if ([AppResourceObject sharedAppResource].connectionStatus) {

        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strURl]];

        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody:postData];
        NSError *error;
        response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];

        NSLog(@"responce%@",response);
        // NSString *str=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
        // NSLog(@"rremote data is %@",str);
        // NSLog(@"error data is %@",error);
        if (!error) {
            if (response!=nil) {
                NSString* newStr = [[NSString alloc] initWithData:response
                                                         encoding:NSUTF8StringEncoding];
                NSLog(@"%@", newStr);
                NSString  *arrDataSource=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
                
                NSLog(@"string is %@",arrDataSource);
                
                NSString *string = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
                NSLog(@"string is %@",string);
                NSLog(@"error data is %@",error);
                
                
                remoteData = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
                NSLog(@"rremote data is %@",remoteData);
                NSLog(@"error data is %@",error);
  
            }
        }
       
    }
    NSLog(@"rremote data is %@",remoteData);

    if (remoteData.count>0) {

//        [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"message"] forKey:@"forgetpasswordupdatedMessage"];
//        [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"status"] forKey:@"forgetpasswordupdatedStatus"];
        return YES;

    }
    return NO;


}



- (NSMutableArray *)getFacebookFriends:(NSMutableArray *)string

{
    NSString *strURl =[dbPathString stringByAppendingString:FBFRIENDS];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:string
                                                       options:NSJSONWritingPrettyPrinted error:nil];
   NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
   

    NSMutableString *postVariables = [[NSMutableString alloc] init];
    [postVariables appendFormat:@"userFbFriend=%@",jsonString];
    
    NSLog(@"json string is %@",postVariables);
    
    NSMutableString *str = [[NSMutableString alloc] init];
    [str appendString:strURl];
    [str appendString:postVariables];
    NSLog(@"string is %@",str);
    NSData *postData = [NSData dataWithBytes:[postVariables UTF8String] length:[postVariables length]];
    
    NSMutableURLRequest *request;
    NSData *response;
    NSMutableArray *remoteData;
    
    if ([AppResourceObject sharedAppResource].connectionStatus) {
        
        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strURl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody:postData];
        NSError *error;
        response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        NSLog(@"responce%@",response);
        NSLog(@"error is %@",error);
        if (!error) {
            if (response!=nil) {
                NSString* newStr = [[NSString alloc] initWithData:response
                                                         encoding:NSUTF8StringEncoding];
                NSLog(@"%@", newStr);
                NSString  *arrDataSource=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
                
                NSLog(@"string is %@",arrDataSource);
                
                NSString *string = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
                NSLog(@"string is %@",string);
                NSLog(@"error data is %@",error);
                
                
                remoteData = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
                NSLog(@"rremote data is %@",remoteData);
                NSLog(@"error data is %@",error);
                
                NSLog(@"rremote data is %@",remoteData);
                NSLog(@"remote data count si %lu",(unsigned long)remoteData.count);
                NSLog(@"remote data is %@",remoteData);
                NSLog(@"remote data count is %lu",(unsigned long)remoteData.count);
  
            }
        }
        
    }
    
    
        if (remoteData.count>0) {
            
            NSMutableArray *friends_data = [[NSMutableArray alloc] init];
            InviteFriends *invitefriends;
       
            
            for (NSDictionary *dict in remoteData) {
                
                invitefriends = [[InviteFriends alloc] init];
                
                if ([[dict objectForKey:@"fb_id"] isEqual:[NSNull null]]) {
                    invitefriends.fb_id = @"";
                }else{
                    invitefriends.fb_id  = [dict objectForKey:@"fb_id"];
                }
                
                if ([[dict objectForKey:@"name"] isEqual:[NSNull null]]) {
                    invitefriends.fb_name = @"";
                }else{
                    invitefriends.fb_name  = [dict objectForKey:@"name"];
                }
                invitefriends.fb_image = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",invitefriends.fb_id];
                NSLog(@"fb image is %@",invitefriends.fb_image);
                invitefriends.isCheckd = FALSE;
                
                [friends_data addObject:invitefriends];
            }
            return friends_data;
        }
        return remoteData;
    }

- (NSMutableArray *)getFacebookFriendsInSpeedTracker:(NSMutableArray *)string;
{
    NSString *strURl =[dbPathString stringByAppendingString:FBFRIENDSINSPEEDTRACKER];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:string
                                                       options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    NSMutableString *postVariables = [[NSMutableString alloc] init];
    [postVariables appendFormat:@"userFbFriend=%@",jsonString];
    
    NSLog(@"json string is %@",postVariables);
    
    NSMutableString *str = [[NSMutableString alloc] init];
    [str appendString:strURl];
    [str appendString:postVariables];
    NSLog(@"string is %@",str);
    NSData *postData = [NSData dataWithBytes:[postVariables UTF8String] length:[postVariables length]];
    
    NSMutableURLRequest *request;
    NSData *response;
    NSMutableArray *remoteData;
    
    if ([AppResourceObject sharedAppResource].connectionStatus) {
        
        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strURl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody:postData];
        NSError *error;
        response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        NSLog(@"responce%@",response);
        NSLog(@"error is %@",error);
        if (!error) {
            if (response!=nil) {
                NSString* newStr = [[NSString alloc] initWithData:response
                                                         encoding:NSUTF8StringEncoding];
                NSLog(@"%@", newStr);
                NSString  *arrDataSource=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
                
                NSLog(@"string is %@",arrDataSource);
                
                NSString *string = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
                NSLog(@"string is %@",string);
                NSLog(@"error data is %@",error);
                
                
                remoteData = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
                NSLog(@"rremote data is %@",remoteData);
                NSLog(@"error data is %@",error);
                NSLog(@"rremote data is %@",remoteData);
                NSLog(@"remote data count si %lu",(unsigned long)remoteData.count);
                NSLog(@"remote data is %@",remoteData);
                NSLog(@"remote data count is %lu",(unsigned long)remoteData.count);

  
            }
        }
        
    }
    
    
       if (remoteData.count>0) {
        
        NSMutableArray *friends_data = [[NSMutableArray alloc] init];
        InviteFriends *invitefriends;
        
        
        for (NSDictionary *dict in remoteData) {
            
            invitefriends = [[InviteFriends alloc] init];
            
            if ([[dict objectForKey:@"fb_id"] isEqual:[NSNull null]]) {
                invitefriends.fb_id = @"";
            }else{
                invitefriends.fb_id  = [dict objectForKey:@"fb_id"];
            }
            
            if ([[dict objectForKey:@"name"] isEqual:[NSNull null]]) {
                invitefriends.fb_name = @"";
            }else{
                invitefriends.fb_name  = [dict objectForKey:@"name"];
            }
            invitefriends.fb_image = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",invitefriends.fb_id];
            NSLog(@"fb image is %@",invitefriends.fb_image);
            invitefriends.isCheckd = FALSE;
            
            [friends_data addObject:invitefriends];
        }
        return friends_data;
    }
    return remoteData;

}
- (BOOL)inviteFriends:(NSString*)string{
    NSString *strURl = [dbPathString stringByAppendingString:INVITEFRIENDS];
    
    NSMutableString *postVariables = [[NSMutableString alloc] init];
    [postVariables appendFormat:@"&user_id=%@",[NSString stringWithFormat:@"%d",(int)[[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] integerValue]]];
    
    [postVariables appendFormat:@"&email=%@",[NSString stringWithFormat:@"%@",string]];
    
    NSMutableString *str = [[NSMutableString alloc] init];
    [str appendString:strURl];
    [str appendString:postVariables];
    NSLog(@"string is %@",str);
    NSData *postData = [NSData dataWithBytes:[postVariables UTF8String] length:[postVariables length]];
    
    NSMutableURLRequest *request;
    NSData *response;
    NSMutableArray *remoteData;
    
    if ([AppResourceObject sharedAppResource].connectionStatus) {
        
        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strURl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody:postData];
        NSError *error;
        response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        NSLog(@"responce%@",response);
        if (!error) {
            if (response!=nil) {
                NSString* newStr = [[NSString alloc] initWithData:response
                                                         encoding:NSUTF8StringEncoding];
                NSLog(@"%@", newStr);
                NSString  *arrDataSource=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
                
                NSLog(@"string is %@",arrDataSource);
                
                
                NSString *str=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
                NSLog(@"rremote data is %@",str);
                NSLog(@"error data is %@",error);
                remoteData = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
                NSLog(@"rremote data is %@",remoteData);
                NSLog(@"error data is %@",error);
            }
        }
      
        
    }
    
    if (remoteData.count>0) {
        
        [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"message"] forKey:@"Message"];
        [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"status"] forKey:@"Status"];
        return TRUE;
        
    }
    return FALSE;
    

}
- (NSMutableArray *)getAllnotification{
    
    NSString *strURl = [dbPathString stringByAppendingString:GETALLNOTIFICATION];
    NSMutableString *postVariables = [[NSMutableString alloc] init];
    [postVariables appendFormat:@"&user_id=%@",[NSString stringWithFormat:@"%d",(int)[[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] integerValue]]];
    
    NSMutableString *str = [[NSMutableString alloc] init];
    [str appendString:strURl];
    [str appendString:postVariables];
    NSLog(@"string is %@",str);
    NSData *postData = [NSData dataWithBytes:[postVariables UTF8String] length:[postVariables length]];
    
    NSMutableURLRequest *request;
    NSData *response;
    NSMutableArray *remoteData;
    
    if ([AppResourceObject sharedAppResource].connectionStatus) {
        
        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strURl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody:postData];
        NSError *error;
        response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        NSLog(@"responce%@",response);
        if (!error) {
            if (response!=nil) {
                NSString* newStr = [[NSString alloc] initWithData:response
                                                         encoding:NSUTF8StringEncoding];
                NSLog(@"%@", newStr);
                NSString  *arrDataSource=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
                
                NSLog(@"string is %@",arrDataSource);
                
                
                NSString *str=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
                NSLog(@"rremote data is %@",str);
                NSLog(@"error data is %@",error);
                remoteData = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
                NSLog(@"rremote data is %@",remoteData);
                NSLog(@"error data is %@",error);
                

                
    }
        }
           }
    NSMutableArray *data = [[NSMutableArray alloc] init];
    NotificationMessege *messeges;
    [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"status"] forKey:@"notificationStatus"];
    NSMutableArray *extractedArr=[remoteData valueForKey:@"result"];
    NSLog(@"extractedArr %@",extractedArr);
    if ([[remoteData valueForKey:@"status"] integerValue]==1)
    {
    for (NSDictionary *dict in extractedArr) {
        
        messeges = [[NotificationMessege alloc] init];
        messeges.notificationMesseges=[dict valueForKey:@"message"];
        messeges.reciverId=[[dict valueForKey:@"friend_id"]intValue];
        [data addObject:messeges];
        
    }
    return data;
    }
    
    return FALSE;

}



- (BOOL)notificationStatus:(NSString*)status withNotificationId:(int)notificationId{
    
    NSString *strURl = [dbPathString stringByAppendingString:GETNOTIFICATIONSTATUS];
    NSMutableString *postVariables = [[NSMutableString alloc] init];
  //  user_id,notification_id,is_accepted=accepted
    [postVariables appendFormat:@"&user_id=%@",[NSString stringWithFormat:@"%d",(int)[[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] integerValue]]];
    
     [postVariables appendFormat:@"&friend_id=%@",[NSString stringWithFormat:@"%d",notificationId]];
    
      [postVariables appendFormat:@"&is_accepted=%@",[NSString stringWithFormat:@"%@",status]];
    
    NSMutableString *str = [[NSMutableString alloc] init];
    [str appendString:strURl];
    [str appendString:postVariables];
    NSLog(@"string is %@",str);
    NSData *postData = [NSData dataWithBytes:[postVariables UTF8String] length:[postVariables length]];
    
    NSMutableURLRequest *request;
    NSData *response;
    NSMutableArray *remoteData;
    
    if ([AppResourceObject sharedAppResource].connectionStatus) {
        
        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strURl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody:postData];
        NSError *error;
        response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        NSLog(@"responce%@",response);
        if (!error) {
            if (response!=nil) {
                NSString* newStr = [[NSString alloc] initWithData:response
                                                         encoding:NSUTF8StringEncoding];
                NSLog(@"%@", newStr);
                NSString  *arrDataSource=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
                
                NSLog(@"string is %@",arrDataSource);
                
                
                NSString *str=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
                NSLog(@"rremote data is %@",str);
                NSLog(@"error data is %@",error);
                remoteData = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
                NSLog(@"rremote data is %@",remoteData);
                NSLog(@"error data is %@",error);
            }
        }
        
    }
    
    if (remoteData.count>0){
        
        [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"message"] forKey:@"Message"];
        [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"status"] forKey:@"Status"];
        return TRUE;
        
    }
    return FALSE;
    
    
}

- (NSMutableArray *)getAllFriends{
    
    NSString *strURl = [dbPathString stringByAppendingString:GETALLFRIENDS];
    NSMutableString *postVariables = [[NSMutableString alloc] init];
    [postVariables appendFormat:@"&user_id=%@",[NSString stringWithFormat:@"%d",(int)[[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] integerValue]]];
    
    NSMutableString *str = [[NSMutableString alloc] init];
    [str appendString:strURl];
    [str appendString:postVariables];
    NSLog(@"string is %@",str);
    NSData *postData = [NSData dataWithBytes:[postVariables UTF8String] length:[postVariables length]];
    
    NSMutableURLRequest *request;
    NSData *response;
    NSMutableArray *remoteData;
    
    if ([AppResourceObject sharedAppResource].connectionStatus) {
        
        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strURl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody:postData];
        NSError *error;
        response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        NSLog(@"responce%@",response);
        if (!error) {
            if (response!=nil) {
                NSString* newStr = [[NSString alloc] initWithData:response
                                                         encoding:NSUTF8StringEncoding];
                NSLog(@"%@", newStr);
                NSString  *arrDataSource=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
                
                NSLog(@"string is %@",arrDataSource);
                
                
                NSString *str=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
                NSLog(@"rremote data is %@",str);
                NSLog(@"error data is %@",error);
                remoteData = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
                NSLog(@"rremote data is %@",remoteData);
                NSLog(@"error data is %@",error);
            }
        }
        
        
    }
    NSMutableArray *data = [[NSMutableArray alloc] init];
    InviteFriends *friends;
    NSMutableArray *extractedArr=[remoteData valueForKey:@"result"];
    NSLog(@"extractedArr %@",extractedArr);
    if ([[remoteData valueForKey:@"status"] integerValue]==1)
    {
//
        for (NSDictionary *dict in extractedArr) {
            
            friends = [[InviteFriends alloc] init];
            friends.register_friendName=[dict valueForKey:@"name"];
            friends.friendslattitude=[[dict valueForKey:@"latitude"]doubleValue];
            friends.friendslongitude=[[dict valueForKey:@"longitude"]doubleValue];
            friends.friendsspeed=[[dict valueForKey:@"speed"]intValue];
            friends.friendslocationName=[dict valueForKey:@"location"];
            friends.friends_image=[dict valueForKey:@"image"];
           [data addObject:friends];
            
        }
        return data;
    }
    return FALSE;
}

-(BOOL)updateUserSpeedWithLocation
{
    NSString *strURl = [dbPathString stringByAppendingString:UPDATESPEEDWITHLOCATION];
    NSMutableString *postVariables = [[NSMutableString alloc] init];
    //  user_id,notification_id,is_accepted=accepted
    [postVariables appendFormat:@"&user_id=%@",[NSString stringWithFormat:@"%d",(int)[[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] integerValue]]];
    [postVariables appendFormat:@"&latititude=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"newlatitude"]];
    
    [postVariables appendFormat:@"&longitude=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"newlongtitude"]];
     [postVariables appendFormat:@"&location=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"currentLocation"]];
    
   [postVariables appendFormat:@"&speed=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"topSpeed"]];
    
    NSMutableString *str = [[NSMutableString alloc] init];
    [str appendString:strURl];
    [str appendString:postVariables];
    NSLog(@"string is %@",str);
    NSData *postData = [NSData dataWithBytes:[postVariables UTF8String] length:[postVariables length]];
    
    NSMutableURLRequest *request;
   // NSData *response;
   // NSMutableArray *remoteData;
    
    if ([AppResourceObject sharedAppResource].connectionStatus) {
        
        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strURl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody:postData];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
        {
            NSLog(@"Speed Updated");
            speedUpdateStatus = TRUE;
        }];
        
        
//        NSLog(@"responce%@",response);
//        if (!error)
//        {
//            if (response!=nil)
//            {
//                NSString* newStr = [[NSString alloc] initWithData:response
//                                                         encoding:NSUTF8StringEncoding];
//                NSLog(@"%@", newStr);
//                NSString  *arrDataSource=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//                
//                NSLog(@"string is %@",arrDataSource);
//                
//                
//                NSString *str=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
//                NSLog(@"rremote data is %@",str);
//                NSLog(@"error data is %@",error);
//                remoteData = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
//                NSLog(@"rremote data is %@",remoteData);
//                NSLog(@"error data is %@",error);
//                
//  
//            }
//        }
//    }
//    
//    if (remoteData.count>0)
//    {
//        [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"message"] forKey:@"Message"];
//        [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"status"] forKey:@"Status"];
//        return TRUE;
//    }
//    
//    return FALSE;
    }
    return FALSE;

}

-(BOOL)connectToFacebook:(AddUser *)connectToFacebook
{
    appResourceObject = [AppResourceObject sharedAppResource];
    NSString *strURl = [dbPathString stringByAppendingString:CONNECTTOFACEBOOK];
    NSMutableString *postVariables = [[NSMutableString alloc] init];
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:connectToFacebook.email_ID forKey:@"email"];
    [dic setValue:connectToFacebook.password forKey:@"password"];
    [dic setValue:connectToFacebook.deviceID forKey:@"device_id"];
    [dic setValue:connectToFacebook.deviceToken forKey:@"device_token"];
    [dic setValue:connectToFacebook.facebook_id forKey:@"facebook_id"];
    [dic setValue:connectToFacebook.user_id forKey:@"user_id"];
    [dic setValue:connectToFacebook.facebook_token forKey:@"facebook_token_id"];
    [dic setValue:[NSString stringWithFormat:@"%f",connectToFacebook.usercurrentLat] forKey:@"latitude"];
    [dic setValue:[NSString stringWithFormat:@"%f",connectToFacebook.usercurrentLang] forKey:@"longitude"];
    [dic setValue:connectToFacebook.usercurrentLocation forKey:@"location"];
    [array addObject:dic];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array
                                                       options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //latitude,longitude,location
    NSLog(@"----------%@",jsonString);
    [postVariables appendFormat:@"&userjsonData=%@",jsonString];
    NSLog(@"postvariable%@",postVariables);
    
    NSData *postData = [NSData dataWithBytes:[postVariables UTF8String] length:[postVariables length]];
    
    NSMutableURLRequest *request;
    NSData *response;
    NSMutableArray *remoteData;
    
    if ([AppResourceObject sharedAppResource].connectionStatus) {
        
        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strURl]];
        NSLog(@"request%@",request);
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody:postData];
        NSLog(@"request%@",request);
        NSError *error;
        
        response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        NSLog(@"responce%@",response);
        NSLog(@"error%@",error);
        
        if (!error) {
            if (response!=nil) {
                NSString* newStr = [[NSString alloc] initWithData:response
                                                         encoding:NSUTF8StringEncoding];
                NSLog(@"%@", newStr);
                NSString  *arrDataSource=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
                
                NSLog(@"string is %@",arrDataSource);
                
                
                NSString *string = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
                
                NSString *jsonString = [[NSString alloc] initWithData:response encoding: NSUTF8StringEncoding];
                
                NSLog(@"str=%@",jsonString);
                remoteData = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
                
                
                NSLog(@"remotedata%@",string);
                NSLog(@"error%@",error);
                
            }
        }
        
    }
    
    if (remoteData.count>0) {
        
        [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"status"] forKey:@"registrationStaus"];
        [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"user_id"] forKey:@"user_id"];
        AddUser *obj=[[AddUser alloc]init];
        obj.user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
        obj.user_status=[[NSUserDefaults standardUserDefaults]objectForKey:@"status"];
        [[[DriverOffline alloc] init] SetUser_Detail:obj];
        NSMutableArray *fb_detail = [[[DriverOffline alloc] init] getFacebookStatus];
        if (fb_detail.count==0) {
            [[[DriverOffline alloc] init] setFacebookStatus];
        }
        
    }else{
        
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"registrationStaus"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"user_id"];
        
    }
    
    return TRUE;
  }

@end
