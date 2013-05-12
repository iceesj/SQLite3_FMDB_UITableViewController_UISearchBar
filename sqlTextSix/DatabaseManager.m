//
//  DatabaseManager.m
//  sqlTextSix
//
//  Created by 曹 盛杰 on 13-5-11.
//  Copyright (c) 2013年 曹 盛杰. All rights reserved.
//

#import "DatabaseManager.h"
#import "FMDatabase.h"

DatabaseManager *sharedInstance;

@implementation DatabaseManager

-(void)loadDB{
//    NSString *path = [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"csj.sqlite"];
    NSURL *appURL = [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
    NSString *path = [[appURL path] stringByAppendingPathComponent:@"csj.sqlite"];
    _db = [FMDatabase databaseWithPath:path];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path] == NO){
        if ([_db open]){
            BOOL rs = [_db executeUpdate:@"create table if not exists csj (CityName text, CityCode text)"];
            if (!rs){
                debugLog(@"建表不成功");
            }else{
                debugLog(@"建表成功");
            }
        }
        [_db close];
    }else{
        debugLog(@"表已存在");
    }
    if (![_db open]){
        debugLog(@"不能打开DB");
        return;
    }

}

-(id)init{
    if ([super init]){
        [self loadDB];
    }
    return self;
}


+(DatabaseManager *)sharedInstance{
    if (sharedInstance == nil){
        sharedInstance = [[DatabaseManager alloc]init];
    }
    return sharedInstance;
}

-(id)queryCityName{
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:0];
    
    FMResultSet *rs = [_db executeQuery:@"select CityName, CityCode from csj order by CityCode"];
    while ([rs next]) {
        NSString *cityName = [rs stringForColumn:@"CityName"];
        NSString *cityCode = [rs stringForColumn:@"CityCode"];
        
//        [items addObject:@{@"CityName":cityName, @"CityCode":cityCode}];
        [items addObject:[NSDictionary dictionaryWithObjectsAndKeys:cityName,@"CityName",cityCode,@"CityCode", nil]];
    }
    [rs close];
    return items;
}

-(id)queryCityName:(NSString *)city_Name{
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:0];
    NSString *query = [NSString stringWithFormat:@"%@",city_Name];
    NSString *queryString = [NSString stringWithFormat:@"select CityName, CityCode from csj where CityName like ? order by CityCode"];
    FMResultSet *rs = [_db executeQuery:queryString,query];
    while ([rs next]) {
        NSString *cityName = [rs stringForColumn:@"CityName"];
        NSString *cityCode = [rs stringForColumn:@"CityCode"];
        
        [items addObject:@{@"CityName":cityName, @"CityCode":cityCode}];
    }
    [rs close];
    return items;
}


-(void)insertCityName:(NSString *)cityName CityCode:(NSString *)cityCode{
    if (![_db executeUpdate:@"insert into csj (CityName, CityCode) values(?, ?)",cityName ,cityCode]){
        debugLog(@"Could not insert data : %@",[_db lastErrorMessage]);
    }
}


-(void)updateCityName:(NSString *)cityName CityCode:(NSString *)cityCode{
    if (![_db executeUpdate:@"update csj set CityName=? WHERE CityCode=?",cityName,cityCode]){
        debugLog(@"Could not update data : %@",[_db lastErrorMessage]);
    }
}

-(void)deleteCutyCode:(NSString *)cityCode{
    if (![_db executeUpdate:@"delete from csj where CityCode=?",cityCode]){
        debugLog(@"Could not delete data : %@",[_db lastErrorMessage]);
    }
}

@end
