//
//  DriverOnline.h
//  Spot Deals
//
//  Created by lemosys on 21/04/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DriverProtocol.h"
#import"AppResourceObject.h"
@interface DriverOnline : NSObject<DriverProtocol>{

    NSString *dbPathString;
    AppResourceObject *appResourceObject;
    
    
}

@property (nonatomic, assign) BOOL speedUpdateStatus;
@end
