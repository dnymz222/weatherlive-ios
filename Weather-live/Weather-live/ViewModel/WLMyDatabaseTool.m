//
//  WLMyDatabaseTool.m
//  Weather-live
//
//  Created by xueping on 2019/8/27.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLMyDatabaseTool.h"
#import "STLocationModel.h"
#import "FMDB.h"

static FMDatabase *__db;

@implementation WLMyDatabaseTool


+ (void)initialize {
    
    
    NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"favorate.db"];
    __db = [[FMDatabase alloc] initWithPath:dbPath];
    if ([__db open]) {
        
        BOOL   result =   [__db executeUpdate:@"CREATE TABLE IF NOT EXISTS LocationFavorites (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,name TEXT,lat REAL,lon REAL,locationkey TEXT,favorite INTEGER)"];
        
        
    } else {
        
        
    }
    
    [__db setShouldCacheStatements:YES];
    
    
    
}


+ (void)addlocation:(STLocationModel *)location {
    
    [__db executeUpdate:@"INSERT INTO LocationFavorites (name,lat,lon,locationkey,favorite)VALUES(?,?,?,?,?)",location.name,@(location.location.coordinate.latitude),@(location.location.coordinate.longitude),location.locationkey?:@"",@(1)];
    
    
    
    
    
}


+ (void)removeLocation:(STLocationModel *)location {
    
    [__db executeUpdate:@"DELETE FROM LocationFavorites WHERE name = ?",location.name];
    
    
    
}


+ (NSArray *)excuteLocationArray {
    
    NSMutableArray *array = [NSMutableArray array];
    
    FMResultSet *set = [__db executeQuery:@"SELECT * FROM LocationFavorites WHERE favorite = '1' "];
    
    while ([set next]) {
        STLocationModel *model= [[STLocationModel alloc] init ];
        model.name  = [set stringForColumn:@"name"];
      
        double lat = [set doubleForColumn:@"lat"];
        double lon = [set doubleForColumn:@"lon"];
      
        CLLocation *location = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
        model.location = location;
        
        model.locationkey  = [set stringForColumn:@"locationkey"];
       
 
        [array addObject:model];
    }
    [set close];
    
    return array.copy;
    
}



@end
