//
//  NotificationCell.m
//  speedtracker
//
//  Created by Test on 27/11/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import "NotificationCell.h"
@implementation NotificationCell
@synthesize lbl_notification;
@synthesize btn_accept;
@synthesize btn_reject;
@synthesize cell_image;

- (void)awakeFromNib {
    self.btn_accept.layer.cornerRadius=5;
    self.btn_accept.layer.borderWidth=1;
    self.btn_accept.layer.borderColor=[[UIColor whiteColor] CGColor];
    self.btn_accept.layer.masksToBounds=YES;
    self.btn_reject.layer.cornerRadius=5;
    self.btn_reject.layer.borderWidth=1;
    self.btn_reject.layer.borderColor=[[UIColor whiteColor] CGColor];
    self.btn_reject.layer.masksToBounds=YES;
    self.cell_image.layer.cornerRadius=7;
    self.cell_image.layer.borderWidth=1;
    self.cell_image.layer.borderColor=[[UIColor whiteColor] CGColor];
    self.cell_image.layer.masksToBounds=YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
