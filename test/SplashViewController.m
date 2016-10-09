//
//  SplashViewController.m
//  test
//
//  Created by 李正雷 on 16/9/7.
//  Copyright © 2016年 LZL. All rights reserved.
//

#import "SplashViewController.h"
#import "ThirdViewController.h"
#import "SecondViewController.h"
@interface SplashViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIWebViewDelegate>
{
    UIImageView *imageView;
    UIImageView *imageView2;
}
@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    UITextField *ff = [[UITextField alloc]initWithFrame:CGRectMake(100, 70, 100, 20)];
    [self.view addSubview:ff];
    ff.placeholder = @"吃过群主";
    UIColor *color = [UIColor blueColor];
//    ff.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"用户名" attributes:@{NSForegroundColorAttributeName: color}];
    [ff setValue:[UIColor blueColor] forKeyPath:@"_placeholderLabel.textColor"];
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
    imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
    imageView2.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView2];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
    [but setTitle:@"btn" forState:UIControlStateNormal];
    [but setTitle:@"按钮" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:but];
    but.frame = CGRectMake(100, 100, 100, 100);
  
    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    webview.backgroundColor = [UIColor yellowColor];
    webview.delegate =self;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"htps://www.baidu.com"]]];
    
}

-(void)btn
{
    SecondViewController *th = [[SecondViewController alloc]init];
    NSLog(@"nihao");
    //UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithTitle:@"nihao" style:0 target:nil action:nil];
  //  [self.navigationItem setBackBarButtonItem:bar];
    [self.navigationController pushViewController:th animated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
    //UIImagePickerControllerSourceType source = UIImagePickerControllerSourceTypePhotoLibrary;
    //UIImagePickerController *controller = [[UIImagePickerController alloc]init];
    //controller.delegate =self;
    //controller.sourceType = source;
    //controller.allowsEditing = YES;
    //[self presentViewController:controller animated:YES completion:nil];
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"加载网页错误");
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *image2 = [info objectForKey:UIImagePickerControllerOriginalImage];
    imageView.image = image;
    imageView2.image = image2;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
