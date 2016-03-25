//
//  TripLogCell.h
//  SpeedoMeter
//
//  Created by lemosys on 15/02/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripLog.h"


@protocol TripLogCellDelegate <NSObject>

- (void) nextPageAction:(UIButton *)button;

@end

@interface TripLogCell : UITableViewCell

@property(assign)id <TripLogCellDelegate> delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withData:(TripLog *)tripData;

@property(nonatomic,assign)int cellId;
@end
