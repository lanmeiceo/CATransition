//
//  ProgressView.m
//  动画
//
//  Created by BlueBerry on 2018/8/19.
//  Copyright © 2018年 蓝莓. All rights reserved.
//

#import "ProgressView.h"

@implementation ProgressView

//利用动画来做进度

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

-(void)setProgressValue:(CGFloat)progressValue
{
    _progressValue=progressValue;
    //drawRect:手动调用不会创建跟view相关的上下文，只有系统调用该方法才会关联
    [self setNeedsDisplay];//系统会自动调用drawRect:
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGPoint center=CGPointMake(rect.size.width*0.5, rect.size.height*0.5);
    CGFloat radius=rect.size.width*0.5-10;
    CGFloat startA=-M_PI_2;
    CGFloat angle=self.progressValue* M_PI*2;
    CGFloat endA=startA+angle;
    UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:center radius:radius   startAngle:startA    endAngle:endA clockwise:YES];
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
                        

}



@end
