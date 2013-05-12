//
//  DatabaseManager.h
//  sqlTextSix
//
//  Created by 曹 盛杰 on 13-5-11.
//  Copyright (c) 2013年 曹 盛杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;

@interface DatabaseManager : NSObject
{
    FMDatabase *_db;
}

+(DatabaseManager *)sharedInstance;

-(id)queryCityName;
-(id)queryCityName:(NSString *)cityName;

-(void)insertCityName:(NSString *)cityName CityCode:(NSString *)cityCode;
-(void)updateCityName:(NSString *)cityName CityCode:(NSString *)cityCode;

-(void)deleteCutyCode:(NSString *)cityCode;
@end
