//
//  AppResourceObject.h
//  Tasbihat
//
//  Created by Lemosys on 30/07/13.
//  Copyright (c) 2013 Lemosys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface AppResourceObject : NSObject{

}
@property(assign)BOOL connectionStatus;
@property(assign)int tripId;
@property(assign)int connectionCheck;
@property(assign)int maximumSpeedCounter;
@property(assign)int maximumZoom;
@property(assign)int minimumZoom;
@property(assign)int calculateAverageSpeedCount;
@property(assign)int speedCount;
@property(assign)int totalSeconds;
@property(assign)int traveltotalSecond;
@property(assign)int trackingSignalCount;
@property(assign)int maximumSpeedCount;
@property(assign)int calculateMaximumSpeed;
@property(assign)BOOL isDeleted;
@property(assign)BOOL trackinButtonVisible;
@property(assign)BOOL trackingAction;
@property(assign)BOOL isTrackingStatus;
@property(assign)BOOL isScreenAnimation;
@property(assign)BOOL isGetOldLocation;
@property(assign)BOOL isAvgSpeed;
@property(assign)BOOL allocAvgSpeedArray;
@property(assign)BOOL istrackingTravelTime;
@property(strong,nonatomic)NSString *trackingStatus;
@property(strong,nonatomic)CLLocation *getOldLocation;
@property(assign)int speedRadarCount;
@property(assign) BOOL isCompleted;
@property(assign)int avgSpeed;
@property(assign)double averageSpeedCounter;
@property(assign)int totalaverageSpeed;
@property(assign)BOOL isRoute;
@property(assign)CLLocationCoordinate2D lastLocation;
@property(assign)int stoplocationCounter;
@property(assign)int totalStoppedSecond;
@property(assign)CLLocationCoordinate2D mapLastLocation;
@property(assign)BOOL mapTrack;
@property(strong,nonatomic)NSString *trackingLabelStatus;
@property(assign)int totalSpeedCount;
@property(assign)BOOL isResume;
@property(assign)BOOL check;
@property(assign)BOOL fbLogout;
@property(assign)BOOL isloginwithFb;
@property(strong,nonatomic)NSString *strForTryUsNow;
@property (strong, nonatomic) NSMutableArray *pointArray;
+ (AppResourceObject *)sharedAppResource;
@end
