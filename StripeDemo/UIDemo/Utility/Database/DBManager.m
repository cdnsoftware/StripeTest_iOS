////
//  DBManager.m
//
//  UIDemo
//
//  Created by Ambuj Shukla on 11/02/16.
//  Copyright © 2016 CDN. All rights reserved.
//

#import "DBManager.h"
#import <sqlite3.h>
#import "CommonUtils.h"

@implementation DBManager

/*
 * Insert data in to table with TableName,DataBaseName,ColumnNameArray and its Value in Array form.
 */
-(BOOL)saveDatawithTablename:(NSString *)tableName withDatabaseName:(NSString*)databasename withColumnarray:(NSMutableArray*)columnArray withValues:(NSArray *)valueArray
{
    FMDatabase *db = [FMDatabase databaseWithPath:[CommonUtils getDatabasePath]];
    [db open];
    for (int i = 0; i < [valueArray count]; i++) {
        NSMutableString *strQuery=[NSMutableString stringWithFormat:@"insert into %@ (",tableName];
        
        for (int i = 0; i < [columnArray count]; i++) {
            [strQuery appendString:[columnArray objectAtIndex:i]];
            if (i != [columnArray count]-1) {
                [strQuery appendString:@","];
            }else{
                [strQuery appendString:@") values ("];
            }
        }
        for (int j = 0; j < [columnArray count]; j++) {
            if (j != [columnArray count]-1) {
                [strQuery appendString:@"\""];
                if ([[columnArray objectAtIndex:j] isEqualToString:@"name"]) {
                    [strQuery appendString:[CommonUtils checkNullString:[[valueArray objectAtIndex:i] objectForKey:[columnArray objectAtIndex:j]]]];
                }else{
                    if ([[[valueArray objectAtIndex:i] objectForKey:[columnArray objectAtIndex:j]] isKindOfClass:[NSNumber class]]) {
                        [strQuery appendString:[CommonUtils checkNullString:[NSString stringWithFormat:@"%@",[[valueArray objectAtIndex:i] objectForKey:[columnArray objectAtIndex:j]]]]];
                    }else
                        [strQuery appendString:[CommonUtils checkNullString:[[valueArray objectAtIndex:i] objectForKey:[columnArray objectAtIndex:j]]]];
                }
                [strQuery appendString:@"\""];
                
                [strQuery appendString:@","];
            }else{
                [strQuery appendString:@"\""];
                if ([[[valueArray objectAtIndex:i] objectForKey:[columnArray objectAtIndex:j]] isKindOfClass:[NSNumber class]]) {
                    [strQuery appendString:[CommonUtils checkNullString:[NSString stringWithFormat:@"%@",[[valueArray objectAtIndex:i] objectForKey:[columnArray objectAtIndex:j]]]]];
                }else
                    [strQuery appendString:[CommonUtils checkNullString:[[valueArray objectAtIndex:i] objectForKey:[columnArray objectAtIndex:j]]]];
                [strQuery appendString:@"\""];
                [strQuery appendString:@")"];
            }
        }
        BOOL a = [db executeUpdate:strQuery];
        if (a) {
        }
    }
    [db close];
    return YES;
}
/**
 *  This method is for fetchinga all the data from the database.
 *
 *  @param strQuery the query to fire for fetching the data...
 *
 *  @return list of the data in array form...
 */
-(NSMutableArray*)doGetDataFromTable:(NSString*)strQuery
{
    NSMutableArray *arrData=[[NSMutableArray alloc] init];
    FMDatabase *db = [self doOpenDB];
    FMResultSet *results = [db executeQuery:strQuery];
    
    while([results next])
    {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
        for (int i=0; i<[results columnCount]; i++) {
            
            [dict setValue:[results stringForColumn:[results columnNameForIndex:i]] forKey:[results columnNameForIndex:i]];
        }
        [arrData addObject:dict];
    }
    [db close];
    return arrData;
}

/*
 * Delete from table with TableName,DataBaseName, columnNames in which data needs to
 * delete and its corresponding
 * values in array.
 */

-(BOOL)deleteDatawithTablename:(NSString *)tableName withDeleteColumnName:(NSString*)UniqueKey withValue:(NSString *)value
{
    NSMutableString *strQuery;
    
    FMDatabase *db = [self doOpenDB];
    
    if(UniqueKey !=nil)
    {
        strQuery=[NSMutableString stringWithFormat:@"DELETE from %@ where %@ = '%@'",tableName,
                  UniqueKey,value];
    }
    else
        strQuery=[NSMutableString stringWithFormat:@"DELETE from %@ ",tableName];
    
    
    BOOL a = [db executeUpdate:strQuery];
    
    if (a) {
        
    }
    return YES;
}
/**
 *  This method is for fetching the data from database regarding the specific query
 *
 *  @param key       key is dynamic comes from the view
 *  @param value     value is dynamic comes from the view
 *  @param tableName tablename is dynamic comes from the view
 *
 *  @return NSMutable array for the list of the data.
 */

-(NSMutableArray*)doGetData:(NSString*)key WithValue:(NSString*)value WithTableName:(NSString*)tableName
{
    NSString *strQuery;
    
    if (key!=nil) {
        strQuery=[NSString stringWithFormat:@"select * from %@ Where %@ = \"%@\" ",tableName,key,value];
    }
    else
    {
        strQuery=[NSString stringWithFormat:@"select * from %@",tableName];
    }
    NSMutableArray *arrData=[self doGetDataFromTable:strQuery];
    
    return ([arrData count]>0?arrData:nil);
}
/**
 *  This method is for opening the database and load to FMDatabase Object
 *
 *  @return FMDatabase
 */

-(FMDatabase*)doOpenDB
{
    FMDatabase *db = [FMDatabase databaseWithPath:[CommonUtils getDatabasePath]];
    [db open];
    return db;
}

@end
