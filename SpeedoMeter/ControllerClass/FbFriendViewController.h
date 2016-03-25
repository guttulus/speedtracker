//
//  FbFriendViewController.h
//
//  Created by Test on 12/06/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FbFriendTableViewCell.h"
#import "MBProgressHUD.h"
@interface FbFriendViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,FbFriendTableViewCellDelegate,UISearchBarDelegate,UISearchDisplayDelegate,MBProgressHUDDelegate,UITextFieldDelegate>

@property (strong, nonatomic) NSString *strForSpeedTrackerMember;
@property (strong, nonatomic) NSMutableArray *postData;

@property (strong, nonatomic) UIButton *btnforBAck;

@property (strong, nonatomic) IBOutlet UIImageView *black_image;
@property (strong, nonatomic) IBOutlet UIImageView *bg_img;
@property (strong, nonatomic) IBOutlet UITableView *tbl_view;
@property (strong, nonatomic) IBOutlet UIButton *btn_ForselectAll;
@property (strong, nonatomic) IBOutlet UIButton *btn_forInviteFriends;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)selectAllAction:(UIButton *)sender;
- (IBAction)invitefriendAction:(id)sender;
- (IBAction)headerAction:(id)sender;
- (IBAction)menuAction:(id)sender;

@end
