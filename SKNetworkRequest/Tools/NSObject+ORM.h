//
//  NSObject+ORM.h
//  SKNetworkRequest
//
//  Created by shavekevin on 16/6/10.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const identifier;

@interface NSObject (ORM)

@property (nonatomic, copy) NSString * ID;
@property (nonatomic, readonly) NSMutableDictionary * keyValues;

- (instancetype)initWithDictionary:(NSDictionary *)keyValues;
- (NSDictionary *)objectPropertys;
- (NSDictionary *)arrayObjectPropertys;
- (NSDictionary *)mapping;
@end
