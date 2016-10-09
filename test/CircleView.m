//
//  CircleView.m
//  test
//
//  Created by 李正雷 on 16/8/5.
//  Copyright © 2016年 LZL. All rights reserved.
//

#import "CircleView.h"
#define   kDegreesToRadians(degrees)  ((pi * degrees)/ 180)


@implementation CircleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self drawRect:frame];
        self.backgroundColor = [UIColor cyanColor];
    }
    return self;
}
-(void)layoutSubviews
{
    NSLog(@"楼兰");
}
-(void)drawRect:(CGRect)rect
{
    const CGFloat pi = 3.14159265359;
    
    CGPoint center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    
    UILabel *bb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    bb.center = center;
    bb.backgroundColor = [UIColor redColor];
    [self addSubview:bb];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:25
                                                    startAngle:-pi/2
                                                      endAngle:2*pi*0.5-pi/2
                                                     clockwise:YES];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 5;
    UIColor *strokeColor = [UIColor redColor];
    [strokeColor set];
    
    [path stroke];
//    [self drawRoundView:center withStartAngle:-pi/2 withEndAngle:2*pi*0.5-pi/2 withRadius:25];
    
}

- (void)drawRoundView:(CGPoint)centerPoint withStartAngle:(CGFloat)startAngle withEndAngle:(CGFloat)endAngle withRadius:(CGFloat)radius {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:centerPoint radius:radius startAngle:startAngle endAngle:endAngle  clockwise:YES];
   CAShapeLayer *arcLayer = [CAShapeLayer layer];
    //arcLayer.strokeColor可设置画笔颜色
    arcLayer.lineWidth = 2;
    arcLayer.strokeColor = [UIColor redColor].CGColor;
    arcLayer.frame = self.bounds;
    arcLayer.strokeStart = 0.f;
    arcLayer.strokeEnd = 1.0f;
    arcLayer.path = path.CGPath;

//    arcLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:arcLayer];
    
    //动画显示圆则调用
    [self drawLineAnimation:arcLayer];

}

- (void)drawLineAnimation:(CALayer*)layer {
    CABasicAnimation *bas = [CABasicAnimation animationWithKeyPath:@"aa"];
    bas.duration = 10;
    const CGFloat pi = 3.14159265359;
    bas.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

    bas.delegate = self;
    bas.fromValue = [NSNumber numberWithInteger:0];
    bas.toValue = [NSNumber numberWithInteger:1];
    [layer addAnimation:bas forKey:nil];
}
@end
