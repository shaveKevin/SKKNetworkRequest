//
//  SKNetworkConfig.m
//  shavekevinRequest
//
//  Created by shavekevin on 16/3/8.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKNetworkConfig.h"

@implementation SKNetworkConfig
/**
 *  单例
 *
 *  @return 网络请求只配置一次
 */
+ (SKNetworkConfig *)shareInstance {
    
    static SKNetworkConfig *shareManager = nil;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        
        shareManager = [[SKNetworkConfig alloc]init];
    });
    return shareManager;
}
/**
 *  基础接口
 *
 *  @return 一般都是固定不变的url
 */
- (NSString *)baseUrl {
    
    return nil;
}
/**
 *  @brief 请求的cdnURL
 *
 *  @return the cdnUrl Which  the request needed (optional)
 */
- (NSString *)cdnUrl {
    return nil;
}


@end
