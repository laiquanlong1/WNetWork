//
//  WGetViewController.m
//  WNetWork
//
//  Created by HoTia on 15/9/6.
//  Copyright (c) 2015年 will. All rights reserved.
//







#import "WGetViewController.h"
#import "AFNetworking.h"
#import "ASIHTTPRequest.h"
#import "MKNetworkKit.h"


@interface WGetViewController ()<NSURLConnectionDataDelegate,WNetCheckDelegate,ASIHTTPRequestDelegate>
{
    UITextView *_textView;
}
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *data_v;

@end

@implementation WGetViewController

#pragma mark 网络状态

- (void)isNetworkStatus:(NetworkStatus)networkStatus
{
    switch (networkStatus) {
        case NotReachable:
        {
            NSLog(@"没有网络");
        }
            break;
            
        case ReachableViaWiFi:
        {
            NSLog(@"wifi");
        }
            break;
            
        case ReachableViaWWAN:
        {
            NSLog(@"移动蜂窝");
        }
            break;
        default:
            break;
    }
}


#pragma mark view and memory

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]]; // white backgroundColor
    _textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; // 自动拉伸
    [self.view addSubview:_textView];
    
    // 网络检测
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    del.netCheck.delegate = self;
 
    // 网络判断
    BOOL i = [WNetCheck isWIFI];
    if (i) {
        // 判断是使用什么请求
        switch (self.row) {
            case 0:
                [self setGetRequeststepWithConnectionAsyn_1]; // 0 row to jump connection
                break;
            case 1:
                [self setGetRequeststepWithConnectionAsyn_2]; // 1 row to jump connection
                break;
                
            case 2:
                [self setGetRequeststepWithConnectionsSyn]; // 2 row to jump connection
                break;
            case 3:
                [self afnetworking]; // 3 row to jump connection
                break;
                
            case 4:
                [self asiHttpRequest]; // 4 row to jump connection
                break;
                
            case 5:
                [self mkNetWorkKit]; // 5 row to jump connection
                break;
                
            default:
                break;
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络提示" message:@"您当前不是使用的wifi" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark 异步请求1

// 异步请求
- (void)setGetRequeststepWithConnectionAsyn_1
{
    // 设置请求路径;
    NSString *urlString = [NSString stringWithFormat:@"https://www.baidu.com"];
    
    // 转化为url路径
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.f];
    
    /*
     
     NSURLRequestUseProtocolCachePolicy（基础策略）
     018
     
     019
     NSURLRequestReloadIgnoringLocalCacheData（忽略本地缓存）
     020
     
     021
     NSURLRequestReturnCacheDataElseLoad（首先使用缓存，如果没有本地缓存，才从原地址下载）
     022
     
     023
     NSURLRequestReturnCacheDataDontLoad（使用本地缓存，从不下载，如果本地没有缓存，则请求失败，此策略多用于离线操作）
     024
     
     025
     NSURLRequestReloadIgnoringLocalAndRemoteCacheData（无视任何缓存策略，无论是本地的还是远程的，总是从原地址重新下载）
     026
     
     027
     NSURLRequestReloadRevalidatingCacheData（如果本地缓存是有效的则不下载，其他任何情况都从原地址重新下载）
     
     */
    
    // 网络请求 设置代理
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    // 判断是否连接成功
    if (self.connection)
    {
        NSLog(@"链接成功");
    }
    else
    {
        NSLog(@"链接失败");
    }
}

// dalegates

// 链接失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error description]);
}

// 接受到响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.data_v = [NSMutableData data];
    [self.data_v setLength:0];
}

// 接受到数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"%s,%ld",__func__,[self.data_v length]);
    [self.data_v appendData:data];
}

// 完成加载
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"%ld",[self.data_v length]);
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_2312_80);
    
    
    NSString *mystr = [[NSString alloc] initWithData:self.data_v encoding:NSUTF8StringEncoding];
    _textView.text = mystr;
    NSLog(@"finish data %@",mystr);
}


#pragma mark 异步请求2
- (void)setGetRequeststepWithConnectionAsyn_2
{
    // 设置请求路径;
    NSString *urlString = [NSString stringWithFormat:@"https://www.baidu.com"];
    
    // 转化为url路径
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.f];
    
    // 网络请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError == noErr) {
            NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            _textView.text = dataString;
        }
        else
        {
            NSLog(@"%@",[connectionError description]);
        }
    }];
    
    
}
#pragma mark 同步请求

- (void)setGetRequeststepWithConnectionsSyn
{
    // 设置请求路径;
    NSString *urlString = [NSString stringWithFormat:@"https://www.baidu.com"];
    
    // 转化为url路径
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.f];
    
    // 发送请求
    NSURLResponse *response = nil;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error == noErr) {
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        _textView.text = dataString;
    }
    else
    {
        NSLog(@"%@",[error description]);
    }
}

#pragma mark AFNetworking

- (void)afnetworking
{
//    __block NSString *string = nil;
//    AFHTTPRequestOperationManager *opM = [AFHTTPRequestOperationManager manager];
//     opM.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
//    [opM GET:@"https://www.baidu.com" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",operation.responseString);
//        string = responseObject;
//          _textView.text = string;
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@ ",operation.responseString);
//          _textView.text = [error description];
//    }];
  
    
    // 设置请求路径;
    NSString *urlString = [NSString stringWithFormat:@"https://www.baidu.com"];
    
    // 转化为url路径
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.f];
    
    AFHTTPRequestOperation *opration = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation.responseString);
        _textView.text = operation.responseString;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error description]);
    }];
    [opration start];
    
}

#pragma mark ASIHTTPRequest

- (void)asiHttpRequest
{
    // 设置请求路径;
    NSString *urlString = [NSString stringWithFormat:@"https://www.baidu.com"];
    
    // 转化为url路径
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 设置请求
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    
    //同步请求
//    [request startSynchronous];
//    NSError *error = [request error];
//    if (error == noErr) {
//        NSString *response = [request responseString];
//        _textView.text = response;
//    }
    
    
    
    
    // 异步请求
    [request setDelegate:self];
    [request startAsynchronous];
    
    
}
// delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    _textView.text = [request responseString];
}

#pragma mark MKNetworkKit

- (void)mkNetWorkKit
{
    // 设置请求路径;
    NSString *urlString = [NSString stringWithFormat:@"www.baidu.com"];
 
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:urlString customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:nil params:nil httpMethod:@"GET"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        _textView.text = [completedOperation responseString];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        _textView.text = [error description];
    }];
    [engine enqueueOperation:op];
}


@end
