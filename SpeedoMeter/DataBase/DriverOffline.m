//
//  DriverOffline.m
//  Dcompras
//
//  Created by Lemosys on 22/12/12.
//  Copyright (c) 2012 Lemosys. All rights reserved.
//

#import "DriverOffline.h"
#import "Trip.h"
#import "Setting.h"
#import "TripLog.h"
#import "AppResourceObject.h"
#import "SetLatlong.h"
#import "GetLatLong.h"
#define TRIP_TABLE                                @"trip_table"
#define SETTING_TABLE                          @"setting_table"
#define SPEED_TABLE                              @"speed_table"
#define LATLONGTABLE                            @"tbl_latlong"
#define LATLONGSTATUS                          @"tbl_latlongstatus"
#define USER_TABLE                              @"user_tbl"
#define GETLATLONG                             @"tbl_getlatlong"
#define TOTAL_SPEED                             @"tbl_totalspeed"
#define FACEBOOK_TABLE                           @"fb_tbl"

@implementation DriverOffline

/**
 Method Name : init
 Params: None
 Descriprtion : This method establish connection of dataBase.
 Return : none
 */

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
        dbPathString = [documentsDirectory
                                    stringByAppendingPathComponent:@"speedometer.sqlite"];
        
    }
    
    return self;
    
}


//-  (BOOL)updateUserDetail{
//    return TRUE;
//}

/**
 Method Name : setTripDetail().
 Params: None
 Descriprtion : This method insert trip record in trip table.
 Return : Boolean Value.
 */

- (BOOL) setTripDetail{

    char *error;
    sqlite3_stmt *statement;
    NSString *unitName;
    NSMutableArray *setting_detail;

//    yyyyy.MMMM.dd GGG hh:mm aaa
//
//    01996.July.10 AD 12:08 PM


    setting_detail = [self getSetting];


    if ([[[setting_detail objectAtIndex:0] unitName]isEqualToString:@"km"]) {

        unitName = @"km/h";
    }else if ([[[setting_detail objectAtIndex:0] unitName]isEqualToString:@"mph"]) {

        unitName = @"mp/h";

    }else if ([[[setting_detail objectAtIndex:0] unitName]isEqualToString:@"knot"]) {

        unitName = @"knots";
    }



    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    [format setDateFormat:@"MMM dd,yyyy, hh:mm:ss aaa"];
    NSString *dateStr = [format stringFromDate:date];
   

    //date = [format dateFromString:[format stringFromDate:date]];
    NSLog(@"My date is = %@",dateStr);

    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK){

    NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO %@ (id, oldLatitude,oldLongtitude,newLatitude,newLongtitude,distance,travel_time,max_speed,avg_speed,location,altitude,currentSpeed,elepsedTime,stoppedTime,created_date,status,unit) values (NULL,\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",TRIP_TABLE,@"0.0",@"0.0",@"0.0",@"0.0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",dateStr,@"Start",unitName];
        if(sqlite3_exec(dataBase, [insertStmt UTF8String], NULL, NULL, &error)== SQLITE_OK ){

            NSLog(@"Trip detail inserted");
        }


        NSString *insertStmt1 = [NSString stringWithFormat:@"SELECT LAST_INSERT_ROWID()"];

        printf("\nQuery for get last trip Id = %s",[insertStmt1 UTF8String]);

        if(sqlite3_prepare(dataBase, [insertStmt1 UTF8String], -1, &statement, NULL)==SQLITE_OK){

            while(sqlite3_step(statement)==SQLITE_ROW){

                
               int recordId = sqlite3_column_int(statement, 0);

                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",recordId] forKey:@"lastrowId"];
                NSLog(@"get last record insert id %d",recordId);
            }
        }

      }
      sqlite3_close(dataBase);
      return TRUE;
}

/**
 Method Name : getTripDetail().
 Params: none.
 Descriprtion : This method select trip record from trip table.
 Return : NSMutableArray.
 */
- (NSMutableArray *)getTripDetail:(int)tripId{

    sqlite3_stmt *statement;
    NSMutableArray *trip_detail = [[NSMutableArray alloc] init];
    Trip *trip;

    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK)
    {

        NSString *query = [NSString stringWithFormat:@"SELECT id, oldLatitude,oldLongtitude,newLatitude,newLongtitude,distance,travel_time,max_speed,avg_speed,location,altitude,currentSpeed,elepsedTime,stoppedTime,created_date,status,unit FROM %@ where id = %d",TRIP_TABLE,tripId ];

        if(sqlite3_prepare(dataBase, [query UTF8String] , -1, &statement, NULL)==SQLITE_OK)
        {

            while(sqlite3_step(statement)==SQLITE_ROW)
            {

                trip = [[Trip alloc] init];

                trip.tripId = sqlite3_column_int(statement,0);
                trip.oldLatitude = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,1)];
                trip.oldLongtitude = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,2)];
                trip.nLtitude = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,3)];
                trip.nLongtitude = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,4)];
                trip.distance = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,5)];
                trip.travelTime = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,6)];
                trip.maxSpeed = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,7)] ;
                trip.averageSpeed = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,8)];
                trip.currentLocation = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,9)];
                 trip.currentHeight = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,10)];
                 trip.currentSpeed = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,11)];
                 trip.elepsedTime = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,12)];
                 trip.stoppedTime = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,13)];
                trip.createdDate = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,14)];
                trip.status = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,15)];
                trip.unitName = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,16)];
                [trip_detail addObject:trip];
            }
        }
    }
      sqlite3_close(dataBase);
      return trip_detail;
}

/**
 Method Name : updateTripDetail().
 Params: object of Trip class.
 Descriprtion : This method update trip record to trip table.
 Return : Boolean Value.
 */

- (BOOL)updateTripDetail:(Trip *)trip{

    char *error;

    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    [format setDateFormat:@"MMM dd,yyyy, hh:mm:ss aaa"];
    NSString *dateStr = [format stringFromDate:date];
        
    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK){

        NSString *updateStmt = [NSString stringWithFormat:@"update %@ set oldLatitude = \"%@\",oldLongtitude = \"%@\",newLatitude = \"%@\",newLongtitude = \"%@\", distance = \"%@\" , travel_time = \"%@\" , max_speed = \"%@\" , avg_speed = \"%@\" , location = \"%@\",altitude = \"%@\",currentSpeed = \"%@\",elepsedTime = \"%@\",stoppedTime = \"%@\",created_date = \"%@\",status = \"%@\",unit = \"%@\" where id = %d ", TRIP_TABLE,trip.oldLatitude,trip.oldLongtitude,trip.nLtitude,trip.nLongtitude,trip.distance,trip.travelTime,trip.maxSpeed,trip.averageSpeed,trip.currentLocation,trip.currentHeight,trip.currentSpeed,trip.elepsedTime,trip.stoppedTime,dateStr,trip.status,trip.unitName,trip.tripId];

           sqlite3_exec(dataBase, [updateStmt UTF8String], NULL, NULL, &error) ;
    }
    sqlite3_close(dataBase);
    return TRUE;
    
}
/**
 Method Name : deleteTripDetail().
 Params: none.
 Descriprtion : This method delete trip record according to trip id.
 Return : Boolean Value.
 */
- (BOOL) deleteTripDetail:(int)tripId{
    
    char *error = NULL;
       if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK){
        
         NSString *query = [NSString stringWithFormat:@"delete FROM %@ where id = %d",TRIP_TABLE,tripId];
          
          if(sqlite3_exec(dataBase, [query UTF8String],NULL, NULL, &error)){
              NSLog(@"delete trip record");
          }
       }
    sqlite3_close(dataBase);
    return TRUE;
}

/**
 Method Name : getAllTripDetail().
 Params: none.
 Descriprtion : This method getAll Trip Record & add NsMutableArray.
 Return : NsMutableArray object;
 */
- (NSMutableArray *)getAllTripDetail{

    sqlite3_stmt *statement;
    NSMutableArray *tripLogDetail = [[NSMutableArray alloc] init];
    TripLog *tripLog;

    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK)
    {

        NSString *query = [NSString stringWithFormat:@"SELECT id, distance,elepsedTime,created_date,travel_time,stoppedTime,avg_speed,max_speed,unit FROM %@",TRIP_TABLE ];
        NSLog(@"query is %@",query);
        if(sqlite3_prepare(dataBase, [query UTF8String] , -1, &statement, NULL)==SQLITE_OK)
        {

            while(sqlite3_step(statement)==SQLITE_ROW)
            {

                tripLog = [[TripLog alloc] init];

                tripLog.tripLogId = sqlite3_column_int(statement,0);
                tripLog.tripDistance = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,1)];
                if ([[NSString stringWithFormat:@"%s",sqlite3_column_text(statement,2)]isEqualToString:@"(null)"]) {

                     tripLog.tripElepsedTime = @"00m00sec";
                }else{
                      tripLog.tripElepsedTime =  [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,2)];
                }


                tripLog.tripDateTime =  [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,3)];
                tripLog.triptravelTime = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,4)];
                tripLog.tripstoppedTime = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,5)];
                tripLog.tripavgSpeed = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,6)];
                tripLog.tripmaxSpeed = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,7)];
                tripLog.unit_Name = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,8)];
                [tripLogDetail addObject:tripLog];

                NSLog(@"trip travel time is %@",tripLog.triptravelTime);

            }
        }
    }
    sqlite3_close(dataBase);
    return tripLogDetail;
}



/**
 Method Name : getTotalSpeed().
 Params: none.
 Descriprtion : This method calculate totalSpeed.
 Return : totalSpeed value.
 */
- (NSString *)getTotalSpeed{

    sqlite3_stmt *statement;
    NSString *totalSpeed;
   
    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK)
    {
        NSString *query = [NSString stringWithFormat:@"SELECT totalSpeed FROM %@ where id = %d",SPEED_TABLE,1];
        NSLog(@"query is %@",query);
        if(sqlite3_prepare(dataBase, [query UTF8String] , -1, &statement, NULL)==SQLITE_OK)
        {
            while(sqlite3_step(statement)==SQLITE_ROW)
            {
                totalSpeed = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 0)];
                NSLog(@"total speed %@",totalSpeed);
            }
        }
    }
    sqlite3_close(dataBase);
    return totalSpeed;
}

/**
 Method Name : updateSpeedDetail().
 Params: NSString object.
 Descriprtion : This method update totalSpeed.
 Return : boolean value.
 */
- (BOOL)updateSpeedDetail:(NSString *)speed{

    char *error;

    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK){

        NSString *updateStmt = [NSString stringWithFormat:@"update %@ set totalSpeed = \"%@\" where id = %d ", SPEED_TABLE,speed,1];

        sqlite3_exec(dataBase, [updateStmt UTF8String], NULL, NULL, &error) ;
    }
    sqlite3_close(dataBase);
    return TRUE;
}

/**
 Method Name : getSetting().
 Params: none.
 Descriprtion : This method get setting from settingTable.
 Return : NSMutableArray of setting detail.
 */
- (NSMutableArray *)getSetting{

    sqlite3_stmt *statement;
    NSMutableArray *settingDetail = [[NSMutableArray alloc] init];
    Setting *setting;

    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK)
    {

        NSString *query = [NSString stringWithFormat:@"SELECT id,units,avg_speed,max_avg_speed_arrow,is_speed_radar FROM %@",SETTING_TABLE ];
        NSLog(@"query is %@",query);
        if(sqlite3_prepare(dataBase, [query UTF8String] , -1, &statement, NULL)==SQLITE_OK)
        {

            while(sqlite3_step(statement)==SQLITE_ROW)
            {
                setting = [[Setting alloc] init];
                
                setting.unitName = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 1)];
                setting.averageSpeed = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 2)];
                setting.maximumAverageSpeedArrow = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 3)];
                setting.speedRadarStatus = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 4)];

                NSLog(@"staus%@",setting.speedRadarStatus);
                NSLog(@"unit is %@",setting.unitName);
                [settingDetail addObject:setting];
                
            }
        }
    }
    sqlite3_close(dataBase);
    return settingDetail;
}

- (NSMutableArray *)getLatlongStatus{

    sqlite3_stmt *statement;
    NSMutableArray *settingDetail = [[NSMutableArray alloc] init];
    Setting *setting;

    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK)
    {

        NSString *query = [NSString stringWithFormat:@"SELECT id,latlongstatus FROM %@",LATLONGSTATUS ];
        NSLog(@"query is %@",query);
        if(sqlite3_prepare(dataBase, [query UTF8String] , -1, &statement, NULL)==SQLITE_OK)
        {

            while(sqlite3_step(statement)==SQLITE_ROW)
            {
                setting = [[Setting alloc] init];

                setting.latlongstatus = sqlite3_column_int(statement,1);
                NSLog(@"latlong status %d",setting.latlongstatus);
                [settingDetail addObject:setting];

            }
        }
    }
    sqlite3_close(dataBase);
    return settingDetail;
}

- (BOOL)updatelatlongStatus:(int)status{

    char *error;

    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK){

        NSString *updateStmt = [NSString stringWithFormat:@"update %@ set latlongstatus = %d", LATLONGSTATUS,status];

        sqlite3_exec(dataBase, [updateStmt UTF8String], NULL, NULL, &error) ;
    }
    sqlite3_close(dataBase);
    return TRUE;
}

- (NSString *)getTotalSpeedLatlong{

    sqlite3_stmt *statement;
    NSString *totalSpeed;

    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK)
    {

        NSString *query = [NSString stringWithFormat:@"SELECT id,latlongstatus FROM %@",TOTAL_SPEED ];
        NSLog(@"query is %@",query);
        if(sqlite3_prepare(dataBase, [query UTF8String] , -1, &statement, NULL)==SQLITE_OK)
        {

            while(sqlite3_step(statement)==SQLITE_ROW)
            {
                totalSpeed = [NSString stringWithFormat:@"%d",sqlite3_column_int(statement,1)];
            }
        }
    }
    sqlite3_close(dataBase);
    return totalSpeed;
}

- (BOOL)updateTotalSpeedLatlong:(int)status{

    char *error;

    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK){

        NSString *updateStmt = [NSString stringWithFormat:@"update %@ set latlongstatus = %d", LATLONGSTATUS,status];

        sqlite3_exec(dataBase, [updateStmt UTF8String], NULL, NULL, &error) ;
    }
    sqlite3_close(dataBase);
    return TRUE;

}

/**
 Method Name : updateSetting().
 Params: setting object.
 Descriprtion : This method update Setting.
 Return : boolean value.
 */
- (BOOL)updateSetting:(Setting *)setting{

    char *error;

    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK){

        NSString *updateStmt = [NSString stringWithFormat:@"update %@ set \"%@\" = \"%@\" ", SETTING_TABLE,setting.fieldName,setting.valueis];

        sqlite3_exec(dataBase, [updateStmt UTF8String], NULL, NULL, &error) ;
    }
    sqlite3_close(dataBase);
    return TRUE;
}


/**
 Method Name : getCurrentLocation
 Params: none
 Descriprtion : This method return User current location.
 Return : NSMutableArray.
 */

- (NSMutableArray *)getCurrentLocation{

   NSMutableArray *remoteData;


    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"newlatitude"] length]>0&& [[[NSUserDefaults standardUserDefaults] objectForKey:@"newlongtitude"] length]>0) {

        NSString *strURL = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=false",[[[NSUserDefaults standardUserDefaults] objectForKey:@"newlatitude"] doubleValue],[[[NSUserDefaults standardUserDefaults] objectForKey:@"newlongtitude"] doubleValue]];

        NSMutableURLRequest *request;
        NSData *response;
        NSError *error;

        AppResourceObject *app = [AppResourceObject sharedAppResource];

        if (app.connectionStatus) {

            request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: strURL]];
            [request setHTTPMethod: @"GET"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
            
                response = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
            
            if (!error) {
                if (response!=nil) {
             remoteData = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
                }
            }
            
            
        }


        if (remoteData.count > 0) {

            NSArray *extracted = [remoteData valueForKey:@"results"];

            NSMutableArray *data = [[ NSMutableArray alloc] init];

            Trip *trip;

            for (NSDictionary *dict in extracted) {

                trip = [[Trip alloc] init];

                trip.currentAddress = [dict objectForKey:@"formatted_address"];
                NSLog(@"current address is %@",trip.currentAddress);
                [data addObject:trip];
            }
            
            return data;
        }
    }

    return remoteData;
}
///////////////////////////////////////////////////////////////////////
- (BOOL)setLatlong:(NSMutableArray *)record{
    
    char *error;
    
    
    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK){
        
        
        for (int i = 0;i<record.count;++i) {
            
            NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO %@ (id,latitude,longtitude,location) values (NULL,\"%@\",\"%@\",\"%@\")",LATLONGTABLE,[[record objectAtIndex:i]latitude],[[record objectAtIndex:i]longtitude],[[record objectAtIndex:i]location_name]];
            NSLog(@"query is %s",[insertStmt UTF8String]);

            if(sqlite3_exec(dataBase, [insertStmt UTF8String], NULL, NULL, &error)== SQLITE_OK ){
                
                NSLog(@"latlong inserted");
            }
        }
        //        NSString *insertStmt1 = [NSString stringWithFormat:@"SELECT LAST_INSERT_ROWID()"];
        //
        //        printf("\nQuery for get last trip Id = %s",[insertStmt1 UTF8String]);
        //        if(sqlite3_prepare(dataBase, [insertStmt UTF8String], -1, &statement, NULL)==SQLITE_OK){
        //
        //            while(sqlite3_step(statement)==SQLITE_ROW){
        //
        //
        //                int recordId = sqlite3_column_int(statement, 0);
        //
        //                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",recordId] forKey:@"lastrowId"];
        //                NSLog(@"get last record insert id %d",recordId);
        //            }
        //        }
        
    }
    sqlite3_close(dataBase);
    return TRUE;
}

- (NSMutableArray *)getLatlong:(double)latitude withLongtitude:(double)longtitude{
    
    sqlite3_stmt *statement;
    NSMutableArray *latlong_detail =[[NSMutableArray alloc] init];

    double latDist = 1000.0 / 111111.0 *3.0;
    double lonDist = 1000.0 / ABS(111111.0*cos(latitude)) *3.0;

    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK)
    {
        NSString *query = [NSString stringWithFormat:@"SELECT latitude,longtitude,location FROM %@ WHERE latitude BETWEEN %f AND %f AND longtitude BETWEEN %f AND %f",LATLONGTABLE,latitude-latDist,latitude+latDist,longtitude-lonDist,longtitude+lonDist];
        NSLog(@"query is %s",[query UTF8String]);

        if(sqlite3_prepare(dataBase, [query UTF8String] , -1, &statement, NULL)==SQLITE_OK)
        {
            SetLatlong *setLatlong;

            while(sqlite3_step(statement)==SQLITE_ROW)
            {

                setLatlong = [[SetLatlong alloc] init];

                setLatlong.latitude = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,0)];
                setLatlong.longtitude = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,1)];
                setLatlong.location_name = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,2)];

                [latlong_detail addObject:setLatlong];
            }
        }
    }
    sqlite3_close(dataBase);
    return latlong_detail;
}

- (BOOL)setLatlong:(NSString *)latitude withLongtitude:(NSString *)longtitude withlocation:(NSString *)location
{
    NSString *strURl = @"http://codingserver.com/spotdeals.com/organization/webservice/stores/StoreLatLong";
    
    NSMutableString *postVariables = [[NSMutableString alloc] init];
    [postVariables appendFormat:@"&lat=%@",latitude];
    [postVariables appendFormat:@"&lng=%@",longtitude];
    [postVariables appendFormat:@"&position=%@",location];
    
    NSMutableString *str = [[NSMutableString alloc] init];
    [str appendString:strURl];
    [str appendString:postVariables];
    NSData *postData = [NSData dataWithBytes:[postVariables UTF8String] length:[postVariables length]];
    
    NSMutableURLRequest *request;
    NSData *response;
    NSMutableArray *remoteData;
    
    
    request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strURl]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody:postData];
    NSError *error;
    response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    NSLog(@"responce%@",response);
    if (response!=nil) {
        NSString *string=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
        NSLog(@"rremote data is %@",string);
        NSLog(@"error data is %@",error);
    }
  
    remoteData = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
    NSLog(@"rremote data is %@",remoteData);
    NSLog(@"error data is %@",error);
    
    
    NSLog(@"rremote data is %@",remoteData);
    
    if (remoteData.count>0) {
        
        [[NSUserDefaults standardUserDefaults] setObject:[remoteData valueForKey:@"message"] forKey:@"message"];
        
        
        
        return YES;
        
        
    }
    return NO;
    
    
    
}


/////////// /* login deatail database*///////////////
- (BOOL)SetUser_Detail:(AddUser *)signUP{
    
    char *error;

    
    
    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK){
        
        NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO %@ (id,status)values (\"%@\",\"%@\")",USER_TABLE,signUP.user_id,signUP.user_status];
        if(sqlite3_exec(dataBase, [insertStmt UTF8String], NULL, NULL, &error)== SQLITE_OK ){
            
            NSLog(@"user inserted");
        }
        NSLog(@"query is %s",[insertStmt UTF8String]);
       
    
    }
    sqlite3_close(dataBase);
    return TRUE;
}


- (NSMutableArray *)getUserDetail
{
    
    sqlite3_stmt *statement;
    NSMutableArray *user_detail =[[NSMutableArray alloc] init];
    
    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK)
    {
        
        NSString *query = [NSString stringWithFormat:@"SELECT id,status FROM %@",USER_TABLE];
        NSLog(@"query is %s",[query UTF8String]);
        
        if(sqlite3_prepare(dataBase, [query UTF8String] , -1, &statement, NULL)==SQLITE_OK)
        {
           AddUser *signUP;
            
            while(sqlite3_step(statement)==SQLITE_ROW)
            {
                
                signUP = [[AddUser alloc] init];
                
                signUP.user_id = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,0)];
               
                signUP.user_status = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,1)];
                
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",signUP.user_id] forKey:@"user_id"];
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",signUP.user_status] forKey:@"status"];
                NSLog(@"usr id is %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]);
                
                [user_detail addObject:signUP];
            }
        }
    }
    sqlite3_close(dataBase);
    return user_detail;
}

- (BOOL) deleteuserDetail:(int)userId;{

    char *error = NULL;
    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK){

        NSString *query = [NSString stringWithFormat:@"delete FROM %@ where id = %d",USER_TABLE,userId];

        if(sqlite3_exec(dataBase, [query UTF8String],NULL, NULL, &error)){
            NSLog(@"delete user record");
        }
    }
    sqlite3_close(dataBase);
    return TRUE;
}

- (NSMutableArray *)getLatlong:(GetLatLong *)getLatlong {

    sqlite3_stmt *statement;
    NSMutableArray *latlong_detail =[[NSMutableArray alloc] init];

    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK)
    {
        NSString *query = [NSString stringWithFormat:@"SELECT id,latitude,longtitude FROM %@ WHERE latitude = \"%@\" AND longtitude = \"%@\"",GETLATLONG,getLatlong.getLatitude,getLatlong.getLongtitude];
        NSLog(@"query is %s",[query UTF8String]);

        if(sqlite3_prepare(dataBase, [query UTF8String] , -1, &statement, NULL)==SQLITE_OK)
        {
            GetLatLong *getLatLong;

            while(sqlite3_step(statement)==SQLITE_ROW)
            {
                getLatLong = [[GetLatLong alloc] init];
                getLatLong.latlong_id = sqlite3_column_int(statement,0);
                getLatLong.getLatitude = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,1)];
                getLatLong.getLongtitude = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,2)];

                [latlong_detail addObject:getLatLong];
            }
        }
    }
    sqlite3_close(dataBase);
    return latlong_detail;
}

- (BOOL)updatelatlong:(GetLatLong *)getLatlong{

    char *error;

    if (sqlite3_open([dbPathString UTF8String],&dataBase)==SQLITE_OK) {

        NSString *updateStmt = [NSString stringWithFormat:@"update %@ set latitude = \"%@\",longtitude = \"%@\"",GETLATLONG,getLatlong.getLatitude,getLatlong.getLongtitude];
        NSLog(@"update is %s",[updateStmt UTF8String]);

        sqlite3_exec(dataBase,[updateStmt UTF8String],NULL,NULL,&error);
    }
    sqlite3_close(dataBase);
    return TRUE;

}

- (BOOL)updatelatlong:(NSString *)latitude withLongtitude:(NSString *)longtitude{

    char *error;

    if (sqlite3_open([dbPathString UTF8String],&dataBase)==SQLITE_OK) {

        NSString *updateStmt = [NSString stringWithFormat:@"update %@ set set latitude = \"%@\",longtitude = \"%@\" where latitude = \"%@\" AND  longtitude = \"%@\"",GETLATLONG,@"0.0",@"0.0",latitude,longtitude];
        NSLog(@"update is %s",[updateStmt UTF8String]);

        sqlite3_exec(dataBase,[updateStmt UTF8String],NULL,NULL,&error);
    }
    sqlite3_close(dataBase);
    return TRUE;


}


- (BOOL)updateUserDetail{
    
    char *error;
    
    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK){
        
        NSString *updateStmt = [NSString stringWithFormat:@"update %@ set status = 0,id =0", USER_TABLE];
        
        NSLog(@"update is %s",[updateStmt UTF8String]);
        sqlite3_exec(dataBase, [updateStmt UTF8String], NULL, NULL, &error) ;
        
    }
    sqlite3_close(dataBase);
    return TRUE;
}

- (BOOL)setFacebookStatus{
    
    char *error;
  //  sqlite3_stmt *statement;
    
    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK){
        
        NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO %@ (id,fb_status,user_id) values (Null,1,%ld)",FACEBOOK_TABLE,(long)[[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] integerValue]];
        NSLog(@"insert query is %s",[insertStmt UTF8String]);
        if(sqlite3_exec(dataBase, [insertStmt UTF8String], NULL, NULL, &error)== SQLITE_OK ){
            
            NSLog(@"user inserted");
        }
        NSLog(@"query is %s",[insertStmt UTF8String]);
        //        NSString *insertStmt1 = [NSString stringWithFormat:@"SELECT LAST_INSERT_ROWID()"];
        //
        //        printf("\nQuery for get last trip Id = %s",[insertStmt1 UTF8String]);
        //        if(sqlite3_prepare(dataBase, [insertStmt UTF8String], -1, &statement, NULL)==SQLITE_OK){
        //
        //            while(sqlite3_step(statement)==SQLITE_ROW){
        //
        //
        //                int recordId = sqlite3_column_int(statement, 0);
        //
        //                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",recordId] forKey:@"lastrowId"];
        //                NSLog(@"get last record insert id %d",recordId);
        //            }
        //        }
        
    }
    sqlite3_close(dataBase);
    return TRUE;
}

- (NSMutableArray *)getFacebookStatus{
    
    sqlite3_stmt *statement;
    NSMutableArray *user_detail =[[NSMutableArray alloc] init];
    
    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK)
    {
        
        NSString *query = [NSString stringWithFormat:@"SELECT id,fb_status FROM %@ where fb_status = 1",FACEBOOK_TABLE];
        NSLog(@"query is %s",[query UTF8String]);
        
        if(sqlite3_prepare(dataBase, [query UTF8String] , -1, &statement, NULL)==SQLITE_OK)
        {
            FacebookStatus *facebookStatus;
            
            while(sqlite3_step(statement)==SQLITE_ROW)
            {
                
                facebookStatus = [[FacebookStatus alloc] init];
                
                facebookStatus.facebook_id = sqlite3_column_int(statement,0);
                facebookStatus.facebook_status = sqlite3_column_int(statement,1);
                [user_detail addObject:facebookStatus];
                
            }
        }
    }
    sqlite3_close(dataBase);
    return user_detail;
}

- (BOOL)updateFaceBookStatus{
    
    char *error;
    
    if(sqlite3_open([dbPathString UTF8String], &dataBase)==SQLITE_OK){
        
        NSString *updateStmt = [NSString stringWithFormat:@"update %@ set fb_status = 0", FACEBOOK_TABLE];
        
        NSLog(@"update is %s",[updateStmt UTF8String]);
        sqlite3_exec(dataBase, [updateStmt UTF8String], NULL, NULL, &error) ;
        
    }
    sqlite3_close(dataBase);
    return TRUE;
    
    
}

@end
