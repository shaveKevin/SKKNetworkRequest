//
//  SKResult.m
//  SKNetworkRequest
//
//  Created by shavekevin on 16/6/11.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKResult.h"
#import "YYModel.h"
@implementation SKResult

/// 解析所有json数据
+ (instancetype)parseTotalJson:(NSDictionary *)jsDic{
    /*
    NSDictionary * responseData = jsDic[@"responseData"];
    SKResult * result = [[self class] parseSubJson:responseData];
    
    if(!result) {
        result = [SKResult new];
    }
    
    NSString * responseMessage = jsDic[@"responseMessage"];
    result.responseMessage = responseMessage;
    
    NSString * responseCode = jsDic[@"responseCode"];
    result.responseCode = responseCode;
    
    NSNumber * responseStatus = jsDic[@"responseStatus"];
    result.responseStatus = responseStatus;
    
    NSNumber * responsePk = jsDic[@"responsePk"];
    result.responsePk = responsePk;
    
    return result;
     */
    NSDictionary *responseData = jsDic[@"root"];
    SKResult *result = [[self class] parseSubJson:responseData];
    if(!result) {
        result = [SKResult new];
    }
    return result;
}

/// 解析responseData json数据
+ (instancetype)parseSubJson:(NSDictionary *)jsDic {
    
    SKResult *result = [[self class] yy_modelWithDictionary:jsDic];
    return result;
}

@end
