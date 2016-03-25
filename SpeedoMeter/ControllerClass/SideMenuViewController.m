
//
//  SideMenuViewController.m
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import"HomeScreen.h"
#import "MFSideMenuContainerViewController.h"
#import "AppDelegate.h"
#import "FbFriendViewController.h"
#import "LoginViewController.h"
#import "InviteFriendViewController.h"
#import "TripScreen.h"
#import "NotificationViewController.h"
#import "FriendListViewViewController.h"
#import "MapScreen.h"
#import <FacebookSDK/FacebookSDK.h>
#import "MBProgressHUD.h"
#import "MyProfile.h"
@interface SideMenuViewController (){


    NSMutableArray *array;
    NSMutableArray *arrayForMenuimages;
    NSMutableArray *arrayForMenuimageshover;
    NSMutableArray* arrayColor ;
    UILabel *lbl;
    AppResourceObject *appResourceObject;
    MBProgressHUD *HUD;
}

@end


@implementation SideMenuViewController
@synthesize myTableView;
@synthesize fbsignUPButton;
@synthesize container;
@synthesize leftSideMenuViewController;
@synthesize rightSideMenuViewController;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"VIew Did Load");
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @" Friend List Loading";
    
//    CGSize result = [[UIScreen mainScreen] bounds].size;
//    if(result.height == 480)
//    {
//        UIView *viewForHeder=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 330, 54)];
//        viewForHeder.backgroundColor=[UIColor blackColor];
//        UIImageView *imageviewForHeader=[[UIImageView alloc]initWithFrame:CGRectMake(7, 20, 253, 26)];
//        imageviewForHeader.image=[UIImage imageNamed:@"speed_menulogo.png"];
//        
//        [viewForHeder addSubview:imageviewForHeader];
//        [self.view addSubview:viewForHeder];
//        
//    }
//    else
//    {
//        
//        UIView *viewForHeder=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,54)];
//        viewForHeder.backgroundColor=[UIColor blackColor];
//        
//        UIImageView *imageviewForHeader=[[UIImageView alloc]initWithFrame:CGRectMake(7, 20, 253,26)];
//        imageviewForHeader.image=[UIImage imageNamed:@"speed_menulogo.png"];
//        [viewForHeder addSubview:imageviewForHeader];
//        [self.view addSubview:imageviewForHeader];
//        
//    }

}
-(void)viewWillAppear:(BOOL)animated

{   [super viewWillAppear:YES];
    appResourceObject = [AppResourceObject sharedAppResource];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loginwithfborGeust"]==FALSE)
       {
     if ([appResourceObject.strForTryUsNow isEqual:@"YES"]) {
        array = [[NSMutableArray alloc] initWithObjects:@"HOME",@"MAP",@"HUD",@"DIGITAL METER",@"LOGOUT",nil];
        arrayForMenuimages= [[NSMutableArray alloc] initWithObjects:@"menuhome_.png",@"menumap_.png",@"menuhud_.png",@"menumeter_.png",@"menulogout_.png",nil];
            
        arrayForMenuimageshover=[[NSMutableArray alloc] initWithObjects:@"menuhome_over.png",@"menumap_over.png",@"menuhud_over.png",@"menumeter_over.png",@"menulogout_over.png",nil];
        // self.fbsignUPButton = [UIButton buttonWithType:UIButtonTypeCustom];
        // self.fbsignUPButton.frame = CGRectMake(45,275,177,34);

        }
        else
        {
            array = [[NSMutableArray alloc] initWithObjects:@"HOME",@"MY PROFILE",@"MAP",@"HUD",@"DIGITAL METER",@"INVITE FRIENDS",@"FRIEND LIST",@"MESSEGES",@"CHANGE PASSWORD",@"LOGOUT",nil];
        arrayForMenuimages= [[NSMutableArray alloc] initWithObjects:@"menuhome_.png",@"profile.png",@"menumap_.png",@"menuhud_.png",@"menumeter_.png",@"menuinvitefriend_@2x.png",@"menufriendlist_.png",@"menumassage_.png",@"menuchange_.png",@"menulogout_.png",nil];
        
        arrayForMenuimageshover=[[NSMutableArray alloc] initWithObjects:@"menuhome_over.png",@"profile_hover.png",@"menumap_over.png",@"menuhud_over.png",@"menumeter_over.png",@"menuinvitefriend_over@2x.png",@"menufriendlist_.png",@"menumassage_over.png",@"menuchange_over.png",@"menulogout_over.png",nil];
//            if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"connectedTofacebook"]integerValue]) {
//                self.fbsignUPButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                CGSize result = [[UIScreen mainScreen] bounds].size;
//                if(result.height == 480)
//                {
//                    self.fbsignUPButton.frame = CGRectMake(45,435,177,34);
//                }
//                else{
//                    self.fbsignUPButton.frame = CGRectMake(45,450,177,34);
//                    
//                }
//                
//                [self.fbsignUPButton setBackgroundImage:[UIImage imageNamed:@"sign_facebook.png"] forState:UIControlStateNormal];
//                [self.fbsignUPButton setBackgroundImage:[UIImage imageNamed:@"sign_facebook.png"] forState:UIControlStateHighlighted];
//                [self.fbsignUPButton setBackgroundImage:[UIImage imageNamed:@"sign_facebook.png"] forState:UIControlStateSelected];
//                [self.fbsignUPButton addTarget:self action:@selector(faceBookAction) forControlEvents:UIControlEventTouchUpInside];
//                [self.tableView addSubview:self.fbsignUPButton];
//            }
           

        }
          
    }
    else
    {
        array = [[NSMutableArray alloc] initWithObjects:@"HOME",@"MY PROFILE",@"MAP",@"HUD",@"DIGITAL METER",@"INVITE FRIENDS",@"FB FRIEND LIST",@"FRIEND LIST",@"MESSEGES",@"LOGOUT",nil];
        arrayForMenuimages= [[NSMutableArray alloc] initWithObjects:@"menuhome_.png",@"profile.png",@"menumap_.png",@"menuhud_.png",@"menumeter_.png",@"menuinvitefriend_@2x.png",@"menufriendlist_.png",@"menufriendlist_.png",@"menumassage_.png",@"menulogout_.png",nil];
        
        arrayForMenuimageshover=[[NSMutableArray alloc] initWithObjects:@"menuhome_over.png",@"profile_hover.png",@"menumap_over.png",@"menuhud_over.png",@"menumeter_over.png",@"menuinvitefriend_over@2x.png",@"menufriendlist_.png",@"menufriendlist_.png",@"menumassage_over.png",@"menulogout_over.png",nil];
    }
    UIColor* color1 =[UIColor yellowColor];
    UIColor* color2 =[UIColor yellowColor];
    UIColor* color3 =[UIColor yellowColor];
    UIColor* color4 =[UIColor yellowColor];
    UIColor* color5 =[UIColor yellowColor];
    UIColor* color6 =[UIColor yellowColor];
    UIColor* color7 =[UIColor yellowColor];
    arrayColor = [[NSMutableArray alloc] initWithObjects:color1, color2,color3,color4,color5,color6,color7, nil ];
    
    
}


#pragma mark -
#pragma mark - UITableViewDataSource

 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 return [NSString stringWithFormat:@"Section %ld", (long)section];
 }
 
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if(result.height == 480)
    {
        return 54;
    }
    else{
        return 54;
     }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    // custom view for header. will be adjusted to default or specified header height
   
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if(result.height == 480)
    {
        UIView *viewForHeder=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 330, 54)];
        viewForHeder.backgroundColor=[UIColor blackColor];
        UIImageView *imageviewForHeader=[[UIImageView alloc]initWithFrame:CGRectMake(7, 20, 253, 26)];
        imageviewForHeader.image=[UIImage imageNamed:@"speed_menulogo.png"];
        
        [viewForHeder addSubview:imageviewForHeader];
        [myTableView addSubview:viewForHeder];
        return viewForHeder;

    }
    else
    {
        
    UIView *viewForHeder=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,54)];
        viewForHeder.backgroundColor=[UIColor blackColor];

    UIImageView *imageviewForHeader=[[UIImageView alloc]initWithFrame:CGRectMake(7, 20, 253,26)];
    imageviewForHeader.image=[UIImage imageNamed:@"speed_menulogo.png"];
    [viewForHeder addSubview:imageviewForHeader];
    
    return viewForHeder;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
    

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (IsIphone5) {
        tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iphone5side_bar.png"]];
    }
   else
   {
        tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"menuside_bar.png"]];
        
    }
    // Return the number of sections.

    return 1;
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted) {
      lbl.textColor = [UIColor greenColor];
    } else {
      lbl.textColor = [UIColor yellowColor];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loginwithfborGeust"]==FALSE)
    {
           if ([appResourceObject.strForTryUsNow isEqual:@"YES"]) {
               return [array count];
           }
           else{
               return [array count]+1;
           }
    }
    else{
        return [array count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell;// = //[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    NSLog(@"%lu",(unsigned long)array.count);
      NSLog(@"%lu",(unsigned long)indexPath.row);
    
    if (indexPath.row<array.count) {
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(60, 11, 240, 20) ];
        lbl.font=[UIFont fontWithName:@"HelveticaNeue" size:13.0];
        lbl.backgroundColor=[UIColor clearColor];
        // you can get label like
        lbl.text=[array objectAtIndex:indexPath.row];
        lbl.textColor=[UIColor colorWithRed:193/255.0 green:196/255.0 blue:200/255.0 alpha:1.0];
        // lbl.highlightedTextColor=[UIColor yellowColor];
        [cell addSubview:lbl];
         lbl = (UILabel*)[cell viewWithTag:101];
        cell.imageView.image=[UIImage imageNamed:[arrayForMenuimages objectAtIndex:indexPath.row]];
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height-2, 282, 2) ];
        imgView.image=[UIImage imageNamed:@"divider.png"];
        [cell addSubview:imgView];
     
        }
   else if (array.count==indexPath.row) {
        
        NSLog(@"---------%lu",(unsigned long)indexPath.row);
        
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"connectedTofacebook"]integerValue]) {
            self.fbsignUPButton = [UIButton buttonWithType:UIButtonTypeCustom];
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 480)
            {
                self.fbsignUPButton.frame = CGRectMake(45,8,177,34);
            }
            else{
                self.fbsignUPButton.frame = CGRectMake(45,11,177,34);
                
            }
            
            [self.fbsignUPButton setBackgroundImage:[UIImage imageNamed:@"sign_facebook.png"] forState:UIControlStateNormal];
            [self.fbsignUPButton setBackgroundImage:[UIImage imageNamed:@"sign_facebook.png"] forState:UIControlStateHighlighted];
            [self.fbsignUPButton setBackgroundImage:[UIImage imageNamed:@"sign_facebook.png"] forState:UIControlStateSelected];
            [self.fbsignUPButton addTarget:self action:@selector(faceBookAction) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:self.fbsignUPButton];
        }
    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
   //cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_normal.png"]];
        
        // change background color of selected cell
//    UIView *bgColorView = [[UIView alloc] init];
//    bgColorView.frame=CGRectMake(0,2, cell.frame.size.width, cell.frame.size.height-2);
//    bgColorView.bounds = CGRectMake(0,0, 282, 37);
//
//    bgColorView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"hover.png"]];
//    [cell setSelectedBackgroundView:bgColorView];

    
    return cell;
}
    
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

   //cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_normal.png"]];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView reloadData];
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.imageView.image=[UIImage imageNamed:[arrayForMenuimageshover objectAtIndex:indexPath.row]];
    //[cell.lbl setTextColor:[UIColor yellowColor]];
    // lbl.highlightedTextColor=[UIColor yellowColor];
    // you can get label like
    appResourceObject=[AppResourceObject sharedAppResource];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"loginwithfborGeust"]==FALSE) {
         if ([appResourceObject.strForTryUsNow isEqual:@"YES"])
         {
             if (indexPath.row == 0) {
            
//             HomeScreen *HomeScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreen"];
             
              HomeScreen *HomeScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreen"];
                 
             UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
             NSArray *controllers = [NSArray arrayWithObject:HomeScreen];
             navigationController.viewControllers = controllers;
             
             
         }else if (indexPath.row == 1){
             
             MapScreen *mapScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"MapScreen"];
             //mapScreen.viewFrameSize = self.customview.frame.origin.y;
             //[self.navigationController pushViewController:mapScreen animated:YES];
             [self.navigationController setViewControllers:[NSArray arrayWithObject:mapScreen] animated:YES];
             
             
             UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
             NSArray *controllers = [NSArray arrayWithObject:mapScreen];
             navigationController.viewControllers = controllers;
             
         }else if (indexPath.row == 2){
             
             HudScreen *HudScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HudScreen"];
             
             UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
             NSArray *controllers = [NSArray arrayWithObject:HudScreen];
             navigationController.viewControllers = controllers;
             
         }else if (indexPath.row == 3){
             
             TripScreen *tripScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"TripScreen"];
             
             UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
             NSArray *controllers = [NSArray arrayWithObject:tripScreen];
             navigationController.viewControllers = controllers;
             
         }
             
             
         else if (indexPath.row == 4){
             
             int user_id = (int)[[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] integerValue];
             
             [[[DriverOffline alloc] init] deleteuserDetail:user_id];
             [[[DriverOffline alloc] init] updateUserDetail];
             
             NSMutableArray *facebook_detail = [[[DriverOffline alloc] init] getFacebookStatus];
             
             if (facebook_detail.count==0) {
                 [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"user_id"];
             }
             
             [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"user_id"];
             [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"status"];
             [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"fbid"];
             [self.view.window.layer removeAllAnimations];
//             FBSession* session = [FBSession activeSession];
//             [session closeAndClearTokenInformation];
//             [session close];
//             [FBSession setActiveSession:nil];
//             
//             NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//             NSArray* facebookCookies = [cookies cookiesForURL:[NSURL URLWithString:@"https://facebook.com/"]];
//             
//             for (NSHTTPCookie* cookie in facebookCookies) {
//                 [cookies deleteCookie:cookie];
//             }
           appResourceObject = [AppResourceObject sharedAppResource];
             appResourceObject.fbLogout = TRUE;
             LoginViewController *logout = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
             UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
             NSArray *controllers = [NSArray arrayWithObject:logout];
             navigationController.viewControllers = controllers;
             
         }
        }
        
        
      
         else{
             
             
        if (indexPath.row == 0) {
            
            HomeScreen *HomeScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreen"];
            
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:HomeScreen];
            navigationController.viewControllers = controllers;
            
            
        }if (indexPath.row == 1) {
            
            MyProfile *myprofile = [self.storyboard instantiateViewControllerWithIdentifier:@"MyProfile"];
            
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:myprofile];
            navigationController.viewControllers = controllers;
            
            
        }else if (indexPath.row == 2){
            
            MapScreen *mapScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"MapScreen"];
            //mapScreen.viewFrameSize = self.customview.frame.origin.y;
            //[self.navigationController pushViewController:mapScreen animated:YES];
            [self.navigationController setViewControllers:[NSArray arrayWithObject:mapScreen] animated:YES];

            
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:mapScreen];
            navigationController.viewControllers = controllers;
            
        }else if (indexPath.row == 3){
            
            HudScreen *HudScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HudScreen"];
            
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:HudScreen];
            navigationController.viewControllers = controllers;
            
        }
        else if (indexPath.row == 4){
            
            
            TripScreen *tripScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"TripScreen"];
            
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:tripScreen];
            navigationController.viewControllers = controllers;
            
            
        }
        else if (indexPath.row == 5){
            InviteFriendViewController *speedTrackerfriendViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InviteFriendViewController"];
            
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:speedTrackerfriendViewController];
            navigationController.viewControllers = controllers;
        }else if (indexPath.row == 6){
                FriendListViewViewController *friendViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FriendListViewViewController"];
                
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                NSArray *controllers = [NSArray arrayWithObject:friendViewController];
                navigationController.viewControllers = controllers;
                
            
            
        }else if (indexPath.row==7){
            
            NotificationViewController *notificationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationViewController"];
            
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:notificationViewController];
            navigationController.viewControllers = controllers;

               }
        else if (indexPath.row==8){
            
            ForgetPasswordViewController *changePasswordObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgetPasswordViewController"];
            
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:changePasswordObj];
            navigationController.viewControllers = controllers;

        }

        else if (indexPath.row == 9){
            
            int user_id = (int)[[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] integerValue];
            
            [[[DriverOffline alloc] init] deleteuserDetail:user_id];
            [[[DriverOffline alloc] init] updateUserDetail];
            
            NSMutableArray *facebook_detail = [[[DriverOffline alloc] init] getFacebookStatus];
            
            if (facebook_detail.count==0) {
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"user_id"];
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"user_id"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"status"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"fbid"];
            [self.view.window.layer removeAllAnimations];
           // FBSession* session = [FBSession activeSession];
           // [session closeAndClearTokenInformation];
           // [session close];
           // [FBSession setActiveSession:nil];
            
           // NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
          //  NSArray* facebookCookies = [cookies cookiesForURL:[NSURL URLWithString:@"https://facebook.com/"]];
            
           // for (NSHTTPCookie* cookie in facebookCookies) {
             //   [cookies deleteCookie:cookie];
           // }
         appResourceObject = [AppResourceObject sharedAppResource];
            appResourceObject.fbLogout = TRUE;
            LoginViewController *logout = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:logout];
            navigationController.viewControllers = controllers;
            
        }
      }
    }
    
    else
    {
    if (indexPath.row == 0) {
        
        HomeScreen *HomeScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreen"];
        
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:HomeScreen];
        navigationController.viewControllers = controllers;

        
    }if (indexPath.row == 1) {
        
        MyProfile *myprofile = [self.storyboard instantiateViewControllerWithIdentifier:@"MyProfile"];
        
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:myprofile];
        navigationController.viewControllers = controllers;
        
        
    }
    
    
    else if (indexPath.row == 2){
        
        MapScreen *mapScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"MapScreen"];
        //mapScreen.viewFrameSize = self.customview.frame.origin.y;
        //[self.navigationController pushViewController:mapScreen animated:YES];
        [self.navigationController setViewControllers:[NSArray arrayWithObject:mapScreen] animated:YES];

        
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:mapScreen];
        navigationController.viewControllers = controllers;
        
    }else if (indexPath.row == 3){
    
        HudScreen *HudScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HudScreen"];
        
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:HudScreen];
        navigationController.viewControllers = controllers;

        }
            else if (indexPath.row == 4){
         
            TripScreen *tripScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"TripScreen"];
                
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                NSArray *controllers = [NSArray arrayWithObject:tripScreen];
                navigationController.viewControllers = controllers;

           
             
         }else if (indexPath.row == 5){
                
        InviteFriendViewController *speedTrackerfriendViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InviteFriendViewController"];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:speedTrackerfriendViewController];
                navigationController.viewControllers = controllers;
    }else if (indexPath.row==6){
        
        FbFriendViewController *friendController = [self.storyboard instantiateViewControllerWithIdentifier:@"FbFriendViewController"];
        
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:friendController];
        navigationController.viewControllers = controllers;
    }
        
    else if (indexPath.row==7){
        
        FriendListViewViewController *friendsListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FriendListViewViewController"];
        
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:friendsListViewController];
        navigationController.viewControllers = controllers;
    }
    else if (indexPath.row==8){
        
        NotificationViewController *notificationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationViewController"];
        
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:notificationViewController];
        navigationController.viewControllers = controllers;
    }

    
         else if (indexPath.row == 9){
             
           int user_id = (int)[[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] integerValue];
             
             [[[DriverOffline alloc] init] deleteuserDetail:user_id];
             [[[DriverOffline alloc] init] updateUserDetail];
             
             NSMutableArray *facebook_detail = [[[DriverOffline alloc] init] getFacebookStatus];
             
             if (facebook_detail.count==0) {
                 [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"user_id"];
             }
             
             [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"user_id"];
             [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"status"];
              [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"fbid"];
             [self.view.window.layer removeAllAnimations];
            // FBSession* session = [FBSession activeSession];
            // [session closeAndClearTokenInformation];
            // [session close];
            // [FBSession setActiveSession:nil];
             
            // NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
           //  NSArray* facebookCookies = [cookies cookiesForURL:[NSURL URLWithString:@"https://facebook.com/"]];
             
           //  for (NSHTTPCookie* cookie in facebookCookies) {
            //     [cookies deleteCookie:cookie];
            // }
            appResourceObject = [AppResourceObject sharedAppResource];
             appResourceObject.fbLogout = TRUE;
             LoginViewController *logout = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
             NSArray *controllers = [NSArray arrayWithObject:logout];
             navigationController.viewControllers = controllers;
             
             
         }
    }
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];

}
- (void)faceBookAction{
    
    
    appResourceObject = [AppResourceObject sharedAppResource];
    
    if (appResourceObject.connectionStatus) {
        [HUD show:YES];
        [self ConnectFacebook];
 [self.menuContainerViewController toggleRightSideMenuCompletion:nil];
    }
    else{
        [self alertAction:@"Please Connect Internet.."];
    }
    

}
-(void)ConnectFacebook{
    
    [FBSession openActiveSessionWithReadPermissions:@[@"email",@"user_location",@"user_about_me",@"user_friends"]
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                      
                                      switch (state) {
                                          case FBSessionStateOpen:{
                                              
                                              [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *FBuser, NSError *error) {
                                                  if (error) {
                                                      // Handle error
                                                      NSLog(@"error:%@",error);
                                                  }
                                                  
                                                  else {
                                                      
                                                      NSMutableDictionary *dictionary;
                                                      
                                                      NSMutableArray *UserRemoteValues = [[NSMutableArray alloc] init];
                                                      
                                                      dictionary = [[NSMutableDictionary alloc] init];
                                                      NSString *userName = [FBuser name];
                                                      NSString *fbuserImageURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [FBuser objectID]];
                                                      
                                                      if ([[[FBSession activeSession] accessTokenData] accessToken]) {
                                                          NSString *fbtoken = [[[FBSession activeSession] accessTokenData] accessToken];
                                                          [[NSUserDefaults standardUserDefaults] setObject:fbtoken forKey:@"fbToken"];
                                                      }
                                                      [[NSUserDefaults standardUserDefaults] setObject:[FBuser objectForKey:@"id"] forKey:@"fbid"];
                                                      [dictionary setObject:[NSString stringWithFormat:@"%@",userName] forKey:@"FBusername"];
                                                      
                                                      [dictionary setObject:[NSString stringWithFormat:@"%@",[FBuser first_name]] forKey:@"FBfirst_name"];
                                                      
                                                      [dictionary setObject:[NSString stringWithFormat:@"%@",[FBuser objectForKey:@"email"]] forKey:@"FBemail"];
                                                      
                                                      [dictionary setObject:[NSString stringWithFormat:@"%@",[FBuser objectForKey:@"gender"]] forKey:@"FBgender"];
                                                      
                                                      [dictionary setObject:[NSString stringWithFormat:@"%@",[FBuser objectForKey:@"plateform"]] forKey:@"FBaddress"];
                                                      
                                                      [dictionary setObject:[NSString stringWithFormat:@"%@",[FBuser last_name]] forKey:@"FBlast_name"];
                                                      [dictionary setObject:[NSString stringWithFormat:@"%@",fbuserImageURL] forKey:@"FBimage"];
                                                      
                                                      [dictionary setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"fbToken"] forKey:@"FBfb_token"];
                                                      
                                                      [UserRemoteValues addObject:dictionary];
                                                      
                                                      AddUser *signUp = [[AddUser alloc] init];
                                                      
                                                      //signUp.userName = [NSString stringWithFormat:@"%@",[user objectForKey:@"username"]];
                                                      signUp.email_ID = [NSString stringWithFormat:@"%@",[FBuser objectForKey:@"email"]];
                                                      // signUp.genderName = [NSString stringWithFormat:@"%@",[user objectForKey:@"gender"]];
                                                      
                                                      signUp.deviceID = [[NSUserDefaults standardUserDefaults]  objectForKey:@"udid"];
                                                      signUp.facebook_id = [NSString stringWithFormat:@"%@",[FBuser objectForKey:@"id"]];
                                                      
                                                      signUp.facebook_token = [[NSUserDefaults standardUserDefaults]  objectForKey:@"fbToken"];
                                                      NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"devicetoken"]);
                                                      if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"devicetoken"]length]<=0) {
                                                          signUp.deviceToken=@"123";
                                                      }
                                                      else{
                                                          signUp.deviceToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"devicetoken"];
                                                      }
                                                      signUp.usercurrentLat=[[[NSUserDefaults standardUserDefaults] objectForKey:@"newlatitude"]doubleValue];
                                                      signUp.usercurrentLang=[[[NSUserDefaults standardUserDefaults] objectForKey:@"newlongtitude"]doubleValue];
                                                      signUp.usercurrentLocation=[[NSUserDefaults standardUserDefaults] objectForKey:@"currentLocation"];
                                                      signUp.user_id=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
                                                      [[[DriverOnline alloc] init] connectToFacebook:signUp];
                                                      [HUD hide:YES];
                                                      appResourceObject = [AppResourceObject sharedAppResource];
                                                      
                                                      if (appResourceObject.isloginwithFb) {
                                                          appResourceObject.fbLogout=NO;
                                                      }
                                                      else{
                                                          appResourceObject.isloginwithFb=TRUE;
                                                          [[NSUserDefaults standardUserDefaults] setBool:appResourceObject.isloginwithFb forKey:@"loginwithfborGeust"];
                                                          [[NSUserDefaults standardUserDefaults] synchronize];
                                                          UIStoryboard *mainStoryboard = nil;
                                                          CGSize result = [[UIScreen mainScreen] bounds].size;
                                                          
                                                          if(result.height == 480)
                                                          {
                                                              NSLog(@"iphone 4");
                                                              
                                                              mainStoryboard = [UIStoryboard storyboardWithName:@"iPhone4" bundle:[NSBundle mainBundle]];
                                                              
                                                          }
                                                          if(result.height == 568)
                                                          {
                                                              NSLog(@"iphone 5");
                                                              
                                                              mainStoryboard = [UIStoryboard storyboardWithName:@"iPhone5" bundle:[NSBundle mainBundle]];
                                                              
                                                          }
                                                          UIViewController *guestRightSideMenuViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"rightSideMenuViewController"];
                                                          
                                                          [self.menuContainerViewController setRightMenuViewController:guestRightSideMenuViewController];
                                                          if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"registrationStaus"] integerValue]==1) {
                                                              CATransition *transition = [CATransition animation];
                                                              transition.duration = 0.4;
                                                              transition.timingFunction = [CAMediaTimingFunction
                                                                                           functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                                                              transition.type = kCATransitionPush;
                                                              transition.subtype = kCATransitionFromLeft;
                                                              [self.view.window.layer addAnimation:transition forKey:nil];
                                                              HomeScreen *homeScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreen"];
                                                              [homeScreen setHidesBottomBarWhenPushed:YES];
                                                              //[self.navigationController pushViewController:homeScreen animated:NO];
                                                              [self.navigationController setViewControllers:[NSArray arrayWithObject:homeScreen] animated:NO];
                                                     // [self loadWindow];
      
                                                              //                                                        HomeScreen *homeScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreen"];
                                                              //                                                              [self.navigationController pushViewController:homeScreen animated:YES];
                                                              appResourceObject.fbLogout=YES;
                                                              
                                                          }else{
                                                              [self alertAction:@"you enterd wrong email_id or password"];
                                                          }
                                                          
                                                      }
                                                  }                                  }];
                                              
                                              break;
                                          }
                                          case FBSessionStateClosed:{
                                              [FBSession.activeSession closeAndClearTokenInformation];
                                              break;
                                          }
                                          case FBSessionStateClosedLoginFailed:{
                                              [FBSession.activeSession closeAndClearTokenInformation];
                                              break;
                                          }
                                          default:
                                              break;
                                      }
                                      
                                  } ];
    
    
}

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    if (!error && state == FBSessionStateOpen)
    {
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed)
    {
    }
    if (error)
    {
        NSLog(@"Error:%@",error);
        NSString *alertText;
        NSString *alertTitle;
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES)
        {
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
           // [self showAlert:alertText withTitle:alertTitle];
        }
        else
        {
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled)
            {
                alertTitle = @"Alert";
                alertText = @"Login cancelled!!!";
               // [self showAlert:alertText withTitle:alertTitle];
            }
            else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession)
            {
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
               // [self showAlert:alertText withTitle:alertTitle];
            }
            else
            {
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
               // [self showAlert:alertText withTitle:alertTitle];
            }
        }
        [FBSession.activeSession closeAndClearTokenInformation];
    }
}

- (void)alertAction:(NSString *)msg{
    
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Oops!" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    alertView = nil;
    
}


@end