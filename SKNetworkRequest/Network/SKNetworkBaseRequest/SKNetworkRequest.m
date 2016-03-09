//
//  SKNetworkRequest.m
//  shavekevinRequest
//
//  Created by shavekevin on 16/3/8.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKNetworkRequest.h"

@implementation SKNetworkRequest

//请求成功 处理数据
-(void)requestSuccessCompleteFilter {
    
    [self dealWithData];
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
    
    NSString *responseString = [self responseString];
    NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    self.dataDict = [NSMutableDictionary dictionaryWithDictionary:result];
    
}
@end
