//
//  MapScreen.h
//  SpeedoMeter
//
//  Created by lemosys on 15/01/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKMapView.h>

@interface MapScreen : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>


@property (assign) double FriendsLat;
@property (assign) double FriendsLang;

@property (strong,nonatomic) NSString *FriendsLocationName;
@property (strong,nonatomic) NSString *locationName;
@property (strong,nonatomic) NSString *friendLocation;

@property (nonatomic,retain) CLLocationManager *locationManager;
@property (assign,nonatomic) MKCoordinateRegion currentRegion;

@property (strong, nonatomic) IBOutlet UIButton *speedoBtn;
@property (strong, nonatomic) IBOutlet UIButton *mapBtn;
@property (strong, nonatomic) IBOutlet UIButton *hudBtn;
@property (strong, nonatomic) IBOutlet UIButton *innermapBtn;
@property (strong, nonatomic) IBOutlet UIButton *hybridBtn;
@property (strong, nonatomic) IBOutlet UIButton *sateliteBtn;
@property (strong, nonatomic) IBOutlet UIButton *map3dBtn;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)speedoAction:(id)sender;
- (IBAction)mapAction:(id)sender;
- (IBAction)hudAction:(id)sender;
- (IBAction)innerMapAction:(id)sender;
- (IBAction)hybridAction:(id)sender;
- (IBAction)seteliteAction:(id)sender;
- (IBAction)map3dBtnAction:(id)sender;
- (IBAction)menuAction:(id)sender;
- (IBAction)lemosysAction:(id)sender;

@end
