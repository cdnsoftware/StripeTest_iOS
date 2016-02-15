////
//  DBManager.h
//
//  UIDemo
//
//  Created by Ambuj Shukla on 11/02/16.
//  Copyright © 2016 CDN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"

@interface DBManager : NSObject

-(BOOL)saveDatawithTablename:(NSString *)tableName withDatabaseName:(NSString*)databasename withColumnarray:(NSMutableArray*)columnArray withValues:(NSArray *)valueArray;

-(NSMutableArray*)doGetData:(NSString*)key WithValue:(NSString*)value WithTableName:(NSString*)tableName;

-(BOOL)deleteDatawithTablename:(NSString *)tableName withDeleteColumnName:(NSString*)UniqueKey withValue:(NSString *)value;


@end
