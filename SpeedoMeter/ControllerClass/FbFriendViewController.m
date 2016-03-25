//  FbFriendViewController.m
//
//  Created by Test on 12/06/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import "FbFriendViewController.h"
#import "FbFriendTableViewCell.h"
#import "InviteFriends.h"
#import "AsyncImageView.h"
#import "MFSideMenu.h"
#import "MBProgressHUD.h"
#import "MapScreen.h"
@interface FbFriendViewController ()
{
    NSMutableArray *origionData;
    NSMutableArray *copyData;
    AppResourceObject *appResourceObject;
    MBProgressHUD *HUD;
}

@end

@implementation FbFriendViewController

@synthesize tbl_view;
@synthesize btn_forInviteFriends,bg_img,black_image,btn_ForselectAll,postData;
@synthesize searchBar,btnforBAck;
@synthesize strForSpeedTrackerMember;

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
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
    
    HUD.delegate = self;
	HUD.labelText = @" Friend List Loading";
    [HUD show:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    searchBar.text = @"";
    searchBar.showsCancelButton = NO;
    searchBar.backgroundColor=[UIColor clearColor];
    
    for (UIView *subView in searchBar.subviews)
    {
        for(id field in subView.subviews)
        {
            if ([field isKindOfClass:[UITextField class]])
            {
                UITextField *textField = (UITextField *)field;
                [textField setBackgroundColor:[UIColor colorWithRed:30.0/255.0 green:30.0/255.0 blue:31.0/255.0 alpha:1.0]];
            }
        }
    }
  
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:[UIColor whiteColor]];
 
    [self performSelector:@selector(loadTableData) withObject:nil afterDelay:0.5];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadTableData
{
    appResourceObject = [AppResourceObject sharedAppResource];
    
    if (appResourceObject.connectionStatus)
    {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        NSString *fbstr=[[NSUserDefaults standardUserDefaults] objectForKey:@"fbToken"];
        
        if ([fbstr isEqual:[NSNull null]])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please LOgin With Facebook" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
        }
        else
        {
            [dic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"fbToken"] forKey:@"fb_token"];
            [arr addObject:dic];
            
            if ([strForSpeedTrackerMember isEqual:@"YES"])
            {
                origionData = [[[DriverOnline alloc]init] getFacebookFriendsInSpeedTracker:arr];
            }
            else
            {
                origionData = [[[DriverOnline alloc]init] getFacebookFriends:arr];
            }
            
            copyData = [origionData mutableCopy];
            
            self.postData = [[NSMutableArray alloc] init];
            [HUD hide:YES];
            [self.tbl_view reloadData];
        }
    }
    else
    {
        [self alertAction:@"Please connect internet!!!"];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark:UItableView Delegete Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return copyData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*Create custom cell object*/
    NSString *cellIdentifier = @"Cell";
    
    FbFriendTableViewCell *cell;
    cell = [[FbFriendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier detail:[copyData objectAtIndex:indexPath.row] withIndex:(int)indexPath.row];
    
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([[copyData objectAtIndex:indexPath.row] isCheckd]==TRUE)
    {
        [cell.btnFor_checkBox setSelected:YES];
    }
    
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)checkBoxPressed:(UIButton *)sender
{

    for (int i =0;i <copyData.count;++i)
    {
        if (sender.tag==i)
        {
            if (sender.isSelected)
            {
                [sender setSelected:NO];
                
                if (self.postData.count>0)
                {
                    for (int j =0 ; j < postData.count ; ++j)
                    {
                        if ([[postData objectAtIndex:j]  isEqualToString:[[copyData objectAtIndex:i] fb_id]])
                        {
                            [postData removeObjectAtIndex:j];
                            [[copyData objectAtIndex:i] setIsCheckd:FALSE];
                        }
                    }
                }
            }
            else
            {
                [sender setSelected:YES];
                [postData addObject:[[copyData objectAtIndex:i] fb_id]];
                [[copyData objectAtIndex:i] setIsCheckd:TRUE];
            }
            
            [self.tbl_view reloadData];
        }
    }
}


-(void)checkAction:(UIButton *)sender
{
    for (int i =0;i < copyData.count;++i)
    {
        if (sender.tag==i)
        {
            if (sender.isSelected)
            {
                [sender setSelected:NO];
                
                if (postData.count > 0)
                {
                    for (int j = 0 ; j < postData.count ; ++j )
                    {
                        if ([[postData objectAtIndex:j]  isEqualToString:[[copyData objectAtIndex:i] fb_id]])
                        {
                            [postData removeObjectAtIndex:j];
                        }
                    }
                }
            }
            else
            {
                [sender setSelected:YES];
                [postData addObject:[[copyData objectAtIndex:i] fb_id]];
            }
            [tbl_view reloadData];
        }
    }
}

- (IBAction)selectAllAction:(UIButton *)sender
{
    if (copyData.count > 0)
    {
        if (!sender.isSelected)
        {
            sender.selected = YES;
            [btn_ForselectAll setSelected:YES];
            
            for (int i = 0;i < copyData.count ; ++i)
            {
                [postData addObject:[[copyData objectAtIndex:i] fb_id]];
                [[copyData objectAtIndex:i] setIsCheckd:TRUE];
            }
        }
        else
        {
            sender.selected = NO;
            [btn_ForselectAll setSelected:NO];
            [postData removeAllObjects];
            
            for (int i = 0 ; i < copyData.count ; ++i)
            {
                [[copyData objectAtIndex:i] setIsCheckd:FALSE];
            }
        }
        [tbl_view reloadData];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.searchBar.text = @"";
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchB
{
    //do whatever I want to do here
    
    searchBar.text = @"";
    copyData = [origionData mutableCopy];
    
    for (int i = 0 ; i < postData.count ; ++i)
    {
        for (int j =0 ; j < copyData.count ; ++j)
        {
            
            if ([[postData objectAtIndex:i]isEqualToString:[[copyData objectAtIndex:j]fb_id]])
            {
                [[copyData objectAtIndex:j] setIsCheckd:TRUE];
            }
        }
    }

    [tbl_view reloadData];
    [searchBar resignFirstResponder];
}

#pragma mark - SearchBar Delegate Methods

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterContentForSearchText:[searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchbar
{
    
    if ([[searchbar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        copyData = [origionData mutableCopy];
    }
    
    for (int i = 0 ; i < postData.count ; ++i)
    {
        for (int j =0 ; j < copyData.count ; ++j)
        {
            if ([[postData objectAtIndex:i]isEqualToString:[[copyData objectAtIndex:j]fb_id]])
            {
                [[copyData objectAtIndex:j] setIsCheckd:TRUE];
            }
        }
    }
    
    [tbl_view reloadData];
    
    [searchBar resignFirstResponder];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchbar
{
    [searchBar resignFirstResponder];
    [self.view endEditing:YES];
}


- (void)filterContentForSearchText:(NSString *)searchText
{
    if (searchText && searchText.length)
    {
        appResourceObject = [AppResourceObject sharedAppResource];
        [copyData removeAllObjects];
        
        for (InviteFriends *c in origionData)
        {
            NSRange r = [[c fb_name] rangeOfString:searchText
                                           options:(NSAnchoredSearch | NSCaseInsensitiveSearch)];
            if (r.location != NSNotFound)
            {
                [copyData addObject:c];
            }
        }
    }
    else
    {
        [copyData removeAllObjects];
        copyData = [origionData mutableCopy];
        [searchBar resignFirstResponder];
    }
    
    for (int i = 0 ; i < postData.count ; ++i)
    {
        for (int j = 0 ; j < copyData.count ; ++j)
        {
            if ([[postData objectAtIndex:i]isEqualToString:[[copyData objectAtIndex:j]fb_id]])
            {
                [[copyData objectAtIndex:j] setIsCheckd:TRUE];
            }
        }
    }
    [tbl_view reloadData];
}

- (IBAction)invitefriendAction:(UIButton *)sender
{
    if (postData.count > 0)
    {
        appResourceObject = [AppResourceObject sharedAppResource];
        
        if (appResourceObject.connectionStatus)
        {
            FBLinkShareParams *p=[[FBLinkShareParams alloc] init];
            p.friends = self.postData;
            p.linkDescription = @"SpeedTracker IPhone App Provide facility to create trip record like speed,distance,time.";
            p.name = @"SpeedTracker IPhone App";
            p.caption = @"SpeedTracker IPhone App";
            p.picture = [NSURL URLWithString:@"Icon-60@2x.png"];
            
            //check if the FB app is installed and can use this method
            if ([FBDialogs canPresentShareDialogWithParams:p])
            {
                [FBDialogs presentShareDialogWithParams:p
                                            clientState:nil
                                                handler:^(FBAppCall *call,
                                                          NSDictionary *results,
                                                          NSError *error)
                {
                
                    //do some error checking
                    NSLog(@"if error is %@",error);
                    
                }];
                
                [copyData removeAllObjects];
                copyData = [origionData mutableCopy];
                
                for (int i = 0 ; i < postData.count ; ++i)
                {
                    for (int j = 0 ; j < copyData.count ; ++j)
                    {
                        if ([[postData objectAtIndex:i]isEqualToString:[[copyData objectAtIndex:j]fb_id]])
                        {
                            [[copyData objectAtIndex:j] setIsCheckd:FALSE];
                        }
                    }
                }
                
                [postData removeAllObjects];
                [tbl_view reloadData];
                
            }    // fallback to what is essentially a webview
            else
            {
                if (!appResourceObject.connectionStatus)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Please connect internet!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Install Facebook app on your device" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Select friends for send invitation" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (NSDictionary*)parseURLParams:(NSString *)query
{
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

    for (NSString *pair in pairs)
    {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}

- (void) alertAction:(NSString *)msg
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Oops!" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self loadTableData];
    }
}


-(IBAction)headerAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.tag = btn.tag - 40;
    
    if (btn.tag == 1)
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
    else if (btn.tag == 2)
    {
        [self.view.window.layer removeAllAnimations];
        CATransition *transition = [CATransition animation];
        transition.duration = 0.4;
        transition.timingFunction = [CAMediaTimingFunction
                                     functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:transition forKey:nil];
        MapScreen *mapScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"MapScreen"];
        [mapScreen setHidesBottomBarWhenPushed:YES];
        [self.navigationController setViewControllers:[NSArray arrayWithObject:mapScreen] animated:NO];
    }
    else if (btn.tag == 3)
    {
        [self.view.window.layer removeAllAnimations];
        CATransition *transition = [CATransition animation];
        transition.duration = 0.4;
        transition.timingFunction = [CAMediaTimingFunction
                                     functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:transition forKey:nil];
        HudScreen *hudScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HudScreen"];
        [hudScreen setHidesBottomBarWhenPushed:YES];
        [self.navigationController setViewControllers:[NSArray arrayWithObject:hudScreen] animated:NO];
    }
    else if (btn.tag == 4)
    {
    }
    else if (btn.tag == 5)
    {
    }
}

- (IBAction)menuAction:(id)sender
{
    [self.view.window.layer removeAllAnimations];
    [self.menuContainerViewController toggleRightSideMenuCompletion:nil];
}

@end
