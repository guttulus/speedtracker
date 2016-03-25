//
//  SpeedTrackerMemberViewController.h
//  speedtracker
//
//  Created by Test on 26/11/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface InviteFriendViewController : UIViewController<UITextFieldDelegate,MBProgressHUDDelegate>

@property (strong, nonatomic) IBOutlet UITextField *txtFieldForEmail;
@property (strong, nonatomic) IBOutlet UIButton *speedoBtn;
@property (strong, nonatomic) IBOutlet UIButton *hudBtn;
@property (strong, nonatomic) IBOutlet UIButton *mapBtn;

- (IBAction)menuButtonAction:(id)sender;
- (IBAction)speedButtonAction:(id)sender;
- (IBAction)hudButonAction:(id)sender;
- (IBAction)mapButtonAction:(id)sender;
- (IBAction)lemosysButtonAction:(id)sender;
- (IBAction)sendButtonAction:(id)sender;

@end
