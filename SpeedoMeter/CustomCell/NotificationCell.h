//
//  NotificationCell.h
//  speedtracker
//
//  Created by Test on 27/11/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_notification;
@property (strong, nonatomic) IBOutlet UIButton *btn_accept;
@property (strong, nonatomic) IBOutlet UIButton *btn_reject;
@property (strong, nonatomic) IBOutlet UIImageView *cell_image;


@end
