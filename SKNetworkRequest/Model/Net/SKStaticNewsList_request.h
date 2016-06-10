//
//  SKStaticNewsList_request.h
//  SKNetworkRequest
//
//  Created by shavekevin on 16/6/11.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKNetworkRequest.h"

@interface SKStaticNewsList_request : SKNetworkRequest
/**
 *  @brief 请求初始位置
 */
@property (nonatomic,assign) NSString *firstResult;
/**
 *  @brief type
 */
@property (nonatomic, copy) NSString *type;
/**
 *  @brief uid
 */
@property (nonatomic, copy) NSString *uid;

@end
