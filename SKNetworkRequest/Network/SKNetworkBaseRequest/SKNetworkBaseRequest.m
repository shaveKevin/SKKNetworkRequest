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

#pragma mark  - 根据需要子类进行重载的-
- (void)cacheCompleteFilter {
    
}

- (void)requestSuccessCompleteFilter {
    
}

- (void)requestFailureFilter {
    
}

- (NSString *)requestUrl {
    
    return _requestUrl;
}

- (NSString *)cdnUrl {
    
    return _cdnUrl;
}

- (NSString *)baseUrl {
    
    return _baseUrl;
}

- (NSTimeInterval)requestTimeoutInterval {
    
    return _requestTimeoutInterval;
    
}

- (id)requestArgument {
    
    return _requestArgument;
}

- (SKNetworkRequestMethod)requestMethod {
    
    return _requestMethod;
}

- (SKNetworkRequestSerializerType)requestSerializerType {
    
    return _requestSerializerType;
}


- (NSArray *)requestAuthorizationHeaderFieldArray {
    return _requestAuthorizationHeaderFieldArray;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return _requestHeaderFieldValueDictionary;
}

- (BOOL)useCDN {
    
    return _useCDN;
}

- (BOOL)statusCodeValidator {
    
    NSInteger statusCode = [self responseStatusCode];
    if (statusCode >= 200 && statusCode <= 299) {
        return YES;
    } else  {
        return NO;
    }
}

- (AFConstructingBlock)constructingBodyBlock {
    return nil;
}

- (void)asyncStart {
    
    [[SKNetworkAgent sharedInstance] addRequest:self async:YES];
}

- (void)syncStart {
    
    [[SKNetworkAgent sharedInstance] addRequest:self async:NO];

}

- (void)stop {
    self.delegate = nil;
    [[SKNetworkAgent sharedInstance] cancleRequest:self];
    
}
- (BOOL)isExecuting {
    return self.requestOperation.isExecuting;
}

- (void)asyncStartWithCompletionBlockWithSuccess:(void (^)(SKNetworkBaseRequest *))success failure:(void (^)(SKNetworkBaseRequest *))failure cache:(void (^)(SKNetworkBaseRequest *))cache {
    
    [self setCompletionBlockWithSuccess:success failure:failure cache:cache];
    [self asyncStart];
}

- (void)syncStartWithCompletionBlockWithSuccess:(void (^)(SKNetworkBaseRequest *))success failure:(void (^)(SKNetworkBaseRequest *))failure cache:(void (^)(SKNetworkBaseRequest *))cache {
    [self setCompletionBlockWithSuccess:success failure:failure cache:cache];
    [self syncStart];
}

- (void)setCompletionBlockWithSuccess:(void (^)(SKNetworkBaseRequest *))success failure:(void (^)(SKNetworkBaseRequest *))failure cache:(void (^)(SKNetworkBaseRequest *))cache {
    
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
    self.cacheCompletionBlock = cache;
}

- (void)clearCompletionBlock {
    
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
    self.cacheCompletionBlock = nil;
    
}

- (NSString *)responseString {
    
    NSString *responseString = self.requestOperation.responseString;
    return responseString;
}

- (id)responseJSONObject {
    
     NSString *responseString = self.responseString;
     NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
     NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
     return  result;
    
}

- (NSInteger)responseStatusCode {
    
    return self.requestOperation.response.statusCode;
}

- (NSDictionary *)responseHeaders {
    
    return self.requestOperation.response.allHeaderFields;

}


@end
