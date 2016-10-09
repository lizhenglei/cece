//
//  SecViewController.h
//  test
//
//  Created by 李正雷 on 16/7/29.
//  Copyright © 2016年 LZL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BBBBB)(NSDictionary *dic);

@interface SecViewController : UIViewController

-(void)tttt:(BBBBB)block;
@property(nonatomic,strong)void (^LZLBlockBB)(NSDictionary *dic);

@end
