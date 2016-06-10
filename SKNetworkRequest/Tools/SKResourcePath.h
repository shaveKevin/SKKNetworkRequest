//
//  SKResourcePath.h
//  SKNetworkRequest
//
//  Created by shavekevin on 16/6/10.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#ifndef SKResourcePath_h
#define SKResourcePath_h

//=============================定义保存资源路径=========================

#define kDocPath         [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, \
NSUserDomainMask, YES) objectAtIndex:0]

#define kCachPath        [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, \
NSUserDomainMask, YES) objectAtIndex:0]

#define kTmpPath          NSTemporaryDirectory()

//======================================================
// 图片路径
//======================================================
#define kImgDataPath    @"/Images"
#define kImgListPath    @"/Images/ImageList"


//======================================================
// 视频路径
//======================================================
#define kVedioDataPath  @"/DownLoad"
#define kVedioTempPath  @"/DownLoad/Temp"
#define kVedioListPath  @"/DownLoad/VideoList"



//======================================================
// 数据库路径
//======================================================
#define DBPATH @"/DB"

#endif /* SKResourcePath_h */
