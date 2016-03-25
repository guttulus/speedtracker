//
//  NotificationViewController.m
//  speedtracker
//
//  Created by Test on 27/11/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import "NotificationViewController.h"
#import "MFSideMenu.h"
#import "MapScreen.h"
#import "NotificationCell.h"
#import "MBProgressHUD.h"
#import "NotificationMessege.h"

@interface NotificationViewController ()
{
    NSMutableArray *notificationArray;
    MBProgressHUD *HUD;
    AppResourceObject *appResourceObject;
}

@end

@implementation NotificationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = @"Loading...";
    [HUD show:YES];
    
    [self getAllUserNotification];
    
    self.tblView.delegate=self;
    self.tblView.dataSource=self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)getAllUserNotification
{
    appResourceObject=[AppResourceObject sharedAppResource];
    
    if (appResourceObject.connectionStatus)
    {
        notificationArray=[[[DriverOnline alloc] init] getAllnotification];
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"notificationStatus"]intValue]==1)
        {
            [HUD hide:YES];
            [_tblView reloadData];
        }
        else
        {
            [self alertAction:@"No messege Available"];
            [HUD hide:YES];
        }
    }
    else
    {
        [self alertAction:@"Please connect internet!!!"];
    }
}


- (IBAction)menuAction:(id)sender
{
    [self.menuContainerViewController toggleRightSideMenuCompletion:nil];
}

- (IBAction)speedoAction:(id)sender
{
    HomeScreen *homeScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreen"];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:homeScreen] animated:YES];
}

- (IBAction)hudAction:(id)sender
{
    HudScreen *hudScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HudScreen"];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:hudScreen] animated:YES];
}

- (IBAction)mapAction:(id)sender
{
    MapScreen *mapScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"MapScreen"];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:mapScreen] animated:YES];
}

- (IBAction)lemosysAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.lemosys.com/"]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return notificationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NotificationCell";
    
    NotificationCell *cell = (NotificationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NotificationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    cell.btn_accept.tag=indexPath.row;
    cell.btn_reject.tag=indexPath.row;
    cell.lbl_notification.text = [[notificationArray objectAtIndex:indexPath.row]notificationMesseges];
    [cell.btn_accept addTarget:self action:@selector(AccepptBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.btn_reject addTarget:self action:@selector(RejectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(void)AccepptBtnAction:(UIButton*)sender
{
    appResourceObject=[AppResourceObject sharedAppResource];
    NSString *str=@"accepted";
    
    if (appResourceObject.connectionStatus)
    {
        [[[DriverOnline alloc] init] notificationStatus:str withNotificationId:[[notificationArray objectAtIndex:sender.tag]reciverId]];
    }
    else
    {
        [self alertAction:@"Please connect internet!!!"];
    }
    
    NSIndexPath *indexPath;
    
    for (UIView *parent = [sender superview]; parent != nil; parent = [parent superview])
    {
        if ([parent isKindOfClass: [UITableViewCell class]])
        {
            UITableViewCell *cell = (UITableViewCell *) parent;
            indexPath = [_tblView indexPathForCell: cell];
            
            [notificationArray removeObjectAtIndex:indexPath.row];
            
            [_tblView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
            [_tblView reloadData];
            
            break;
        }
    }
}

-(void)RejectBtnAction:(UIButton*)sender
{
    NSString *str=@"rejected";
    appResourceObject=[AppResourceObject sharedAppResource];
    
    if (appResourceObject.connectionStatus)
    {
       [[[DriverOnline alloc] init] notificationStatus:str withNotificationId:[[notificationArray objectAtIndex:sender.tag]reciverId]];
    }
    else
    {
        [self alertAction:@"Please connect internet!!!"];
    }
    
    NSIndexPath *indexPath;
    for (UIView *parent = [sender superview]; parent != nil; parent = [parent superview])
    {
        if ([parent isKindOfClass: [UITableViewCell class]])
        {
            UITableViewCell *cell = (UITableViewCell *) parent;
            indexPath = [_tblView indexPathForCell: cell];
            
            [notificationArray removeObjectAtIndex:indexPath.row];
            
            [_tblView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
            [_tblView reloadData];
            break;
        }
    }
}

- (void)alertAction:(NSString *)msg
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Oops!" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    alertView = nil;
}

@end
