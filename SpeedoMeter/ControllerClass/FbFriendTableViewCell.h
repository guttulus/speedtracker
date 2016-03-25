//
//  FbFriendTableViewCell.h
//
//  Created by Test on 12/06/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "InviteFriends.h"

@protocol FbFriendTableViewCellDelegate <NSObject>

-(IBAction)checkBoxPressed:(UIButton *)sender;

@end

@interface FbFriendTableViewCell : UITableViewCell

@property (strong, nonatomic) AsyncImageView *btnForImage;


@property (strong, nonatomic) UILabel *lblForName;
@property (strong, nonatomic) UIButton *btnFor_checkBox;

@property(assign)id<FbFriendTableViewCellDelegate> delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier detail:(InviteFriends *)invitefriends withIndex:(int)index;

@end
