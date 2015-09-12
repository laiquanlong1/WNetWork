//
//  WNetCheck.h
//  WNetWork
//
//  Created by HoTia on 15/9/7.
//  Copyright (c) 2015年 will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@class WNetCheck;

// 网络状态代理
@protocol WNetCheckDelegate <NSObject>

- (void)isNetworkStatus:(NetworkStatus)networkStatus;

@end

// 网络检测
@interface WNetCheck : NSObject
{
    NetworkStatus remoteHostStatus; // 网络状态
}
@property (nonatomic, weak) id <WNetCheckDelegate> delegate;
@property (nonatomic, strong) Reachability *reachability;

+ (WNetCheck *)shareWnetCheck; // appdelegate
+ (BOOL)isWIFI; // 判断是不是wifi
+ (BOOL)isWWAN; // 判断是不是移动网络
@end
