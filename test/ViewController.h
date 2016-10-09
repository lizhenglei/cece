//
//  ViewController.h
//  test
//
//  Created by 李正雷 on 16/7/20.
//  Copyright © 2016年 LZL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoanBannerView.h"
@interface ViewController : UIViewController
@property (nonatomic, strong) NSArray *imgs;
@property (nonatomic, strong) NSArray *linkImgs;
@property (nonatomic, weak) LoanBannerView *loanView;
@property(nonatomic,strong)NSMutableArray *inputControls;
@end

