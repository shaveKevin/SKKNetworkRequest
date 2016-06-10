//
//  SKResult.h
//  SKNetworkRequest
//
//  Created by shavekevin on 16/6/11.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKResult : NSObject

/**
 *  @brief 解析接口返回的基础数据
 */

/*
@property (nonatomic, copy) NSString * responseMessage;
@property (nonatomic, copy) NSString * responseCode;
@property (nonatomic, strong) NSNumber * responseStatus;
@property (nonatomic, strong) NSNumber * responsePk;
*/
/**
*  @brief 解析出root 中数据
*/

@property (nonatomic,strong) NSString *root;
/*
 * 自动化解析所有json数据
 */
+ (instancetype)parseTotalJson:(NSDictionary *)jsDic;

@end
