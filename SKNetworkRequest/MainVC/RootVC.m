//
//  ViewController.m
//  SKNetworkRequest
//
//  Created by shavekevin on 16/3/9.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "RootVC.h"
#import "SKNetworkStatic_request.h"
#import "SKStaticNewsList_request.h"
#import "SKStaticNewsListResult.h"
#import "SKStaticNewsListModel.h"
@interface RootVC ()
/**
 *  @brief 请求1 .
 */
@property (nonatomic, strong) SKNetworkStatic_request *staticRequest;

/**
 *  @brief 请求2 .
 */
@property (nonatomic, strong) SKStaticNewsList_request *newsListRequest;
/**
 *  @brief page
 */
@property (nonatomic, assign) NSInteger pageFrom;
/**
 *  @brief SKStaticNewsListModel
 */
@property (nonatomic, strong) NSMutableArray <SKStaticNewsListModel *> *arrayModelList;
/**
 *  @brief 老的网络请求数据
 */
@property (nonatomic, strong) NSMutableDictionary *dictData;

@end

@implementation RootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initData];
    [self request];
}

#pragma mark  - 初始化
- (void)initData {
    self.view.backgroundColor = [UIColor whiteColor];
    _pageFrom = 0;
    self.arrayModelList = [NSMutableArray array];
    self.dictData = [NSMutableDictionary dictionary];
}

#pragma mark - 网络请求
- (void)request {
    
    __weak __typeof__ (self) wself = self;
    dispatch_queue_t queue = dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        __strong __typeof (wself) sself = wself;
        /// 请求1 .  同步请求
        [sself getData];
    });
    
    dispatch_group_async(group, queue, ^{
        __strong __typeof (wself) sself = wself;
        /// 请求2 .  同步请求
        [sself getNewsListData];
    });
    ///  请求1和请求2  全执行完之后 打印数据
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        __strong __typeof (wself) sself = wself;
        NSLog(@"-----%@",sself.dictData);
        NSLog(@"%ld",sself.arrayModelList.count);

        
    });

}
/**
 *  @brief 老的网络请求
 */
- (void)getData{
    
    if (_staticRequest) {
        [_staticRequest stop];
        _staticRequest  = nil;
    }
    _staticRequest = [[SKNetworkStatic_request alloc]init];
    _staticRequest.dicParame = @{@"123":@"version"};
    [_staticRequest syncStartWithCompletionBlockWithSuccess:^(SKNetworkBaseRequest *request) {
        SKNetworkStatic_request *requsetStatic = (SKNetworkStatic_request *)request;
        [requsetStatic dealWithData];
        self.dictData = requsetStatic.dataDict;
        
    } failure:^(SKNetworkBaseRequest *request) {
        //
    } cache:^(SKNetworkBaseRequest *request) {
        
    }];
    
}
/**
 *  @brief 新的网络请求
 */
- (void)getNewsListData {
    if (_newsListRequest) {
        [_newsListRequest stop];
        _newsListRequest = nil;
    }
    _newsListRequest = [[SKStaticNewsList_request alloc]init];
    _newsListRequest.firstResult = [NSString stringWithFormat:@"%ld",(long)_pageFrom];
    _newsListRequest.type = @"科技";
    _newsListRequest.uid = @"23080";
    [_newsListRequest syncStartWithCompletionBlockWithSuccess:^(SKNetworkBaseRequest *request) {
        SKStaticNewsList_request *reviewRequest = (SKStaticNewsList_request*)request;
        
        SKStaticNewsListResult *result = (SKStaticNewsListResult *)reviewRequest.result;
        [self dealWithData:result];
        
    } failure:^(SKNetworkBaseRequest *request) {
                //
    } cache:^(SKNetworkBaseRequest *request) {
        //
    }];
}
/**
 *  @brief 新的网络请求 处理逻辑放在VC
 *
 *  @param result 新的网络请求
 */
- (void)dealWithData:(SKStaticNewsListResult *)result {
    
    [self.arrayModelList addObjectsFromArray:result.arrayList];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
