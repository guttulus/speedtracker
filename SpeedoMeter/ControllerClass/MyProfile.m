//
//  MyProfile.m
//  SpeedTracker
//
//  Created by Test on 11/12/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import "MyProfile.h"
#import "HudScreen.h"
#import "MapScreen.h"
#import "MFSideMenu.h"
#import "MBProgressHUD.h"
#import "InviteFriends.h"
#import "FriendCell.h"

@interface MyProfile ()

@end

@implementation MyProfile

@synthesize backButton;
@synthesize profileImage;
@synthesize lblForName;

- (void)viewDidLoad
{
    [super viewDidLoad];
    backButton.layer.cornerRadius=5.0;
    backButton.layer.borderWidth=2.0;
    backButton.layer.borderColor=(__bridge CGColorRef)([UIColor whiteColor]);
    
    [profileImage loadImage:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userImage"]]] ;
    
    lblForName.text=[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]] capitalizedString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)lemosysAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.lemosys.com/"]];
}

- (IBAction)speedoAction:(id)sender
{
    HomeScreen *homescreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreen"];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:homescreen] animated:YES];
}

- (IBAction)mapAction:(id)sender
{
    MapScreen *mapScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"MapScreen"];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:mapScreen] animated:YES];
}

- (IBAction)menuAction:(id)sender
{
    [self.menuContainerViewController toggleRightSideMenuCompletion:nil];
}

- (IBAction)hudAction:(id)sender
{
    HudScreen *hudScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HudScreen"];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:hudScreen] animated:YES];
}
- (void)alertAction:(NSString *)msg
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Oops!" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    alertView = nil;
}

- (IBAction)backAction:(id)sender
{
    HomeScreen *homescreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreen"];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:homescreen] animated:YES];
}

@end
