//
//  CoreLocationController.m
//  CoreLocationDemo
//
//  Created by Nicholas Vellios on 8/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CoreLocationController.h"
#import "AppResourceObject.h"
#import "DriverOffline.h"

#define kRequiredAccuracy 500.0 //meters
#define kMaxAge 10.0 //seconds
#define M_PI   3.14159265358979323846264338327950288   /* pi */


@implementation CoreLocationController

@synthesize locMgr;
@synthesize  delegate;

@synthesize geocoder;
@synthesize placemark;
@synthesize currentlocName;
@synthesize heightMesurement;
@synthesize distanceString;
@synthesize distanceMoved;

@synthesize currentDistance;

@synthesize oldHour;
@synthesize oldMinute;
@synthesize oldSecond;
@synthesize newHour;
@synthesize newMinute;
@synthesize newSecond;

@synthesize dblLat1;
@synthesize dblLat2;
@synthesize dblLon1;
@synthesize dblLon2;
@synthesize fltLon;
@synthesize fltLat;

//@synthesize oldLatlong;
//@synthesize newLatlong;


@synthesize timer;
@synthesize trackingTravelTime;

- (id)init
{
	self = [super init];
	if(self != nil)
    {
		self.locMgr = [[CLLocationManager alloc] init];
        if ([self.locMgr respondsToSelector:
             @selector(requestWhenInUseAuthorization)])
        {
            [self.locMgr requestWhenInUseAuthorization];
        }
        
        [self.locMgr startUpdatingLocation];
        
		self.locMgr.delegate = self;
        self.geocoder = [[CLGeocoder alloc] init];
	}
	return self;
}

- (NSString *)getAddressFromLatLon:(double)pdblLatitude withLongitude:(double)pdblLongitude
{
    NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%f,%f&output=csv",pdblLatitude, pdblLongitude];
    NSError* error;
    NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSASCIIStringEncoding error:&error];
    locationString = [locationString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    return [locationString substringFromIndex:6];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //Make the Array of All Lat and Lng
 
//    oldLatlong.latitude = oldLocation.coordinate.latitude;
//    oldLatlong.longitude = oldLocation.coordinate.longitude;
//    newLatlong.latitude = newLocation.coordinate.latitude;
//    newLatlong.longitude = newLocation.coordinate.longitude;

    AppResourceObject *appResourceObject = [AppResourceObject sharedAppResource];
    
    NSMutableArray *latlongStatus = [[[DriverOffline alloc] init] getLatlongStatus];

    if (latlongStatus.count>0)
    {
        if ([[latlongStatus objectAtIndex:0] latlongstatus]==0)
        {
            NSString *oldLongtitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
            NSString *oldLatitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];

            [[NSUserDefaults standardUserDefaults] setObject:oldLongtitude forKey:@"startLongtitude"];
            [[NSUserDefaults standardUserDefaults] setObject:oldLatitude forKey:@"startLatitude"];
            [[NSUserDefaults standardUserDefaults] setObject:oldLongtitude forKey:@"newlatitude"];
            [[NSUserDefaults standardUserDefaults] setObject:oldLatitude forKey:@"newlongtitude"];

            DriverOffline *driverOffline = [[DriverOffline alloc] init];
            NSMutableArray *data = [driverOffline getCurrentLocation];
            
            if (data.count>0)
            {
                NSString *currentLocation = [[data objectAtIndex:1] currentAddress];

                if ([currentLocation rangeOfString:@","].location != NSNotFound)
                {
                    int i = (int)[currentLocation rangeOfString:@","].location;
                    currentLocation = [currentLocation substringToIndex:i];
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:currentLocation forKey:@"startLocation"];
            }
            else
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"--" forKey:@"startLocation"];
            }
            
            [[[DriverOffline alloc] init] updatelatlongStatus:1];
        }
    }

    NSString *totalSpeed = [[[DriverOffline alloc] init] getTotalSpeedLatlong];

    if ([totalSpeed integerValue]==0)
    {
        NSString *oldLongtitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
        NSString *oldLatitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];

        [[NSUserDefaults standardUserDefaults] setObject:oldLongtitude forKey:@"startededLongtitude"];
        [[NSUserDefaults standardUserDefaults] setObject:oldLatitude forKey:@"startedLatitude"];
        
        [[[DriverOffline alloc] init] updateTotalSpeedLatlong:1];
    }

    if (oldLocation.coordinate.latitude == newLocation.coordinate.latitude)
    {
        if (oldLocation.coordinate.longitude == newLocation.coordinate.longitude)
        {
            ++appResourceObject.stoplocationCounter ;
        }
    }
    else
    {
        appResourceObject.stoplocationCounter = 0;
    }
    
    if (appResourceObject.isGetOldLocation)
    {
        appResourceObject.getOldLocation = newLocation;
        appResourceObject.isGetOldLocation= FALSE;
    }
    
    fltDistanceTravelled += [self getDistanceInKm:newLocation fromLocation:appResourceObject.getOldLocation];
    
    NSString *distance;
    
    if(fltDistanceTravelled>0.0&&fltDistanceTravelled<10)
    {
        distance = [NSString stringWithFormat:@"00%.01f",fltDistanceTravelled];
    }
    else if(fltDistanceTravelled>=10&&fltDistanceTravelled<100)
    {
        distance = [NSString stringWithFormat:@"0%.01f",fltDistanceTravelled];
    }
    else if(fltDistanceTravelled>=100)
    {
        distance = [NSString stringWithFormat:@"%.01f",fltDistanceTravelled];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:distance forKey:@"distanceLocation"];
    
   //call CoreLocationControllerDelegate method

    if([self.delegate conformsToProtocol:@protocol(CoreLocationControllerDelegate)])
    {
		[self.delegate locationUpdate:newLocation];
	}

    //get altitude in km.
    self.heightMesurement = [NSString stringWithFormat: @"%.1f",newLocation.altitude];
    
    if (newLocation.altitude>=0)
    {
        [[NSUserDefaults standardUserDefaults] setObject:self.heightMesurement forKey:@"currentHeight"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"currentHeight"];
    }
    
    //get distance in km.
            
    CLLocationDistance threshold = 4.0;  // threshold distance in meters

    // note: userLocation and otherLocation are CLLocation objects
    
    if ([newLocation distanceFromLocation:oldLocation] <= threshold)
    {
        NSString *oldLongtitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
        NSString *oldLatitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
               
        [[NSUserDefaults standardUserDefaults] setObject:oldLongtitude forKey:@"oldLongtitude"];
        [[NSUserDefaults standardUserDefaults] setObject:oldLatitude forKey:@"oldLatitude"];
        [[NSUserDefaults standardUserDefaults] setObject:oldLongtitude forKey:@"newLongtitude"];
        [[NSUserDefaults standardUserDefaults] setObject:oldLatitude forKey:@"newLatitude"];

        newHour = 0;
        newMinute = 0;
        newSecond = 0;
        NSString *time;
        NSString *headerTime;
        
        if (newHour<1)
        {
            time = [NSString stringWithFormat:@"%dm%ds",newMinute,newSecond];
                  headerTime = [NSString stringWithFormat:@"%02d:%02ds",newMinute,newSecond];
        }
        else
        {
            time = [NSString stringWithFormat:@"%dh%dm%ds",newHour,newMinute,newSecond];
                  headerTime = [NSString stringWithFormat:@"%02d:%02d:%02ds",newHour,newMinute,newSecond];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:headerTime forKey:@"headerTravelTime"];
    }
    else
    {
        NSString *newLongtitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
        NSString *newLatitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
              
        [[NSUserDefaults standardUserDefaults] setObject:newLongtitude forKey:@"newLongtitude"];
        [[NSUserDefaults standardUserDefaults] setObject:newLatitude forKey:@"newLatitude"];

        CLLocationDegrees CLLatitude = (CLLocationDegrees)[[[NSUserDefaults standardUserDefaults] objectForKey:@"oldLatitude"]doubleValue];
               
        CLLocationDegrees CLLongtitude = (CLLocationDegrees)[[[NSUserDefaults standardUserDefaults] objectForKey:@"oldLongtitude"]doubleValue];

        CLLocation *LocationAtual=[[CLLocation alloc] initWithLatitude:CLLatitude longitude:CLLongtitude];
        
        CLLocationDistance distance = [newLocation distanceFromLocation:LocationAtual];  //distance is expressed in meters
        
        CLLocationDistance kilometers = distance / 1000.0;
        
        // or you can also use this..
        //CLLocationDistance meters = distance;
        // NSString *distanceString = [[NSString alloc] initWithFormat: @"%f", kilometers];

        self.distanceString = [NSString stringWithFormat:@"%f",kilometers];

        float totaldistancecovered = [self.distanceString floatValue];

        
        //Now,you can use this float value for addition...
        // distanceMoved  should be float type variable which is declare in .h file...

        if (totaldistancecovered<0)
        {
        }
        else
        {
            distanceMoved = distanceMoved + totaldistancecovered ;
            self.currentDistance = [NSString stringWithFormat: @"%.01f", distanceMoved];
            
            //[[NSUserDefaults standardUserDefaults] setObject:self.currentDistance forKey:@"distanceLocation"];
        }
        
        //get time in hour minut second.
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"HH:mm:ss"];
        [formatter setTimeZone:[NSTimeZone systemTimeZone]];
        //[formatter dateFromString:str];
        NSString *newtimeString = [formatter stringFromDate:newLocation.timestamp];
        NSString *oldtimeString = [formatter stringFromDate:LocationAtual.timestamp];

        NSArray *newhoursMins = [newtimeString componentsSeparatedByString:@":"];

        NSArray *oldhoursMins = [oldtimeString componentsSeparatedByString:@":"];
        
        oldHour =[oldhoursMins [0] intValue];
        oldMinute = [oldhoursMins [1]intValue];
        oldSecond = [oldhoursMins [2] intValue];

        newHour = [newhoursMins [0] intValue];
        newMinute = [newhoursMins [1]intValue];
        newSecond = [newhoursMins [2] intValue];

        newHour = newHour - oldHour;
        newMinute = newMinute - oldMinute;
        newSecond = newSecond - oldSecond;
        
        if (newHour<0||newMinute<0||newSecond<0)
        {
        }
        else if (newHour<1)
        {
            NSString *time = [NSString stringWithFormat:@"%dm%ds",newMinute,newSecond];
            [[NSUserDefaults standardUserDefaults] setObject:time forKey:@"travelTime"];
            
            NSString *headerTime =  [NSString stringWithFormat:@"%02d:%02ds",newMinute,newSecond];
            
            [[NSUserDefaults standardUserDefaults] setObject:headerTime forKey:@"headerTravelTime"];
        }
        else
        {

            //  NSString *time = [NSString stringWithFormat:@"%dh%dm%ds",newHour,newMinute,newSecond];
            //[[NSUserDefaults standardUserDefaults] setObject:time forKey:@"travelTime"];

            NSString *headerTime =  [NSString stringWithFormat:@"%02d:%02d:%02ds",newHour,newMinute,newSecond];
            [[NSUserDefaults standardUserDefaults] setObject:headerTime forKey:@"headerTravelTime"];
        }
    }
}

-(float)getDistanceInKm:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    float lat1,lon1,lat2,lon2;

    lat1 = newLocation.coordinate.latitude  * M_PI / 180;
    lon1 = newLocation.coordinate.longitude * M_PI / 180;

    lat2 = oldLocation.coordinate.latitude  * M_PI / 180;
    lon2 = oldLocation.coordinate.longitude * M_PI / 180;

    float R = 6371; // km
    float dLat = lat2-lat1;
    float dLon = lon2-lon1;

    float a = sin(dLat/2) * sin(dLat/2) + cos(lat1) * cos(lat2) * sin(dLon/2) * sin(dLon/2);
    float c = 2 * atan2(sqrt(a), sqrt(1-a));
    float d = R * c;
    
    return d;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	if([self.delegate conformsToProtocol:@protocol(CoreLocationControllerDelegate)])
    {
		[self.delegate locationError:error];
	}
}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    float mHeading = newHeading.magneticHeading;
 
    if ((mHeading >= 339) || (mHeading <= 22))
    {
        //[direction setText:@"N"];
        [[NSUserDefaults standardUserDefaults] setObject:@"N" forKey:@"direction"];
    }
    else if ((mHeading > 23) && (mHeading <= 68))
    {
        //[direction setText:@"NE"];
        [[NSUserDefaults standardUserDefaults] setObject:@"NE" forKey:@"direction"];
    }
    else if ((mHeading > 69) && (mHeading <= 113))
    {
        // [direction setText:@"E"];
        [[NSUserDefaults standardUserDefaults] setObject:@"E" forKey:@"direction"];
    }
    else if ((mHeading > 114) && (mHeading <= 158))
    {
        //[direction setText:@"SE"];
        [[NSUserDefaults standardUserDefaults] setObject:@"SE" forKey:@"direction"];
    }
    else if ((mHeading > 159) && (mHeading <= 203))
    {
        //[direction setText:@"S"];
        [[NSUserDefaults standardUserDefaults] setObject:@"S" forKey:@"direction"];
    }
    else if ((mHeading > 204) && (mHeading <= 248))
    {
        //[direction setText:@"SW"];
        [[NSUserDefaults standardUserDefaults] setObject:@"SW" forKey:@"direction"];
    }
    else if ((mHeading > 249) && (mHeading <= 293))
    {
        //[course setText:@"W"];
         [[NSUserDefaults standardUserDefaults] setObject:@"W" forKey:@"direction"];
    }
    else if ((mHeading > 294) && (mHeading <= 338))
    {
        // [direction setText:@"NW"];
        [[NSUserDefaults standardUserDefaults] setObject:@"NW" forKey:@"direction"];
    }

    float oldRad =  -manager.heading.trueHeading * M_PI / 180.0f;
	float newRad =  -newHeading.trueHeading * M_PI / 180.0f;

    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",oldRad] forKey:@"oldradians"];
     [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",newRad] forKey:@"newradians"];
}

-(void)setLatLonForDistanceAndAngle
{

}

-(void)getAdrressFromLatLong : (CGFloat)lat lon:(CGFloat)lon
{
	NSString *urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&amp;sensor=false",lat,lon];

	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];

	NSURLResponse *response = nil;
	NSError *requestError = nil;

    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
	NSString *responseString = [[NSString alloc] initWithData: responseData encoding:NSUTF8StringEncoding];

    NSString *jsonString;
    NSMutableArray *remoteData;

	if ([responseString length]>0)
    {
        jsonString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        remoteData = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        
        if ([remoteData count]>0)
        {
		
        }
        else
        {
			UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@""
															   message: @"Location Unknown."
															  delegate:nil
													 cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
			[alertView show];
		}
	}
}

@end
