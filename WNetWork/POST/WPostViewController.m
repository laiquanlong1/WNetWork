//
//  WPostViewController.m
//  WNetWork
//
//  Created by HoTia on 15/9/7.
//  Copyright (c) 2015年 will. All rights reserved.
//

#import "WPostViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "ASIHTTPRequest.h"
#import "MKNetworkKit.h"

@interface WPostViewController ()<NSURLConnectionDataDelegate,WNetCheckDelegate>
{
    UITextView *_textView;
}
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *data_v;
@end

@implementation WPostViewController

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


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
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

    
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 异步请求1

// 异步请求
- (void)setGetRequeststepWithConnectionAsyn_1
{
    // 设置请求路径;
    NSString *urlString = [NSString stringWithFormat:@"https://www.baidu.com"];
    
    // 转化为url路径
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 创建参数字符串 格式 @"sds = dsa & sfd = sfsdf"
    NSString *parmStr = @"";
    NSData *pramData = [parmStr dataUsingEncoding:NSUTF8StringEncoding];
    
    // 设置请求体
    [request setHTTPBody:pramData];
    // 请求方式
    [request setHTTPMethod:@"POST"];
    
    
    
    
    
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
    
    // 创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 创建参数字符串 格式 @"sds = dsa & sfd = sfsdf"
    NSString *parmStr = @"";
    NSData *pramData = [parmStr dataUsingEncoding:NSUTF8StringEncoding];
    
    // 设置请求体
    [request setHTTPBody:pramData];
    // 请求方式
    [request setHTTPMethod:@"POST"];
    
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
    
    // 创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 创建参数字符串 格式 @"sds = dsa & sfd = sfsdf"
    NSString *parmStr = @"";
    NSData *pramData = [parmStr dataUsingEncoding:NSUTF8StringEncoding];
    
    // 设置请求体
    [request setHTTPBody:pramData];
    // 请求方式
    [request setHTTPMethod:@"POST"];
    
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
//    AFHTTPRequestOperationManager *opM = [AFHTTPRequestOperationManager manager];
//    opM.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
//    [opM POST:@"https://www.baidu.com" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        _textView.text = operation.responseString;
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",[error description]);
//    }];
    
    
    // 设置请求路径;
    NSString *urlString = [NSString stringWithFormat:@"https://www.baidu.com"];
    
    // 转化为url路径
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 创建请求
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.f];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.f];
    
    // 缓存规则
    [[NSURLCache sharedURLCache] setMemoryCapacity:1*1024*1024];
    NSCachedURLResponse *rese = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
    if (rese != nil) {
        [request setCachePolicy:NSURLRequestReloadRevalidatingCacheData];
    }
    
    
    [request setHTTPMethod:@"POST"];
    NSData *data = [@"" dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
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
    
    
    [request setPostBody:[NSMutableData data]];
    [request setRequestMethod:@"POST"];
    
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
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"www.baidu.com" customHeaderFields:nil];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setValue:@"admin" forKey:@"username"];
//    [dic setValue:@"123" forKey:@"password"];
    MKNetworkOperation *op = [engine operationWithPath:nil params:dic httpMethod:@"POST" ssl:NO];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        _textView.text = completedOperation.responseString;
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        _textView.text = [error description];
    }];
    [engine enqueueOperation:op];
}

@end
