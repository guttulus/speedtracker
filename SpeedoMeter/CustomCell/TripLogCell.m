//
//  TripLogCell.m
//  SpeedoMeter
//
//  Created by lemosys on 15/02/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import "TripLogCell.h"

@implementation TripLogCell

@synthesize delegate;

@synthesize cellId;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withData:(TripLog *)tripData
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

        //UIView *cellView = [[UIView alloc] initWithFrame:CGRectMake(0,0,278,self.frame.size.height)];

        UIButton *background = [UIButton buttonWithType:UIButtonTypeCustom];

        background.frame = CGRectMake(0,0,278, 60);
        [background setBackgroundImage:[UIImage imageNamed:@"cell_img-568h.png"] forState:UIControlStateNormal];
        [background setBackgroundImage:[UIImage imageNamed:@"cell_img_hover-568h.png"] forState:UIControlStateHighlighted];
        [background setBackgroundImage:[UIImage imageNamed:@"cell_img_hover-568h.png"] forState:UIControlStateHighlighted];
        background.tag = [tripData tripLogId];
        [background addTarget:self.delegate action:@selector(nextPageAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:background];

        UILabel *dateTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,3, 226,18)];
        dateTimeLabel.backgroundColor = [UIColor clearColor];
        dateTimeLabel.textColor = [UIColor whiteColor];
        //dateTimeLabel.font = [UIFont fontWithName:@"Roboto-Condensed" size:7];
        dateTimeLabel.font = [UIFont fontWithName:@"Arial_BoldMT" size:9];
        dateTimeLabel.textAlignment = NSTextAlignmentLeft;
        dateTimeLabel.text = [tripData tripDateTime];

        NSLog(@"datetime label is %@",dateTimeLabel.text);
        dateTimeLabel.numberOfLines = 0;
        [background addSubview:dateTimeLabel];

        UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,23,80,14)];
        distanceLabel.backgroundColor = [UIColor clearColor];
        distanceLabel.textColor = [UIColor whiteColor];
        distanceLabel.font = [UIFont fontWithName:@"Arial_BoldMT" size:1];
        distanceLabel.text = @"Distance";
        distanceLabel.textAlignment = NSTextAlignmentLeft;
        distanceLabel.numberOfLines = 0;
        [self addSubview:distanceLabel];


        UILabel *distanceTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,42,80,12)];
        distanceTextLabel.backgroundColor = [UIColor clearColor];
        distanceTextLabel.textColor = [UIColor blackColor];
        distanceTextLabel.font = [UIFont fontWithName:@"Arial_BoldMT" size:4];
        distanceTextLabel.text = [tripData tripDistance];
        NSLog(@"distance text is %@",distanceTextLabel.text);
        distanceTextLabel.textAlignment = NSTextAlignmentLeft;
        distanceTextLabel.numberOfLines = 0;
        [self addSubview:distanceTextLabel];


        UILabel *elepsedTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(110,23,120,14)];
        elepsedTimeLabel.backgroundColor = [UIColor clearColor];
        elepsedTimeLabel.textColor = [UIColor whiteColor];
        elepsedTimeLabel.font = [UIFont fontWithName:@"Arial_BoldMT" size:1];
        elepsedTimeLabel.text = @"Elepsed Time";
        elepsedTimeLabel.textAlignment = NSTextAlignmentLeft;
        elepsedTimeLabel.numberOfLines = 0;
        [self addSubview:elepsedTimeLabel];


        UILabel *elepsedTimeTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(110,42,120,12)];
        elepsedTimeTextLabel.backgroundColor = [UIColor clearColor];
        elepsedTimeTextLabel.textColor = [UIColor blackColor];
        elepsedTimeTextLabel.font = [UIFont fontWithName:@"Arial_BoldMT" size:4];
        elepsedTimeTextLabel.text = [tripData tripElepsedTime];
        NSLog(@"elapsed time label is %@",elepsedTimeTextLabel.text);
        elepsedTimeTextLabel.textAlignment = NSTextAlignmentLeft;
        elepsedTimeTextLabel.numberOfLines = 0;
        [self addSubview:elepsedTimeTextLabel];

        UIImageView *accessoryTypeImage = [[UIImageView alloc] initWithFrame:CGRectMake(242,20,12,20)];
        accessoryTypeImage.image = [UIImage imageNamed:@"arrow.png"];
        [self addSubview:accessoryTypeImage];

      


        //        UILabel *subtitle= [[UILabel alloc] initWithFrame:CGRectMake(81,32,190, 15)];
        //        subtitle.backgroundColor = [UIColor clearColor];
        //        subtitle.textColor = [UIColor blackColor];
        //        subtitle.font = [UIFont fontWithName:@"Arial" size:11];
        //        subtitle.text = [data subtitleRequestCode];
        //        [cellView addSubview:subtitle];
 
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
