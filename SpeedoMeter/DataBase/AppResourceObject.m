//
//  AppResourceObject.m
//  Tasbihat
//
//  Created by Lemosys on 30/07/13.
//  Copyright (c) 2013 Lemosys. All rights reserved.
//

#import "AppResourceObject.h"

@implementation AppResourceObject

@synthesize connectionStatus;
@synthesize connectionCheck;

@synthesize tripId;
@synthesize maximumSpeedCounter;

@synthesize maximumZoom;
@synthesize minimumZoom;
@synthesize calculateAverageSpeedCount;
@synthesize speedCount;
@synthesize totalSeconds;
@synthesize traveltotalSecond;
@synthesize trackingSignalCount;
@synthesize maximumSpeedCount;
@synthesize calculateMaximumSpeed;
@synthesize isDeleted;

@synthesize trackinButtonVisible;
@synthesize trackingAction;

@synthesize isTrackingStatus;
@synthesize isScreenAnimation;

@synthesize isGetOldLocation;
@synthesize getOldLocation;
@synthesize trackingStatus;
@synthesize isAvgSpeed;
@synthesize allocAvgSpeedArray;

@synthesize avgSpeed;
@synthesize averageSpeedCounter;
@synthesize totalaverageSpeed;

@synthesize istrackingTravelTime;
@synthesize isCompleted;

@synthesize isRoute;

@synthesize lastLocation;
@synthesize stoplocationCounter;

@synthesize totalStoppedSecond;

@synthesize mapLastLocation;
@synthesize trackingLabelStatus;

@synthesize isResume;
@synthesize check;
@synthesize speedRadarCount;
@synthesize totalSpeedCount;
@synthesize fbLogout;
@synthesize isloginwithFb;
@synthesize strForTryUsNow;
@synthesize pointArray;

static AppResourceObject *obj = nil;

+(AppResourceObject *)sharedAppResource{
    
    if (obj == nil) {
        
        obj = [[AppResourceObject alloc] init];
       
    }
    
    return obj;
    
}

-(id)init
{
    if (self)
    {
        pointArray = [[NSMutableArray alloc] init];
        
    }
    return self;
}
@end
