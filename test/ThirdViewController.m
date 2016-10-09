//
//  ThirdViewController.m
//  test
//
//  Created by 李正雷 on 16/9/13.
//  Copyright © 2016年 LZL. All rights reserved.
//

#import "ThirdViewController.h"

#import <WebKit/WebKit.h>

extern UIView *lzlView;

@interface ThirdViewController ()<WKNavigationDelegate,WKScriptMessageHandler>
{
    UITextField *ff;
}
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];

    // Do any additional setup after loading the view.
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    WKWebView *webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:config];
    webView.backgroundColor = [UIColor yellowColor];
    webView.navigationDelegate =self;
    webView.allowsBackForwardNavigationGestures = YES;
    webView.allowsLinkPreview=YES;
    
    
    NSString *ss = [[NSBundle mainBundle]pathForResource:@"/Users/lzl/Desktop/文件/HTML5学习/login.html" ofType:nil];
    NSString *path = [NSString stringWithContentsOfFile:ss encoding:NSUTF8StringEncoding error:nil];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    WKUserContentController *user = [[WKUserContentController alloc]init];
    [user addScriptMessageHandler:self name:@"qqq"];
    config.userContentController = user;
    config.preferences.javaScriptEnabled = YES;
    [self.view addSubview:webView];
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    decisionHandler(WKNavigationActionPolicyAllow);
    NSLog(@"发送请求前");
}
-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    decisionHandler(WKNavigationResponsePolicyAllow);
    NSLog(@"接收到相应后");
}
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"接收到服务器跳转响应后调用");
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"开始加载页面");
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"页面加载完成");
    NSLog(@"1111%@",webView.backForwardList.backList);
    NSLog(@"2222%@",webView.backForwardList.forwardList);
    NSLog(@"3333%@",webView.backForwardList.currentItem.URL);
}
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"接受数据");
}
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"页面加载失败");
}

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"js交互");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
