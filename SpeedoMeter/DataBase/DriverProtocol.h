//
//  DriverProtocol.h
//  Dcompras
//
//  Created by Lemosys on 22/12/12.
//  Copyright (c) 2012 Lemosys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Trip.h"
#import "Setting.h"
#import "AddUser.h"
#import  "GetLatLong.h"

@protocol DriverProtocol <NSObject>
@optional
- (BOOL) setTripDetail;
- (NSMutableArray *)getTripDetail :(int)tripId;
- (BOOL) updateTripDetail:(Trip *)trip;
- (BOOL) deleteTripDetail :(int)tripId;
- (BOOL)updateSpeedDetail:(NSString *)speed;
- (NSString *)getTotalSpeed;
//- (NSMutableArray *)getLatlong:(double)latitude withLongtitude:(double)longtitude;
- (NSMutableArray *)getAllTripDetail;
- (NSMutableArray *)getSetting;
- (BOOL)updateSetting:(Setting *)setting;
- (NSMutableArray *)getCurrentLocation;
- (BOOL)SetUserDetail:(AddUser *)Add;
- (BOOL)getUserDetail:(AddUser *)Add;
- (NSMutableArray *)changePassword:(NSString *)string withConfirmPassword:(NSString *)string2;
- (NSMutableArray *)forgetPassword:(NSString *)string;
- (NSMutableArray *)getLatlongStatus;
- (BOOL)setLatlong:(NSMutableArray *)record;
- (BOOL)updatelatlongStatus:(int)status;
- (BOOL) deleteuserDetail:(int)userId;
///////////
//- (BOOL)setLatlong:(NSString *)latitude withLongtitude:(NSString *)longtitude withlocation:(NSString *)location;

- (NSMutableArray *)getlatlongposition;
- (NSMutableArray *)getLatlong:(GetLatLong *)getLatlong;
- (BOOL)updatelatlong:(GetLatLong *)getLatlong;
- (BOOL)updatelatlong:(NSString *)latitude withLongtitude:(NSString *)longtitude;
- (BOOL)addTrip:(NSMutableArray *)trip_detail;

- (NSString *)getTotalSpeedLatlong;
- (BOOL)updateTotalSpeedLatlong:(int)status;
- (BOOL)SetUser_Detail:(AddUser *)signUP;
- (NSMutableArray *)getUserDetail;
-  (BOOL)updateUserDetail;
-(BOOL)thanksNothanks:(NSMutableArray *)thanks;
- (NSMutableArray *)getFacebookStatus;
- (BOOL)setFacebookStatus;
- (BOOL)updateFaceBookStatus;
- (NSMutableArray *)getFacebookFriends:(NSMutableArray *)string;
- (NSMutableArray *)getFacebookFriendsInSpeedTracker:(NSMutableArray *)string;
- (BOOL)inviteFriends:(NSString*)string;
- (NSMutableArray *)getAllnotification;
- (BOOL)notificationStatus:(NSString*)status withNotificationId:(int)notificationId;
- (NSMutableArray *)getAllFriends;
-(BOOL)updateUserSpeedWithLocation;
-(BOOL)connectToFacebook:(AddUser *)connectToFacebook;

@end
