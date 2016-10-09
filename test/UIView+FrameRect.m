//
//  UIView+FrameRect.m
//  test
//
//  Created by 李正雷 on 16/7/22.
//  Copyright © 2016年 LZL. All rights reserved.
//

#import "UIView+FrameRect.h"

#define    AUTOSIZE(w) [[UIScreen mainScreen] bounds].size.width/375*w


@implementation UIView (FrameRect)

-(CGRect)frameAutoSize:(CGRect)autoSize
{
    double originX = AUTOSIZE(autoSize.origin.x);
    double originY = AUTOSIZE(autoSize.origin.y);
    double with = AUTOSIZE(autoSize.size.width);
    double height = AUTOSIZE(autoSize.size.height);
    CGRect frameSize = CGRectMake(originX, originY, with, height);
    return frameSize;
}
@end
