//
//  SKStaticNewsList_request.m
//  SKNetworkRequest
//
//  Created by shavekevin on 16/6/11.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKStaticNewsList_request.h"
#import "SKStaticNewsListResult.h"

static NSString *const nesListAPI = @"http://api.geeknews.app887.com/api/Articles.action";
@implementation SKStaticNewsList_request

/// 数据模型类
- (Class)jsonModelClass:(NSDictionary *)dictResult {
    return [SKStaticNewsListResult class];
}

// 接口
- (NSString *)requestUrl {
    return nesListAPI;
}
// 参数
- (id)requestArgument
{
    NSDictionary *dicParam = @{
                           @"npc":_firstResult,
                           @"opc":@"20",
                           @"type":_type,
                           @"uid":_uid
                           };
    
    return dicParam;
}

// 方法
- (SKNetworkRequestMethod)requestMethod {
    return SKNetworkRequestMethodGet;
}

@end
