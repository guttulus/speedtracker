//
//  SideMenuViewController.h
//  MFSideMenuDemoStoryboard
//
//  Created by Michael Frederick on 5/7/13.
//  Copyright (c) 2013 Michael Frederick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"
#import "MFSideMenuContainerViewController.h"
@interface SideMenuViewController : UITableViewController<FBLoginViewDelegate,MBProgressHUDDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property(strong,nonatomic)UIButton *fbsignUPButton;
@property(strong,nonatomic) UINavigationController *navigationController;
@property(strong,nonatomic) MFSideMenuContainerViewController *container;
@property(strong,nonatomic) UIViewController *leftSideMenuViewController;
@property(strong,nonatomic)UIViewController *rightSideMenuViewController;
@end
