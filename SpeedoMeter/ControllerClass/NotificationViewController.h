//
//  NotificationViewController.h
//  speedtracker
//
//  Created by Test on 27/11/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface NotificationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>

- (IBAction)menuAction:(id)sender;
- (IBAction)speedoAction:(id)sender;
- (IBAction)hudAction:(id)sender;
- (IBAction)mapAction:(id)sender;
- (IBAction)lemosysAction:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tblView;

@end
