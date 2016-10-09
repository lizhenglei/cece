//
//  SecViewController.m
//  test
//
//  Created by 李正雷 on 16/7/29.
//  Copyright © 2016年 LZL. All rights reserved.
//

#import "SecViewController.h"

@interface SecViewController ()

@end

@implementation SecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 90, 90);
    btn.backgroundColor = [UIColor yellowColor];
    [btn addTarget:self action:@selector(UU) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)UU
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@"12" forKey:@"age"];
    [dic setValue:@"lei" forKey:@"name"];
    self.LZLBlockBB(dic);
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)tttt:(BBBBB)block
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@"12" forKey:@"age"];
    [dic setValue:@"lei" forKey:@"name"];
    block(dic);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
