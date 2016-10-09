//
//  SecondViewController.m
//  test
//
//  Created by 李正雷 on 16/8/18.
//  Copyright © 2016年 LZL. All rights reserved.
//

#import "SecondViewController.h"
#import "LWYTextField.h"
#import "CircleView.h"

#import <WebKit/WebKit.h>

@interface SecondViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *_tableView;
    NSInteger viewYOffset;
    UITextField *curActiveTextField;


}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 320, 20)];
//    imageView1.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:imageView1];
    
    
    UIGraphicsBeginImageContext(imageView1.frame.size);   //开始画线
    [imageView1.image drawInRect:CGRectMake(0, 0, imageView1.frame.size.width, imageView1.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    
    
    CGFloat lengths[] = {10,5};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor redColor].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, 20.0);    //开始画线
    CGContextAddLineToPoint(line, 310.0, 20.0);
    CGContextStrokePath(line);
    
    imageView1.image = UIGraphicsGetImageFromCurrentImageContext();
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    self.inputControls = [[NSMutableArray alloc]init];
//    [self.view addSubview:_tableView];
    _tableView.scrollEnabled = YES;
    _tableView.delegate =self;
    _tableView.dataSource =self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)name:UIKeyboardWillShowNotification object:nil];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
    BOOL booler = [self validateEmail:@"136177@qq.comm"];
    NSLog(@"%d",booler);
    // Do any additional setup after loading the view.
}
- (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
-(void)btn
{
    CircleView *viewview = [[CircleView alloc]initWithFrame:CGRectMake(100, 300, 100, 100)];
    [self.view addSubview:viewview];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ss = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ss];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ss];
        LWYTextField *ff = [[LWYTextField alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
        [cell.contentView addSubview:ff];
        ff.delegate =self;
        ff.backgroundColor = [UIColor yellowColor];
        [self.inputControls addObject:ff];
    }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)calculateViewYOffset:(UITextField*)textField
{
    if(textField == nil)
        return 0;
    
    NSInteger yOffset = 0;
    
    CGRect rectInScreen = [textField convertRect:textField.bounds toView:nil];
    
    int iCSIIUIToolbarHeight = 0;//前一项，后一项按钮工具栏高度
    if([textField isKindOfClass:[LWYTextField class]])//[textField isKindOfClass:[PowerEnterUITextField class]] ||
        iCSIIUIToolbarHeight = 44;
    
    NSInteger chineseToolBarHeight = 40; //中文选字框高度
    NSString *inputMode =[[UITextInputMode currentInputMode] primaryLanguage];
    
    if (inputMode!=nil && ([inputMode isEqualToString:@"zh-Hans"]||[inputMode isEqualToString:@"zh-Hant"]))
        // &&![textField isKindOfClass:[PowerEnterUITextField class]]
    {
            chineseToolBarHeight = 36;
    }
    
        yOffset = (rectInScreen.origin.y + rectInScreen.size.height + 5) - ([[UIScreen mainScreen] bounds].size.height - 216.0f - iCSIIUIToolbarHeight - chineseToolBarHeight);

    
    //yOffset > 0 表示键盘挡住输入框,重合yOffset个像素
    //yOffset <= 0 表示键盘没挡住输入框,相距yOffset个像素
    
    return yOffset;
}
-(void)keyboardWillShow:(NSNotification*)notification
{
    //NSString *inputMode=[[UITextInputMode currentInputMode] primaryLanguage];
    //NSLog(@"keyboardWillShow, 输入法：%@",inputMode);
    
    if(viewYOffset >= 0 && curActiveTextField!=nil)
    {
        //需要计算View偏移量
        int yOffset = (int)[self calculateViewYOffset:curActiveTextField];
        viewYOffset = viewYOffset + yOffset;
        
        //        NSTimeInterval animationDuration = 0.30f;
        //        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        //        [UIView setAnimationDuration:animationDuration];
        
        if(viewYOffset > 0)
        {
            CGRect rect;

                rect = CGRectMake(0.0f, 64.0f-viewYOffset,self.view.frame.size.width,self.view.frame.size.height);

            self.view.frame = rect;
            
        }else
        {
            viewYOffset = 0;
            CGRect rect;
                rect = CGRectMake(0.0f, 64.0f, self.view.frame.size.width, self.view.frame.size.height);

            self.view.frame = rect;
        }
        //        [UIView commitAnimations];
    }
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //CGRect frame = textField.frame;  110618    6229 7600 4070 1017 548
    //NSLog(@"frame : %f",self.view.frame.size.height);
    
    //iPad键盘高度: portrait  264(英文) 264+54=318（中文拼音）  landscape  352
    //iPhone键盘高度: Portrait  216(英文) 216+36=252（中文拼音）216(中文手写)   Landscape  140
    
    //NSString *inputMode =[[UITextInputMode currentInputMode] primaryLanguage];
    //NSLog(@"textFieldDidBeginEditing, 输入法：%@",inputMode);
    //
    //    if([[textField inputView] class] == [UIPickerView class]){
    //        textField.enabled = NO;
    //    }
    
    curActiveTextField = textField;
    textField.highlighted = YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    curActiveTextField = nil;
    viewYOffset = 0;
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect;

        rect = CGRectMake(0.0f, 64.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    textField.highlighted = NO;
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    curActiveTextField = nil;
    viewYOffset = 0;
    //        NSTimeInterval animationDuration = 0.30f;
    //        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    //        [UIView setAnimationDuration:animationDuration];
    CGRect rect;

        rect = CGRectMake(0.0f, 64.0f, self.view.frame.size.width, self.view.frame.size.height);

    self.view.frame = rect;
    //        [UIView commitAnimations];
    [textField resignFirstResponder];
    textField.highlighted = NO;
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
