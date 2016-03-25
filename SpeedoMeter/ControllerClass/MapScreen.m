
//
//  MapScreen.m
//  SpeedoMeter
//
//  Created by lemosys on 15/01/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import "MapScreen.h"
#import "DriverOffline.h"
#import "UILabel+FormattedText.h"
#import "HomeScreen.h"
#import "HudScreen.h"
#import "TripScreen.h"
#import "MFSideMenu.h"

#define MERCATOR_RADIUS 85445659.44705395

#define MAX_ZOOM_LEVELS 20
#define MIN_ZOOM_LEVELS 30

@interface MapScreen ()
{
    CLLocation *lastLocation;
    NSMutableArray *setting_detail;
    NSMutableArray *pointsArray;
}
@end

@implementation MapScreen


@synthesize locationManager;
@synthesize speedoBtn;
@synthesize mapBtn;
@synthesize hudBtn;
@synthesize innermapBtn;
@synthesize hybridBtn;
@synthesize sateliteBtn;
@synthesize mapView;
@synthesize locationName;
@synthesize FriendsLocationName;
@synthesize FriendsLat;
@synthesize FriendsLang;
@synthesize currentRegion;
@synthesize friendLocation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    mapView.delegate = self;
    
    if ([friendLocation isEqualToString:@"YES"])
    {
        CLLocationCoordinate2D location;
        location.latitude = FriendsLat;
        location.longitude = FriendsLang;
        
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate =location;
        
        annotationPoint.title = FriendsLocationName;
        
        [mapView addAnnotation:annotationPoint];
    }
    else
    {        
        pointsArray = [[NSMutableArray alloc] init];
        
        locationManager = [[CLLocationManager alloc] init];
        
        if ([locationManager respondsToSelector:
             @selector(requestAlwaysAuthorization)])
        {
            [locationManager performSelector:@selector(requestAlwaysAuthorization)];
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 100 m
        [locationManager startUpdatingLocation];
        locationManager.delegate = self;
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [mapBtn setSelected:YES];
    [innermapBtn setSelected:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark CLLocationManager Delegates

//
//- (void)updateMapData
//{
//    NSNumber *newlatitude = [[NSUserDefaults standardUserDefaults] valueForKey:@"newlatitude"];
//    NSNumber *newlongtitude = [[NSUserDefaults standardUserDefaults] valueForKey:@"newlongtitude"];
//    NSNumber *newSpeed = [[NSUserDefaults standardUserDefaults] valueForKey:@"currentSpeed"];
//    
//    if ([newSpeed intValue] > 0)
//    {
//        [pointsArray addObject:[[CLLocation alloc] initWithLatitude:[newlatitude doubleValue] longitude:[newlongtitude doubleValue]]];
//    }
//    
//    CLGeocoder* geoCoder = [[CLGeocoder alloc] init];
//    
//    [geoCoder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:[newlatitude doubleValue] longitude:[newlongtitude doubleValue]] completionHandler:^(NSArray *placemarks, NSError *error)
//     {
//         
//         CLPlacemark *placemark = [placemarks objectAtIndex:0];
//         locationName = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
//         
//         
//     }];
//    
//    if ([newlatitude doubleValue] != lastLocation.coordinate.latitude ||[newlongtitude doubleValue] != lastLocation.coordinate.longitude)
//    {
//        [mapView removeAnnotations:mapView.annotations];
//        
//        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//        CLLocationCoordinate2D coordinate;
//        coordinate.latitude = [newlatitude doubleValue];
//        coordinate.longitude = [newlongtitude doubleValue];
//        
//        point.title = locationName;
//        [mapView addAnnotation:point];
//        
//        lastLocation = [[CLLocation alloc] initWithLatitude:[newlatitude doubleValue] longitude:[newlongtitude doubleValue]];
//    }
//    
//}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [mapView removeAnnotations:mapView.annotations];
    
    if (newLocation.speed > 0)
    {
        [pointsArray addObject:[[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude]];
    }
    
    CLGeocoder* geoCoder = [[CLGeocoder alloc] init];
    
    [geoCoder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude] completionHandler:^(NSArray *placemarks, NSError *error)
     {
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         locationName = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
     }];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = newLocation.coordinate;
    point.title = locationName;
    [mapView addAnnotation:point];
    
    lastLocation = newLocation;
    
}

- (void)renderPath
{
    NSInteger numberOfPoints = [pointsArray count];
    
    if (numberOfPoints)
    {
        CLLocationCoordinate2D points[numberOfPoints];
        
        for (NSInteger i = 0; i < numberOfPoints; i++)
        {
            CLLocation *loc = pointsArray[i];
            
            points[i] = CLLocationCoordinate2DMake(loc.coordinate.latitude, loc.coordinate.longitude);
        }
        
        [mapView addOverlay:[MKPolyline polylineWithCoordinates:points count:numberOfPoints]];
    }
}

#pragma mark MKMapviewDelegate Methods.

//add image for annotation in map
-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *AnnotationViewID = @"annotationViewID";
    MKAnnotationView *annotationView = (MKAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    if (annotationView == nil)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    
    if([[annotation title] isEqualToString:locationName])
    {
        annotationView.image = [UIImage imageNamed:@"gps_tracker.png"];
    }
    else if ([friendLocation isEqualToString:@"YES"])
    {
        if ([[annotation title] isEqualToString:FriendsLocationName])
        {
            annotationView.image = [UIImage imageNamed:@"gps_tracker.png"];
        }
    }
    
    annotationView.canShowCallout = YES;
    annotationView.annotation = annotation;
    
    return annotationView;
}


- (void)mapView:(MKMapView *)mapView1 didAddAnnotationViews:(NSArray *)views
{
    int i = 0;
    
    MKMapPoint points [[mapView1.annotations count]];
    
    if ([[mapView1 annotations]count]>=2)
    {
        for (id<MKAnnotation> annotation in [mapView1 annotations])
            points[i++] = MKMapPointForCoordinate(annotation.coordinate);
        MKPolygon *poly = [MKPolygon polygonWithPoints:points count:i];
        [mapView1 setRegion:MKCoordinateRegionForMapRect([poly boundingMapRect]) animated:YES];
    }
    else
    {
        if ([friendLocation isEqualToString:@"YES"])
        {
            CLLocationCoordinate2D location;
            location.latitude = FriendsLat;
            location.longitude = FriendsLang;
            MKCoordinateRegion region;
            region.center=location;
            MKCoordinateSpan span;
            span.latitudeDelta=0.10;
            span.longitudeDelta=0.10;
            region.span=span;
             
            [mapView setRegion:region animated:TRUE];
        }
        else
        {
            MKCoordinateRegion region;
            region.center = lastLocation.coordinate;
            region.span = MKCoordinateSpanMake(0.10, 0.10); //Zoom distance
            region = [mapView1 regionThatFits:region];
            [mapView setRegion:region animated:YES];
        }
    }
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(renderPath) userInfo:nil repeats:NO];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    MKOverlayPathView *overlayPathView;
    
    if ([overlay isKindOfClass:[MKPolygon class]])
    {
        overlayPathView = [[MKPolygonView alloc] initWithPolygon:(MKPolygon*)overlay];
        
        overlayPathView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        overlayPathView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        overlayPathView.lineWidth = 1;
        
        return overlayPathView;
    }
    
    else if ([overlay isKindOfClass:[MKPolyline class]])
    {
        overlayPathView = [[MKPolylineView alloc] initWithPolyline:(MKPolyline *)overlay];
        
        overlayPathView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        overlayPathView.lineWidth = 3;
        
        return overlayPathView;
    }
    
    return nil;
}

#pragma mark IBOutlet Actions

- (IBAction)speedoAction:(id)sender
{
    [self.view.window.layer removeAllAnimations];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction
                                 functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:transition forKey:nil];
    HomeScreen *homeScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreen"];
    [homeScreen setHidesBottomBarWhenPushed:YES];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:homeScreen] animated:NO];
    homeScreen = nil;
    
}

- (IBAction)mapAction:(id)sender
{
    
}

- (IBAction)hudAction:(id)sender
{
    HudScreen *hudScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HudScreen"];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:hudScreen] animated:YES];
    hudScreen = nil;

}

- (IBAction)menuAction:(id)sender
{
    [self.menuContainerViewController toggleRightSideMenuCompletion:nil];

}

- (IBAction)lemosysAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.lemosys.com/"]];
}

- (IBAction)innerMapAction:(id)sender
{
    [self.innermapBtn setSelected:YES];
    [self.hybridBtn setSelected:NO];
    [self.sateliteBtn  setSelected:NO];
    [self.map3dBtn  setSelected:NO];

    mapView.mapType = MKMapTypeStandard;
}

- (IBAction)hybridAction:(id)sender
{
    [self.innermapBtn setSelected:NO];
    [self.hybridBtn setSelected:YES];
    [self.sateliteBtn  setSelected:NO];
    [self.map3dBtn  setSelected:NO];

    mapView.mapType = MKMapTypeHybrid;
}

- (IBAction)seteliteAction:(id)sender
{
    [self.innermapBtn setSelected:NO];
    [self.hybridBtn setSelected:NO];
    [self.map3dBtn  setSelected:NO];
    [self.sateliteBtn  setSelected:YES];
    mapView.mapType = MKMapTypeSatellite;
}

- (IBAction)map3dBtnAction:(id)sender;
{
    self.mapView.pitchEnabled = YES;
    self.mapView.showsBuildings = YES;
    self.mapView.showsPointsOfInterest = YES;
    self.mapView.scrollEnabled = YES;
    
    [self.innermapBtn setSelected:NO];
    [self.hybridBtn setSelected:NO];
    [self.sateliteBtn  setSelected:NO];
    [self.map3dBtn  setSelected:YES];

    //set up initial location
    if ([friendLocation isEqualToString:@"YES"])
    {
        CLLocationCoordinate2D location;
        location.latitude = FriendsLat;
        location.longitude = FriendsLang;
        CLLocationCoordinate2D ground = CLLocationCoordinate2DMake(location.latitude,  location.latitude);
        CLLocationCoordinate2D eye = CLLocationCoordinate2DMake( location.latitude,  location.latitude);
        MKMapCamera *mapCamera = [MKMapCamera cameraLookingAtCenterCoordinate:ground fromEyeCoordinate:eye
            eyeAltitude:50];
        mapView.camera = mapCamera;
    }
    else
    {
        mapView.showsUserLocation=YES;
        CLLocationCoordinate2D location;
        location.latitude = mapView.userLocation.coordinate.latitude;
        location.longitude = mapView.userLocation.coordinate.longitude;
        CLLocationCoordinate2D ground = CLLocationCoordinate2DMake( location.latitude,  location.latitude);
        CLLocationCoordinate2D eye = CLLocationCoordinate2DMake( location.latitude,  location.latitude);
        MKMapCamera *mapCamera = [MKMapCamera cameraLookingAtCenterCoordinate:ground fromEyeCoordinate:eye
        eyeAltitude:50];
        mapView.camera = mapCamera;
    }
}

#pragma mark CustomView Delegate Method.

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel animated:(BOOL)animated
{
    MKCoordinateSpan span = MKCoordinateSpanMake(0, 360/pow(2, zoomLevel)*mapView.frame.size.width/256);
    [mapView setRegion:MKCoordinateRegionMake(centerCoordinate, span) animated:animated];
}

-(double) getZoomLevel
{
    return log2(360 * ((mapView.frame.size.width/256) / currentRegion.span.longitudeDelta));
}

@end
