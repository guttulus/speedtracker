//
//  CoreLocationController.h
//  CoreLocationDemo
//
//  Created by Nicholas Vellios on 8/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MobileCoreServices/UTCoreTypes.h>


@protocol CoreLocationControllerDelegate

@required

- (void)locationUpdate:(CLLocation *)location;
- (void)locationError:(NSError *)error;

@end


@interface CoreLocationController : NSObject <CLLocationManagerDelegate,UINavigationControllerDelegate>
{
    CLLocationManager *locMgr;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;

    NSTimer *timer;
    float fltDistanceTravelled;
    
}

@property (nonatomic, retain) CLLocationManager *locMgr;
@property (nonatomic, assign) id  delegate;

@property(nonatomic,retain)CLGeocoder *geocoder;
@property(nonatomic,retain)CLPlacemark *placemark;
@property(strong,nonatomic)NSString *currentlocName;
@property(strong,nonatomic)NSString *heightMesurement;
@property(strong,nonatomic)NSString *distanceString;
@property(assign)float distanceMoved;
@property(strong,nonatomic)NSString *currentDistance;


@property (assign)int oldHour;
@property(assign)int oldMinute;
@property(assign)int oldSecond;
@property(assign)int newHour;
@property(assign)int newMinute;
@property(assign)int newSecond;

//@property(assign)CLLocationCoordinate2D oldLatlong;
//@property(assign)CLLocationCoordinate2D newLatlong;



@property(assign)double dblLat1;
@property(assign)double dblLon1;
@property(assign)double dblLat2;
@property(assign)double dblLon2;
@property(assign)double fltLat;
@property(assign)double fltLon;

@property (nonatomic,retain) NSTimer *timer;
@property (strong,nonatomic)NSTimer *trackingTravelTime;

-(float)getDistanceInKm:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;

@end
