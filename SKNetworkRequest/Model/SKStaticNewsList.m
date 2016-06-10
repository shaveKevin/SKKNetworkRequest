//
//  SKStaticNewsList.m
//  SKNetworkRequest
//
//  Created by shavekevin on 16/6/11.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKStaticNewsList.h"
#import "SKStaticNewsListModel.h"
@implementation SKStaticNewsList



/*
 * 解析
 */
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"time" : @"_id.time",
             @"newsID":@"ID"
             
             };
}

/*
 * 解析
 */
/*
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"imageArray" : [ImageModel class]
             };
}
 */
/**
 *  @brief list中数据无污染  网上获取的数据
 *
 *  @return 获取需要展示的或者要处理逻辑的数据
 */
- (SKStaticNewsListModel *)parseToStaticNewsListModel {
    
    SKStaticNewsListModel *model = [SKStaticNewsListModel new];
    model.newsID = self.newsID;
    model.url = self.url;
    model.date = self.date;
    model.sourcename = self.sourcename;
    model.content168 = self.content168;
    model.imglink = self.imglink;
    model.author = self.author;
    model.title = self.title;
    model.titlespelling = self.titlespelling;
    model.type = self.TYPE;
    model.imglink_1 = self.imglink_1;
    model.imglink_2 = self.imglink_2;
    model.imglink_3 = self.imglink_3;
    model.talkcount = self.talkcount;
    model.faved = self.faved;
    model.liked = self.liked;
    model.recommond = self.recommond;
    return model;
}
@end
