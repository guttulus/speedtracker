//
//  DriverOffline.h
//  Dcompras
//
//  Created by Lemosys on 22/12/12.
//  Copyright (c) 2012 Lemosys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppResourceObject.h"
#import "DriverProtocol.h"
#import "sqlite3.h"


@interface DriverOffline : NSObject <DriverProtocol>{
    
    sqlite3 *dataBase;
    NSString *dbPathString;
    
}


@end
