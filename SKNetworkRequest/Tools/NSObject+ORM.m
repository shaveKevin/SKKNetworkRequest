//
//  NSObject+ORM.m
//  SKNetworkRequest
//
//  Created by shavekevin on 16/6/10.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "NSObject+ORM.h"
#import <objc/runtime.h>

static const void *IDKey;

NSString * const identifier = @"id";

@implementation NSObject (ORM)

- (instancetype)initWithDictionary:(NSDictionary *)keyValues {
    
    if (self = [self init]) {
        NSAssert(keyValues, @"keyValues cannot be nil!");
        NSAssert([keyValues isKindOfClass:[NSDictionary class]], @"keyValues must be kind of NSDictionary!");
        
        NSDictionary *objectPropertys = [self objectPropertys];
        NSDictionary *arrayObjectPropertys = [self arrayObjectPropertys];
        NSDictionary *mapping = [self mapping];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:keyValues.count];
        [keyValues enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
            if ([obj jc_isValid]) {
                if ([key isEqualToString:identifier]) {
                    [dict setObject:obj forKey:NSStringFromSelector(@selector(ID))];
                }
                else {
                    NSString *useKey = mapping[key] ? : key;
                    
                    if ([obj isKindOfClass:[NSString class]]) {
                        NSError *error = nil;
                        
                        id jsonObject = [NSJSONSerialization JSONObjectWithData:[obj dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
                        
                        if (!error) {
                            obj = jsonObject;
                        }
                    }
                    
                    if ([obj isKindOfClass:[NSNumber class]]) {
                        objc_property_t property = class_getProperty(self.class, key.UTF8String);
                        
                        if (property != NULL) {
                            NSString *propertyType = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
                            
                            if ([propertyType respondsToSelector:@selector(containsString:)]) {
                                if ([propertyType containsString:@"String"]) {
                                    obj = [obj stringValue];
                                }
                            }
                            else {
                                if (!NSEqualRanges([propertyType rangeOfString:@"String"], NSMakeRange(NSNotFound, 0))) {
                                    obj = [obj stringValue];
                                }
                            }
                        }
                    }
                    
                    if ([obj isKindOfClass:[NSDictionary class]] && objectPropertys[useKey]) {
                        [dict setObject:[[objectPropertys[useKey] alloc] initWithDictionary:obj] forKey:useKey];
                    }
                    else if ([obj isKindOfClass:[NSArray class]] && arrayObjectPropertys[useKey])
                    {
                        NSMutableArray *tArr = [NSMutableArray array];
                        for(id objcIn in obj)
                        {
                            if ([objcIn isKindOfClass:[NSDictionary class]] && arrayObjectPropertys[useKey]) {
                                [tArr addObject:[[arrayObjectPropertys[useKey] alloc] initWithDictionary:(NSDictionary *)objcIn]];
                            }
                            else if ([objcIn isKindOfClass:[NSString class]]) {
                                NSError *error = nil;
                                
                                id jsonObject = [NSJSONSerialization JSONObjectWithData:[(NSString *)objcIn dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
                                [tArr addObject:jsonObject];
                            }
                            else  if ([objcIn isKindOfClass:[NSNumber class]]) {
                                objc_property_t property = class_getProperty(self.class, key.UTF8String);
                                
                                if (property != NULL) {
                                    NSString *propertyType = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
                                    
                                    if ([propertyType respondsToSelector:@selector(containsString:)]) {
                                        if ([propertyType containsString:@"String"]) {
                                            [tArr addObject:[objcIn stringValue]];
                                        }
                                    }
                                    else {
                                        if (!NSEqualRanges([propertyType rangeOfString:@"String"], NSMakeRange(NSNotFound, 0))) {
                                            [tArr addObject:[objcIn stringValue]];
                                        }
                                    }
                                }
                            }
                        }
                        obj = tArr;
                    }
                    else {
                        [dict setObject:obj forKey:useKey];
                    }
                }
            }
        }];
        
        [self jc_settingsDefaultValueForHasNilValuePropertys];
        
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

- (NSString *)ID {
    
    return objc_getAssociatedObject(self, &IDKey);
}

- (void)setID:(NSString *)ID {
    
    if([ID isKindOfClass:[NSNumber class]])
    {
        NSNumber *num = (NSNumber *)ID;
        ID = [num stringValue];
    }
    if(!ID){
        ID = @"";
    }
    //NSAssert(ID, @"ID cannot be nil!");
    objc_setAssociatedObject(self, &IDKey, ID, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"serial"])
        return;
}

- (NSMutableDictionary *)keyValues {
    NSDictionary *objectPropertys = [self objectPropertys];
    NSDictionary *arrayObjectPropertys = [self arrayObjectPropertys];
    
    [self jc_settingsDefaultValueForHasNilValuePropertys];
    
    NSDictionary *keyValues = [self dictionaryWithValuesForKeys:self.jc_propertys];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:keyValues.count];
    
    [keyValues enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj jc_isValid]) {
            if ([key isEqualToString:NSStringFromSelector(@selector(ID))]) {
                [dict setObject:obj forKey:identifier];
            }
            else {
                if (objectPropertys[key]) {
                    obj = [obj keyValues];
                }
                
                if([obj isKindOfClass:[NSArray class]] && arrayObjectPropertys[key])
                {
                    NSMutableArray *tArr = [NSMutableArray array];
                    for(NSObject *objc in obj)
                    {
                        [tArr addObject:[objc keyValues]];
                    }
                    obj = tArr;
                }
                
                if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]]) {
                    NSError *error = nil;
                    NSData *json = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
                    if (!error) {
                        obj = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
                    }
                }
                
                [dict setObject:obj forKey:key];
            }
        }
    }];
    
    return dict;
}

- (NSDictionary *)objectPropertys {
    return @{};
}

- (NSDictionary *)arrayObjectPropertys {
    return @{};
}

- (NSDictionary *)mapping {
    return @{};
}

#pragma mark -
- (NSMutableArray *)jc_propertys {
    
    NSMutableArray *allKeys = [[NSMutableArray alloc] initWithCapacity:0];
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for(int i = 0 ; i < count ; i++){
        [allKeys addObject:[NSString stringWithCString:property_getName(properties[i]) encoding:NSUTF8StringEncoding]];
    }
    
    free(properties);
    
    return allKeys;
}

- (void)jc_settingsDefaultValueForHasNilValuePropertys {
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    //    NSMutableArray * tArr = [NSMutableArray new];
    for(int i = 0 ; i < count ; i++){
        NSString *propertyName = [NSString stringWithCString:property_getName(properties[i]) encoding:NSUTF8StringEncoding];
        //        [tArr addObject:propertyName];
        if ([self valueForKey:propertyName] == nil) {
            NSString *propertyType = [NSString stringWithCString:property_getAttributes(properties[i]) encoding:NSUTF8StringEncoding];
            
            if (([propertyType hasPrefix:@"T@\"NSString\""] || [propertyType hasPrefix:@"T@\"NSMutableString\""])) {
                [self setValue:@"" forKey:propertyName];
            }
            else if ([propertyType hasPrefix:@"T@\"NSNumber\""]) {
                [self setValue:[NSNumber numberWithInt:0] forKey:propertyName];
            }
        }
    }
    
    free(properties);
}

- (BOOL)jc_isValid {
    
    return !(self == nil || [self isKindOfClass:[NSNull class]]);
}

@end
