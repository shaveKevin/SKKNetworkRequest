//
//  SKNetworkBaseRequest.m
//  shavekevinRequest
//
//  Created by shavekevin on 16/3/8.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKNetworkBaseRequest.h"
#import "SKNetworkAgent.h"
static CGFloat const timeOutInterval = 60.0f;
@implementation SKNetworkBaseRequest
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)init {
    
    if (self= [super init]) {
        _requestUrl = @"";
        _cdnUrl = @"";
        _baseUrl = @"";
        _requestTimeoutInterval = timeOutInterval;
        _requestMethod = SKNetworkRequestMethodGet;
        _requestSerializerType = SKNetworkRequestSerializerTypeHttp;
        _useCDN = NO;
        _dataArray =[NSMutableArray array];
        _dataDict = [NSMutableDictionary dictionary];
    }
    return self;
}
/// 根据需要进行重载的
- (void)cacheCompleteFilter {
    
}
/**
 *  <#Description#>
 */
- (void)requestSuccessCompleteFilter {
    
}
/**
 *  <#Description#>
 */
- (void)requestFailureFilter {
    
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)requestUrl {
    
    return _requestUrl;
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)cdnUrl {
    
    return _cdnUrl;
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)baseUrl {
    
    return _baseUrl;
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (NSTimeInterval)requestTimeoutInterval {
    
    return _requestTimeoutInterval;
    
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (id)requestArgument {
    
    return _requestArgument;
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (SKNetworkRequestMethod)requestMethod {
    
    return _requestMethod;
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (SKNetworkRequestSerializerType)requestSerializerType {
    
    return _requestSerializerType;
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */

- (NSArray *)requestAuthorizationHeaderFieldArray {
    return _requestAuthorizationHeaderFieldArray;
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return _requestHeaderFieldValueDictionary;
}
/**
 *
 *
 *  @return <#return value description#>
 */
- (BOOL)useCDN {
    
    return _useCDN;
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)statusCodeValidator {
    
    NSInteger statusCode = [self responseStatusCode];
    if (statusCode >= 200 && statusCode <= 299) {
        return YES;
    } else  {
        return NO;
    }
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */

- (AFConstructingBlock)constructingBodyBlock {
    return nil;
}
/**
 *  异步
 */
- (void)asyncStart {
    
    [[SKNetworkAgent sharedInstance] addRequest:self async:YES];
}
/**
 *  同步
 */
- (void)syncStart {
    
    [[SKNetworkAgent sharedInstance] addRequest:self async:NO];

}
/**
 *  <#Description#>
 */
- (void)stop {
    self.delegate = nil;
    [[SKNetworkAgent sharedInstance] cancleRequest:self];
    
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)isExecuting {
    return self.requestOperation.isExecuting;
}
/**
 *  <#Description#>
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 *  @param cache   <#cache description#>
 */
- (void)asyncStartWithCompletionBlockWithSuccess:(void (^)(SKNetworkBaseRequest *))success failure:(void (^)(SKNetworkBaseRequest *))failure cache:(void (^)(SKNetworkBaseRequest *))cache {
    
    [self setCompletionBlockWithSuccess:success failure:failure cache:cache];
    [self asyncStart];
}
/**
 *  <#Description#>
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 *  @param cache   <#cache description#>
 */
- (void)syncStartWithCompletionBlockWithSuccess:(void (^)(SKNetworkBaseRequest *))success failure:(void (^)(SKNetworkBaseRequest *))failure cache:(void (^)(SKNetworkBaseRequest *))cache {
    [self setCompletionBlockWithSuccess:success failure:failure cache:cache];
    [self syncStart];
}
/**
 *  <#Description#>
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 *  @param cache   <#cache description#>
 */
- (void)setCompletionBlockWithSuccess:(void (^)(SKNetworkBaseRequest *))success failure:(void (^)(SKNetworkBaseRequest *))failure cache:(void (^)(SKNetworkBaseRequest *))cache {
    
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
    self.cacheCompletionBlock = cache;
}
/**
 *  <#Description#>
 */
- (void)clearCompletionBlock {
    
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
    self.cacheCompletionBlock = nil;
    
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)responseString {
    
    NSString *responseString = self.requestOperation.responseString;
    return responseString;
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (id)responseJSONObject {
    
     NSString *responseString = self.responseString;
     NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
     NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
     return  result;
    
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)responseStatusCode {
    
    return self.requestOperation.response.statusCode;
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (NSDictionary *)responseHeaders {
    
    return self.requestOperation.response.allHeaderFields;

}


@end
