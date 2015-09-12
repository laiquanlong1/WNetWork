//
//  WNetCheck.m
//  WNetWork
//
//  Created by HoTia on 15/9/7.
//  Copyright (c) 2015年 will. All rights reserved.
//

#import "WNetCheck.h"

@implementation WNetCheck



- (instancetype)init
{
    if (self = [super init]) {
        self.reachability = [Reachability reachabilityForInternetConnection];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkHaveChange:) name:kReachabilityChangedNotification object:nil];
        [self.reachability startNotifier];
        [self updateStatus];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.reachability = nil;
}

// 单例
+ (WNetCheck *)shareWnetCheck
{
    static WNetCheck *netCheck = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netCheck = [[WNetCheck alloc] init];
    });
    return netCheck;
}

// wifi
+ (BOOL)isWIFI
{
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] == ReachableViaWiFi);
}

// 3g
+ (BOOL)isWWAN
{
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == ReachableViaWWAN);
}

// 更新状态
- (void)updateStatus
{
    remoteHostStatus = [self.reachability currentReachabilityStatus];
}

- (IBAction)netWorkHaveChange:(id)sender
{
    [self updateStatus];
    if ([self.delegate respondsToSelector:@selector(isNetworkStatus:)]) {
        [self.delegate isNetworkStatus:remoteHostStatus];
    }
}

@end
