//
//  SKNetworkBaseRequest.h
//  shavekevinRequest
//
//  Created by shavekevin on 16/3/8.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@class SKResult;
/**
 *  MethodNetworkRequest
 */
typedef NS_ENUM(NSInteger, SKNetworkRequestMethod) {
    /**
     *  get method
     */
    SKNetworkRequestMethodGet = 0,
    /**
     *  put method
     */
    SKNetworkRequestMethodPut = 1,
    /**
     *  post method
     */
    SKNetworkRequestMethodPost = 2,
};

/**
 *  请求方式
 */
typedef NS_ENUM(NSInteger,  SKNetworkRequestSerializerType) {
    /**
     *  http
     */
    SKNetworkRequestSerializerTypeHttp = 0,
    /**
     *  json
     */
    SKNetworkRequestSerializerTypeJson = 1,
};

typedef void(^AFConstructingBlock)(id<AFMultipartFormData>formData);

@class SKNetworkBaseRequest;
/**
 *  @brief delegate
 */
@protocol SKNetworkBaseRequestDelegate <NSObject>

@optional
/**
 *  缓存读取成功
 *
 *  @param request cache read  finished
 */
- (void)cacheFinished:(SKNetworkBaseRequest *)request;
/**
 *  请求完成
 *
 *  @param request request finished
 */
- (void)requestFinished:(SKNetworkBaseRequest *)request;
/**
 *  请求失败
 *
 *  @param request request failed
 */
- (void)requestFailed:(SKNetworkBaseRequest *)request;
/**
 *  清除网络请求  make it clean
 */
- (void)clearRequet;


@end


@interface SKNetworkBaseRequest : NSObject
/**
 *  @brief result 网络数据
 */
@property (nonatomic, strong) SKResult *result;

/**
 *  网络数据
 */
@property (nonatomic, strong) NSMutableArray *dataArray;
/**
 *  接口
 */
@property (nonatomic, copy) NSString *requestUrl;
/**
 *  cdnUrl
 */
@property (nonatomic, copy) NSString *cdnUrl;
/**
 *  baseUrl
 */
@property (nonatomic, copy) NSString *baseUrl;
/**
 *  响应超时时间   timeInterval out  about the request
 */
@property (nonatomic, assign) NSTimeInterval requestTimeoutInterval;
/**
 *  网络请求参数列表  list of dicParame
*/
@property (nonatomic, strong) id requestArgument;
/**
 *  request method
 */
@property (nonatomic, assign) SKNetworkRequestMethod requestMethod;
/**
 *  request tag
 */
@property (nonatomic, assign) NSInteger tag;
/**
 *  type  of  Serializer  序列化类型
 */
@property (nonatomic, assign) SKNetworkRequestSerializerType  requestSerializerType;
/**
 *  header field array 请求的Server用户名和密码
 */
@property (nonatomic, strong) NSArray *requestAuthorizationHeaderFieldArray;
/**
 *  header field dictionary  在HTTP报头添加的自定义参数
 */
@property (nonatomic, strong) NSDictionary *requestHeaderFieldValueDictionary;
/**
 *  是否使用了 cdn
 */
@property (nonatomic, assign) BOOL useCDN;
/**
 *  结果dic
 */
@property (nonatomic, strong) NSMutableDictionary *dataDict;
/**
 *  userinfo
 */
@property (nonatomic, strong) NSDictionary *userInfo;
/**
 *  requestOperation
 */
@property (nonatomic, strong) AFHTTPRequestOperation *requestOperation;
/**
 *   request  delegate
 */
@property (nonatomic, weak) id<SKNetworkBaseRequestDelegate> delegate;
/**
 *  响应头
 */
@property (nonatomic, strong ,readonly) NSDictionary *responseHeaders;
/**
 *  返回json字符串
 */
@property (nonatomic, copy, readonly) NSString *responseString;
/**
 *  返回jsonObject
 */
@property (nonatomic, strong, readonly) id responseJSONObject;
/**
 *  请求状态码
 */
@property (nonatomic, assign) NSInteger responseStatusCode;
/**
 *  网络成功的回调
 */
@property (nonatomic, copy) void (^successCompletionBlock)(SKNetworkBaseRequest *);
/**
 *  网络请求失败的回调
 */
@property (nonatomic, copy) void (^failureCompletionBlock)(SKNetworkBaseRequest *);
/**
 *  缓存的回调
 */
@property (nonatomic, copy) void (^cacheCompletionBlock)(SKNetworkBaseRequest *);
/**
 *  append self to request queue  异步
 */
- (void)asyncStart;
/**
 *  append self to request queue  同步
 */
- (void)syncStart;
/**
 *  remove self from request queue  移除
 */
- (void)stop;

/**
 *  @return execute
 */

- (BOOL)isExecuting;
/**
 *  block回调   异步
 *
 *  @param success 成功
 *  @param failure 失败
 *  @param cache   缓存
 */
-(void)asyncStartWithCompletionBlockWithSuccess:(void(^)(SKNetworkBaseRequest *request))success failure:(void (^)(SKNetworkBaseRequest *request))failure cache:(void(^)(SKNetworkBaseRequest *request))cache;

/**
 *  block 回调  同步
 *
 *  @param success 成功
 *  @param failure 失败
 *  @param cache   缓存
 */
-(void)syncStartWithCompletionBlockWithSuccess:(void(^)(SKNetworkBaseRequest *request))success failure:(void (^)(SKNetworkBaseRequest *request))failure cache:(void(^)(SKNetworkBaseRequest *request))cache;


/**
 *  @brief 设置回调block
 *
 *  @param success 成功
 *  @param failure 失败
 *  @param cache   缓存
 */
- (void)setCompletionBlockWithSuccess:(void(^)(SKNetworkBaseRequest *request))success failure:(void (^)(SKNetworkBaseRequest *request))failure cache:(void(^)(SKNetworkBaseRequest *request))cache;
/**
 *  打破block循环引用  置block 为nil
 */

- (void)clearCompletionBlock;

#pragma mark  - 以下方法由子类继承来覆盖默认值  -

/**
 *  缓存回调
 */
- (void)cacheCompleteFilter;
/**
 *  请求成功的回调
 */
- (void)requestSuccessCompleteFilter;
/**
 *  请求失败的回调
 */
- (void)requestFailureFilter;
/**
 *  设置请求的URL setter getter
 *
 *  @param requestUrl set the url of request
 */
- (void)setRequestUrl:(NSString *)requestUrl;
- (NSString *)requestUrl;

/**
 *  请求的CdnURL  setter getter
 *
 *  @param cdnUrl set  cdnurl  of request
 */
- (void)setCdnUrl:(NSString *)cdnUrl;
- (NSString *)cdnUrl;

/**
 *  请求的BaseURL SETTER GETTER
 *
 *  @param baseUrl set baseURL OF THE REQUEST
 */
- (void)setBaseUrl:(NSString *)baseUrl;
- (NSString *)baseUrl;

/**
 *  请求的连接超时时间，默认为60秒 SETTER GETTER
 *
 *  @param requestTimeoutInterval requestTimeoutInterval DEFAULT  60S
 */
- (void)setRequestTimeoutInterval:(NSTimeInterval)requestTimeoutInterval;
- (NSTimeInterval)requestTimeoutInterval;

/**
 *  请求的参数列表 SETTER GETTER
 *
 *  @param requestArgument SET  REQUEST DICPARAME
 */
- (void)setRequestArgument:(id)requestArgument;
- (id)requestArgument;

/**
 *  Http请求的方法 SETTER GETTER
 *
 *  @param requestMethod requestMethod
 */
- (void)setRequestMethod:(SKNetworkRequestMethod)requestMethod;
- (SKNetworkRequestMethod)requestMethod;
/**
 *  请求的SerializerType  SETTER GETTER
 *
 *  @param requestSerializerType requestSerializerType OF REQUEST
 */
- (void)setRequestSerializerType:(SKNetworkRequestSerializerType)requestSerializerType;
- (SKNetworkRequestSerializerType)requestSerializerType;

/**
 *  请求的Server用户名和密码 SETTER GETTER
 *
 *  @param requestAuthorizationHeaderFieldArray requestAuthorizationHeaderFieldArray USERNAME AND PASSWORD
 */
- (void)setRequestAuthorizationHeaderFieldArray:(NSArray *)requestAuthorizationHeaderFieldArray;
- (NSArray *)requestAuthorizationHeaderFieldArray;
/**
 *  在HTTP报头添加的自定义参数  SETTER GETTER
 *
 *  @param requestHeaderFieldValueDictionary requestHeaderFieldValueDictionary
 */
- (void)setRequestHeaderFieldValueDictionary:(NSDictionary *)requestHeaderFieldValueDictionary;
- (NSDictionary *)requestHeaderFieldValueDictionary;
/**
 *  SETTER GETTER
 *
 *  @param useCDN 是否使用CDN的host地址
 */
- (void)setUseCDN:(BOOL)useCDN;
/**
 *  GetterMETHOD
 *
 *  @return 是否使用CDN的host地址
 */
- (BOOL)useCDN;
/**
 *  用于检查Status Code是否正常的方法
 *
 *  @return  Status Code
 */
- (BOOL)statusCodeValidator;
/**
 *  post  contains richtext use this api
 *
 *  @return 当POST的内容带有文件等富文本时使用
 */
- (AFConstructingBlock)constructingBodyBlock;


@end
