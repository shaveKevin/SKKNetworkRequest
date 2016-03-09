//
//  ViewController.m
//  SKNetworkRequest
//
//  Created by shavekevin on 16/3/9.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "ViewController.h"
#import "SKNetworkStatic_request.h"

@interface ViewController ()

@property (nonatomic, strong) SKNetworkStatic_request *request;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self getData];
}

- (void)getData{
    
    if (_request) {
        [_request stop];
        _request  = nil;
    }
    _request = [[SKNetworkStatic_request alloc]init];
    _request.dicParame = @{@"123":@"version"};
    [_request asyncStartWithCompletionBlockWithSuccess:^(SKNetworkBaseRequest *request) {
        
        SKNetworkStatic_request *requsetStatic = (SKNetworkStatic_request *)request;
        NSLog(@"%@",requsetStatic.dataDict);
        
    } failure:^(SKNetworkBaseRequest *request) {
        //
    } cache:^(SKNetworkBaseRequest *request) {
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
