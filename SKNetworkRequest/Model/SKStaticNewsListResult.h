//
//  SKStaticNewsListResult.h
//  SKNetworkRequest
//
//  Created by shavekevin on 16/6/11.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKResult.h"

@interface SKStaticNewsListResult : SKResult
/**
 *  @brief count
 */
@property (nonatomic, assign) NSInteger count;
/**
 *  @brief list
 */
@property (nonatomic, copy) NSArray *arrayList;


@end
