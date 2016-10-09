//
//  ViewController.m
//  test
//
//  Created by 李正雷 on 16/7/20.
//  Copyright © 2016年 LZL. All rights reserved.
//

#import "ViewController.h"
#import "LWYTextField.h"
#import "UIView+FrameRect.h"
#import "SecViewController.h"
#import "CircleView.h"

//#define XXXX 
@interface ViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
{
    UIScrollView *_scrollowView;
    int _focuseCurrentIndex;
    UILabel *fitLabel;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *tt = [self digitUppercase:@"3890786425.9"];
    NSLog(@"&&&&&&%@",tt);
    fitLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, 200, 3)];
    fitLabel.backgroundColor = [UIColor blueColor];
    [self.view addSubview:fitLabel];
    fitLabel.text = @"该问题我也遇到了。不过我的账号能登录https://appleid.apple.com/zh_CN 管理我的账号，说明我的账号没有祝你好运";
    fitLabel.numberOfLines = 0;


    
    // Do any additional setup after loading the view, typically from a nib.
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    _scrollowView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 100)];
//    _scrollowView.backgroundColor = [UIColor redColor];
//    _scrollowView.contentSize = CGSizeMake(self.view.frame.size.width*3, 100);
//    _scrollowView.bounces = NO;
//    _scrollowView.delegate = self;
//    _scrollowView.pagingEnabled = YES;
//    [self.view addSubview:_scrollowView];
    
    CircleView *viewview = [[CircleView alloc]initWithFrame:CGRectMake(100, 300, 100, 100)];
    [self.view addSubview:viewview];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    LoanBannerView *bannerView = [[LoanBannerView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 200) BannerLinksArray:self.imgs infoArray:nil];
    [self.view addSubview:bannerView];
    bannerView.block = ^(NSInteger index) {
        NSLog(@"%ld",(long)index);
    };
    self.loanView = bannerView;
    self.inputControls = [[NSMutableArray alloc]init];
    UIView *view = [UIView new];
    view.frame = [view frameAutoSize:CGRectMake(0, 110, 370, 100)];
    view.backgroundColor = [UIColor redColor];
    UIView *yy = [[UIView alloc]init];
    yy.backgroundColor = [UIColor blackColor];
    [view addSubview:yy];
    yy.frame = [view frameAutoSize:CGRectMake(0, 0, 30, 30)];
    [self.view addSubview:view];
    UITapGestureRecognizer *gg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(UUU:)];
    [view addGestureRecognizer:gg];
    NSLog(@"%@",NSStringFromCGRect(view.frame));
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = [btn frameAutoSize:CGRectMake(100, 100, 90, 90)];
    btn.backgroundColor = [UIColor yellowColor];
    [btn addTarget:self action:@selector(UU) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
#ifdef XXXX
    NSLog(@"nihao");
#endif
    
    LWYTextField *ff = [[LWYTextField alloc]init];
    ff.delegate = self;
    ff.frame = CGRectMake(0, 200, 100, 20);
    ff.backgroundColor = [UIColor redColor];
    [self.view addSubview:ff];
    LWYTextField *ffff = [[LWYTextField alloc]initWithFrame:CGRectMake(0, 450, 100, 20)];
    ffff.backgroundColor = [UIColor yellowColor];
    ffff.delegate = self;
    [self.view addSubview:ffff];
    [self.inputControls addObject:ff];
    [self.inputControls addObject:ffff];
//   NSArray *_rightTFs = [@[ff,ffff] mutableCopy];
//    for (LWYTextField* textField in _rightTFs) {
//        textField.MustInput = YES;//必输项
//    }
    
    int (^LLLL)(int b) = ^(int nu)
    {
        return nu*3;
    };
    int a= LLLL(3);
    NSLog(@"%d",a);
    
    void (^UUUU)(int) = ^(int nn)
    {
//       __block int b = nn*4;
        NSLog(@"%d",nn);
    };
    UUUU(4);
}

//////

-(NSString *)digitUppercase:(NSString *)money
{
    NSMutableString *moneyStr=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%.2f",[money doubleValue]]];
    NSArray *MyScale=@[@"分", @"角", @"元", @"拾", @"佰", @"仟", @"万", @"拾", @"佰", @"仟", @"亿", @"拾", @"佰", @"仟", @"兆", @"拾", @"佰", @"仟" ];
    NSArray *MyBase=@[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"];
    NSMutableString *M=[[NSMutableString alloc] init];
    [moneyStr deleteCharactersInRange:NSMakeRange([moneyStr rangeOfString:@"."].location, 1)];
    for(int i=moneyStr.length;i>0;i--)
    {
        NSInteger MyData=[[moneyStr substringWithRange:NSMakeRange(moneyStr.length-i, 1)] integerValue];
        [M appendString:MyBase[MyData]];
        if([[moneyStr substringFromIndex:moneyStr.length-i+1] integerValue]==0&&i!=1&&i!=2)
        {
            [M appendString:@"元整"];
            break;
        }
        [M appendString:MyScale[i-1]];
    }
    return M;
}
- (NSArray *)imgs {
    if (!_imgs) {
        _imgs = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", nil];
    }
    return _imgs;
}
- (NSArray *)linkImgs {
    if (!_linkImgs) {
        _linkImgs = [NSArray arrayWithObjects:@"http://cdn.duitang.com/uploads/item/201209/27/20120927174050_HjNYf.thumb.700_0.jpeg",@"http://img5.duitang.com/uploads/item/201508/25/20150825203917_Uc8jY.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/blog/201505/18/20150518162302_Y4HVE.thumb.700_0.jpeg",@"http://img4.duitang.com/uploads/item/201506/09/20150609115651_Rci8X.thumb.700_0.jpeg", nil];
    }
    return _linkImgs;
}
-(void)UU{
    SecViewController *tt = [[SecViewController alloc]init];
//    [self.navigationController pushViewController:tt animated:YES];
    tt.LZLBlockBB = ^(NSDictionary *dic){
        NSLog(@"8888%@",dic);
    } ;
    

    [self presentViewController:tt animated:YES completion:nil];
}
-(void)UUU:(UITapGestureRecognizer *)tap
{
    NSLog(@"试试");
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    SecViewController *ss = [[SecViewController alloc]init];
    [ss tttt:^(NSDictionary *dic) {
        NSLog(@"666%@",dic);
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [fitLabel sizeToFit];
}
//颜色支持16进制
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

@end
