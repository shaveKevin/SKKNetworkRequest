//
//  SKStaticNewsListResult.m
//  SKNetworkRequest
//
//  Created by shavekevin on 16/6/11.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKStaticNewsListResult.h"
#import "SKStaticNewsList.h"

@implementation SKStaticNewsListResult

/*
 * 解析
 */
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"arrayList" : @"list"
             };
}

/*
 * 解析 数组映射
 */
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"arrayList" : [SKStaticNewsList class]};
}
@end
