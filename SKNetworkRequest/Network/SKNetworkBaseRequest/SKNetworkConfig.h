//
//  SKNetworkConfig.h
//  shavekevinRequest
//
//  Created by shavekevin on 16/3/8.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKNetworkConfig : NSObject

/**
 *  单例
 *
 *  @return 单例
 */
+ (SKNetworkConfig *)shareInstance;

/**
 *  基础接口
 */
@property (nonatomic, copy) NSString *baseUrl;
/**
 *  请求的CdnURL
 */
@property (nonatomic, copy) NSString *cdnUrl;

@end
