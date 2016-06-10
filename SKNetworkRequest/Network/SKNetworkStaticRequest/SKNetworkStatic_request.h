//
//  SKNetworkStatic_request.h
//  shavekevinRequest
//
//  Created by shavekevin on 16/3/8.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

/**
 *  获取到网络请求提供两个供外面使用一个是已经序列化过的DIC 一个是根据需要获得的ARRAY 这里的话
 *  array 需要根据接口来获取
 */
#import "SKNetworkRequest.h"

@interface SKNetworkStatic_request : SKNetworkRequest
- (void)dealWithData;
@end
