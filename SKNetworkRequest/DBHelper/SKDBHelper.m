//
//  SKDBHelper.m
//  SKNetworkRequest
//
//  Created by shavekevin on 16/6/10.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKDBHelper.h"
#import "FMDB.h"
#import "SKResourcePath.h"

static NSString *dbName = @"SKNetworkRequest.db";

@implementation SKDBHelper


+ (void)setDataBaseName:(NSString *)name {
    
    NSAssert(name, @"name cannot be nil!");
    dbName = name;
}

+ (BOOL)createTable:(NSString *)sql {
    return [self executeUpdate:sql args:nil];
}

+ (BOOL)dropTable:(NSString *)sql {
    return [self executeUpdate:sql args:nil];
}

#pragma mark - insert
+ (BOOL)insert:(NSString *)table obj:(NSObject *)obj {
    NSAssert(obj && table, @"obj  or table cannot be nil!");
    
    return [self insert:table keyValues:[obj keyValues]];
}

+ (BOOL)insert:(NSString *)table keyValues:(NSDictionary *)keyValues {
    NSAssert(table && keyValues, @"table or keyValues cannot be nil!");
    return [self insert:table keyValues:keyValues replace:YES];
}

+ (BOOL)insert:(NSString *)table keyValues:(NSDictionary *)keyValues replace:(BOOL)replace {
    NSAssert(table && keyValues, @"table or keyValues cannot be nil!");
    
    NSMutableArray *columns = [NSMutableArray array];
    NSMutableArray *values = [NSMutableArray array];
    NSMutableArray *placeholder = [NSMutableArray array];
    
    [keyValues enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (obj && ![obj isEqual:[NSNull null]]) {
            [columns addObject:key];
            [values addObject:obj];
            [placeholder addObject:@"?"];
        }
    }];
    
    NSString *sql = [[NSString alloc] initWithFormat:@"INSERT%@ INTO %@ (%@) VALUES (%@)", replace?@" OR REPLACE":@"", table, [columns componentsJoinedByString:@","], [placeholder componentsJoinedByString:@","]];
    
    return [self executeUpdate:sql args:values];
}

+ (BOOL)insert:(NSString *)table sql:(NSString *)sql {
    return [self executeUpdate:sql];
}

#pragma mark - update

+ (BOOL)update:(NSString *)table obj:(NSObject *)obj {
    NSAssert(obj, @"obj cannot be nil!");
    return [self update:table keyValues:[obj keyValues]];
}

+ (BOOL)update:(NSString *)table obj:(NSObject *)obj where:(NSString *)where {
    NSAssert(obj, @"obj cannot be nil!");
    return [self update:table keyValues:[obj keyValues] where:where];
}

+ (BOOL)update:(NSString *)table keyValues:(NSDictionary *)keyValues {
    NSAssert(table && keyValues, @"table or keyValues cannot be nil!");
    NSAssert(keyValues[identifier], @"keyValues[@\"%@\"] cannot be nil!", identifier);
    
    return [self update:table keyValues:keyValues where:[NSString stringWithFormat:@"%@='%@'", identifier, keyValues[identifier]]];
}

+ (BOOL)update:(NSString *)table keyValues:(NSDictionary *)keyValues where:(NSString *)where {
    NSAssert(table && keyValues && where, @"table,keyValues,where can't be nil!");
    
    NSMutableArray *settings = [NSMutableArray array];
    NSMutableArray *values = [NSMutableArray array];
    
    [keyValues enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (obj && ![obj isEqual:[NSNull null]]) {
            [settings addObject:[NSString stringWithFormat:@"%@=?", key]];
            [values addObject:obj];
        }
    }];
    
    NSString *sql = [[NSString alloc] initWithFormat:@"UPDATE %@ SET %@ WHERE %@", table, [settings componentsJoinedByString:@","], where];
    
    return [self executeUpdate:sql args:values];
}

#pragma mark - remove
+ (BOOL)remove:(NSString *)table sql:(NSString *)sql {
    NSAssert(table, @"table cannot be nil!");
    return [self executeUpdate:sql args:nil];
}

#pragma mark - query
+ (NSMutableArray *)query:(NSString *)table sql:(NSString *)sql {
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[self dbPath]];
    if ([db open]){
        FMResultSet *rs = [db executeQuery:sql];
        
        while ([rs next]) {
            [result addObject:[rs resultDictionary]];
        }
        [db close];
    }
    db = nil;
    
    return result;
}

+ (NSMutableArray *)queryWithSql:(NSString *)sql {
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[self dbPath]];
    if ([db open]){
        FMResultSet *rs = [db executeQuery:sql];
        
        while ([rs next]) {
            [result addObject:[rs resultDictionary]];
        }
        [db close];
    }
    db = nil;
    
    return result;
}

#pragma mark - batch

+ (BOOL)executeBatch:(NSArray *)sqls useTransaction:(BOOL)useTransaction {
    NSAssert(sqls, @"sqls cannot be nil!");
    
    __block BOOL success = YES;
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self dbPath]];
    
    if (useTransaction) {
        [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            for (NSString *sql in sqls) {
                if (![db executeUpdate:sql]) {
                    *rollback = YES;
                    success = NO;
                    break;
                }
            }
        }];
    }
    else {
        [queue inDatabase:^(FMDatabase *db) {
            for (NSString *sql in sqls) {
                [db executeUpdate:sql];
            }
        }];
    }
    
    return success;
}

#pragma mark - private method
+ (BOOL)tableExists:(NSString*)tableName {
    BOOL exist = NO;
    FMDatabase *db = [FMDatabase databaseWithPath:[self dbPath]];
    if ([db open]) {
        exist = [db tableExists:tableName];
    }
    [db close];
    db = nil;
    return exist;
}

+ (BOOL)executeUpdate:(NSString *)sql {
    __block BOOL success = NO;
    FMDatabase *db = [FMDatabase databaseWithPath:[self dbPath]];
    if ([db open]) {
        success = [db executeUpdate:sql];
        [db close];
    }
    db = nil;
    return success;
}

+ (BOOL)executeUpdate:(NSString *)sql args:(NSArray *)args {
    __block BOOL success = NO;
    FMDatabase *db = [FMDatabase databaseWithPath:[self dbPath]];
    if ([db open]) {
        success = [db executeUpdate:sql withArgumentsInArray:args];
        [db close];
    }
    db = nil;
    return success;
}

+ (NSString *)dbPath {
    NSAssert(dbName, @"dbName cannot be nil!");
    
    if([[NSFileManager defaultManager] fileExistsAtPath:[kCachPath stringByAppendingString:DBPATH]] == NO)
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:[kCachPath stringByAppendingString:DBPATH]
                                  withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *path = [kCachPath stringByAppendingString:DBPATH];
    path = [path stringByAppendingPathComponent:dbName];
    return path;
}

@end
