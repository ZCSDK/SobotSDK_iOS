//
//  NetworkTools.h
//  SobotApp
//
//  Created by 张新耀 on 15/9/7.
//  Copyright (c) 2015年 com.sobot.chat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZCLibReachability.h"

/**
 *  网络连接状态工具类
 */
@interface ZCLibNetworkTools : NSObject

/**
 *  如果没有连接到网络就弹出提醒实况
 */
@property (assign, nonatomic) BOOL isReachable;

/**
 *  是否为WIFI
 */
@property (assign, nonatomic) BOOL isReachableWiFi;

/**
 *  是否为WLAN
 */
@property (assign, nonatomic) BOOL isReachableWLAN;

/**
 *  当前网络状态
 */
@property (strong, nonatomic) ZCLibReachability *hostReach;

/**
 *  网络状态
 */
@property (strong, nonatomic) NSString * NetWorkStatus;

/**
 *  循环获取状态栏图标，判断网络实际情况
 *
 *  @return 网络状态（无网络 2G 3G 4G WIFI）
 */
- (NSString *)currentNetWorkStatusString;

/**
 *  单例
 *
 *  @return ZCLibNetworkTools创建的对象
 */
+(ZCLibNetworkTools *) shareNetworkTools;


/**
 *  移除网络监听
 */
-(void)removeNetworkObserver;


@end
