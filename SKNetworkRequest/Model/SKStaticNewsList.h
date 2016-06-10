//
//  SKStaticNewsList.h
//  SKNetworkRequest
//
//  Created by shavekevin on 16/6/11.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKStaticNewsListModel;

@interface SKStaticNewsList : NSObject
/**
 *  @brief time
 */
@property (nonatomic, copy) NSString *time;

/**
 *  @brief newsId
 */
@property (nonatomic, copy) NSString *newsID;

/**
 *  @brief url
 */
@property (nonatomic, copy) NSString *url;
/**
 *  @brief date
 */
@property (nonatomic, copy) NSString *date;
/**
 *  @brief sourcename
 */
@property (nonatomic, copy) NSString *sourcename;
/**
 *  @brief content168
 */
@property (nonatomic, copy) NSString *content168;
/**
 *  @brief imglink
 */
@property (nonatomic, copy) NSString *imglink;
/**
 *  @brief author
 */
@property (nonatomic, copy) NSString *author;
/**
 *  @brief title
 */
@property (nonatomic, copy) NSString *title;
/**
 *  @brief titlespelling
 */
@property (nonatomic, copy) NSString *titlespelling;
/**
 *  @brief TYPE
 */
@property (nonatomic, copy) NSString *TYPE;
/**
 *  @brief imglink_1
 */
@property (nonatomic, copy) NSString *imglink_1;
/**
 *  @brief imglink_2
 */
@property (nonatomic, copy) NSString *imglink_2;
/**
 *  @brief imglink_3
 */
@property (nonatomic, copy) NSString *imglink_3;
/**
 *  @brief talkcount
 */
@property (nonatomic, copy) NSString *talkcount;
/**
 *  @brief faved
 */
@property (nonatomic, copy) NSString *faved;
/**
 *  @brief liked
 */
@property (nonatomic, copy) NSString *liked;
/**
 *  @brief recommond
 */
@property (nonatomic, copy) NSString *recommond;
/**
 *  @brief 解析出需要的数据
 *
 *  @return listModel
 */
- (SKStaticNewsListModel *)parseToStaticNewsListModel;

@end
