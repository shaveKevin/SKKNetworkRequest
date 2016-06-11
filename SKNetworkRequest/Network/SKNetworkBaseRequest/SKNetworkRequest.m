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
 *  @brief 同步 请求
 */
- (void)syncStart {
    [super syncStart];
}
/**
 *  @brief 异步请求
 */
- (void)asyncStart {
    [super asyncStart];
}

/// 请求失败 处理
- (void)requestFailedFilter {
    [self cacheResult];
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
/**
 *  @brief 重载 数据序列化  子类使用的话需要去重载 super
 */
- (void)dealWithData {
    self.dataDict = [NSMutableDictionary dictionaryWithDictionary:[self responseJSONObject]];
}

/**
 *  @brief 序列化 获取网络数据
 */
- (void)convertJson{
       NSDictionary * result = [self responseJSONObject];
    if([self jsonModelClass:result] &&
       [[self jsonModelClass:result] isSubclassOfClass:[SKResult class]]) {
        id obj = [[self jsonModelClass:result] parseTotalJson:result];
        self.result = obj;
    }
}
/**
 *  @brief yymodel
 *
 *  @param dictResult 映射
 *
 *  @return yymodel映射
 */
- (Class)jsonModelClass:(NSDictionary *)dictResult {
    return [SKResult class];
}
/**
 *  @brief  缓存数据
 */
- (void)cacheResult{
}

@end
