//
//  SKDBHelper.h
//  SKNetworkRequest
//
//  Created by shavekevin on 16/6/10.
//  Copyright © 2016年 shavekevin. All rights reserved.
//
/**
 *  @brief 数据库DBHelper
 *
 *  @return 数据库DBHelper
 */
#import <Foundation/Foundation.h>
#import "NSObject+ORM.h"

@interface SKDBHelper : NSObject

+ (void)setDataBaseName:(NSString *)name;

+ (BOOL)tableExists:(NSString*)tableName;
+ (BOOL)createTable:(NSString *)sql;
+ (BOOL)dropTable:(NSString *)sql;

+ (BOOL)insert:(NSString *)table obj:(NSObject *)obj;
+ (BOOL)insert:(NSString *)table keyValues:(NSDictionary *)keyValues;
+ (BOOL)insert:(NSString *)table keyValues:(NSDictionary *)keyValues replace:(BOOL)replace;

+ (BOOL)insert:(NSString *)table sql:(NSString *)sql;

+ (BOOL)update:(NSString *)table obj:(NSObject *)obj;
+ (BOOL)update:(NSString *)table obj:(NSObject *)obj where:(NSString *)where;
+ (BOOL)update:(NSString *)table keyValues:(NSDictionary *)keyValues;
+ (BOOL)update:(NSString *)table keyValues:(NSDictionary *)keyValues where:(NSString *)where;

+ (BOOL)remove:(NSString *)table sql:(NSString *)sql;

+ (NSMutableArray *)query:(NSString *)table sql:(NSString *)sql;
+ (NSMutableArray *)queryWithSql:(NSString *)sql;

+ (BOOL)executeBatch:(NSArray *)sqls useTransaction:(BOOL)useTransaction;

@end
