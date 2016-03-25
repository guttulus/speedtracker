//
//  FriendListViewViewController.m
//  speedtracker
//
//  Created by Test on 28/11/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import "FriendListViewViewController.h"
#import "HudScreen.h"
#import "MapScreen.h"
#import "MFSideMenu.h"
#import "MBProgressHUD.h"
#import "InviteFriends.h"
#import "FriendCell.h"

@interface FriendListViewViewController ()
{
    AppResourceObject *appResourceObject;
    NSMutableArray *getFriendsArray;
    MBProgressHUD *HUD;
}

@end

@implementation FriendListViewViewController

@synthesize friendlistTblView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = @"Loading...";
    [HUD show:YES];
    
    friendlistTblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    appResourceObject=[AppResourceObject sharedAppResource];
    
    if (appResourceObject.connectionStatus)
    {
        getFriendsArray= [[[DriverOnline alloc] init] getAllFriends];
        
        if(getFriendsArray.count)
        {
            friendlistTblView.hidden = NO;
            _lblForMessege.hidden=YES;
            [friendlistTblView reloadData];
        }
        else
        {
            _lblForMessege.hidden=NO;
            friendlistTblView.hidden =YES;
        }
        [HUD hide:YES];
    }
    else
    {
        [self alertAction:@"Please connect internet!!!"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return  getFriendsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FriendCell";
    
    FriendCell *cell =(FriendCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[FriendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        cell.backgroundColor=[UIColor whiteColor];
    }
    
    cell.lblForName.text=[NSString stringWithFormat:@"%@",[[[getFriendsArray objectAtIndex:indexPath.row]register_friendName] capitalizedString]];
    
    if ([[[NSUserDefaults standardUserDefaults ]objectForKey:@"unit"] isEqual:@"KM"])
    {
        cell.lblForSpeed.text=[NSString stringWithFormat:@"%.0f km/h",[[getFriendsArray objectAtIndex:indexPath.row]friendsspeed]*3.6];
    }
    else if ([[[NSUserDefaults standardUserDefaults ]objectForKey:@"unit"] isEqual:@"MPH"])
    {
        cell.lblForSpeed.text=[NSString stringWithFormat:@"%.0f mp/h",[[getFriendsArray objectAtIndex:indexPath.row]friendsspeed]*2.23693629];
    }
    
    [cell.profileImage loadImage:[[getFriendsArray objectAtIndex:indexPath.row]friends_image]];
    
    NSString *str=[[getFriendsArray objectAtIndex:indexPath.row]friendslocationName];
    [cell.lblForAddress sizeToFit];
    
    if([str isEqualToString: @"(null)"])
    {
        cell.lblForAddress.text=@"Location not found";
    }
    else
    {
       cell.lblForAddress.text=[NSString stringWithFormat:@"%@",[[getFriendsArray objectAtIndex:indexPath.row]friendslocationName]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MapScreen *mapScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"MapScreen"];
    
    mapScreen.friendLocation=@"YES";
    mapScreen.FriendsLat=[[getFriendsArray objectAtIndex:indexPath.row]friendslattitude];
    mapScreen.FriendsLang=[[getFriendsArray objectAtIndex:indexPath.row]friendslongitude];
    mapScreen.FriendsLocationName=[[getFriendsArray objectAtIndex:indexPath.row]friendslocationName];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:mapScreen] animated:YES];
}


-(IBAction)lemosysbtnAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.lemosys.com/"]];
}

- (IBAction)speedoAction:(id)sender
{
    HudScreen *hudScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HudScreen"];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:hudScreen] animated:YES];
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

- (IBAction)profileImage:(id)sender
{
}

@end
