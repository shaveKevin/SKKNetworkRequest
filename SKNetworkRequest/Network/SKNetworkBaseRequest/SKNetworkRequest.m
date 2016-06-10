//
//  SKNetworkRequest.m
//  shavekevinRequest
//
//  Created by shavekevin on 16/3/8.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKNetworkRequest.h"
#import "SKResult.h"
@implementation SKNetworkRequest
/**
 *  @brief <#Description#>
 */
- (void)syncStart {
    [super syncStart];
}
/**
 *  @brief <#Description#>
 */
- (void)asyncStart {
    [super asyncStart];
}

/// 请求失败
- (void)requestFailedFilter {
}

/// 请求成功 处理数据 .
-(void)requestSuccessCompleteFilter {
    
    [self convertJson];

    // 老的 新的。
    //[self dealWithData];
    
}
/**
 *  请求响应超时时间
 *
 *  @return request  called TimeoutInterval
 */

- (NSTimeInterval)requestTimeoutInterval{
    
    return 6.0f;
}
/**
 * 参数字典
 *
 *  @return parameDict
 */
- (id)requestArgument {
    
    return _dicParame;
}

// 重载 数据序列化  子类使用的话需要去重载 super

- (void)dealWithData {
    self.dataDict = [NSMutableDictionary dictionaryWithDictionary:[self responseJSONObject]];
    
}

- (void)convertJson{
       NSDictionary * result = [self responseJSONObject];
    if([self jsonModelClass:result] &&
       [[self jsonModelClass:result] isSubclassOfClass:[SKResult class]]) {
        id obj = [[self jsonModelClass:result] parseTotalJson:result];
        self.result = obj;
    }
}
- (Class)jsonModelClass:(NSDictionary *)dictResult {
    return [SKResult class];
}

- (void)cacheResult{
}

@end
