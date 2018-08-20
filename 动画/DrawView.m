//
//  DrawView.m
//  动画
//
//  Created by BlueBerry on 2018/8/19.
//  Copyright © 2018年 蓝莓. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView
//Core Graphics

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

//作用：专门来绘图  当view显示的时候调用
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //在drawRect方法中系统已经创建了一个跟view相关联的上下文（layer上下文）


    [self drawArc:rect];

}

//画圆弧
-(void)drawArc:(CGRect)rect
{
    //center:狐弧所在圆心
    //radius:圆的半径
    //startAngle开始角度
    //clockwise是否是顺时针
    //这里如果设置中心点不能使用self.center,因为它的坐标是相对于父控件
    UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width*0.5, rect.size.height*0.5) radius:rect.size.width*0.5-10 startAngle:0 endAngle:M_PI_4 clockwise:YES];
    //添加一根线到圆心
    [path addLineToPoint:CGPointMake(rect.size.width*0.5, rect.size.height*0.5)];
    //关闭路径,closePath从路径终点连接一根线到路径的点
    [path closePath];
    [path stroke];
}
//画椭圆
-(void)drwaCural
{
    UIBezierPath *path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50,100, 200)];
    
//    [path fill];
    [path stroke];//stroke是封装了之前上下文写法 所以直接画 （1.获取上下文2描述路径3把路径添加到上下文4把上下文的内容渲染到view上） 但是方法必须在drawRect:才能获取上下文
}
//画矩形
- (void)drawRect{

    //1.获取上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //2.描述路径
    //画矩形
    //    UIBezierPath *path=[UIBezierPath bezierPathWithRect:CGRectMake(50, 50,100, 200)];
    //圆角矩形
    UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 50,100, 200) cornerRadius:12.0];
    
    [[UIColor redColor]set];
    //3.路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    //4.上下文内容渲染到view
    //    CGContextStrokePath(ctx);
    CGContextFillPath(ctx);//填充
}
//画曲线
-(void)drawCurve
{
    //1.获取上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //2.描述路径
    UIBezierPath *path=[UIBezierPath bezierPath];
    //起点
    [path moveToPoint:CGPointMake(50, 200)];
    //添加曲线到某一个点
    [path addQuadCurveToPoint:CGPointMake(250, 280) controlPoint:CGPointMake(50, 50)];
    //3.路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    //4.上下文内容渲染到view
    CGContextStrokePath(ctx);
    
//    //可以简写为：
//    UIBezierPath *path=[UIBezierPath bezierPath];
//    //起点
//    [path moveToPoint:CGPointMake(50, 200)];
//    //添加曲线到某一个点
//    [path addQuadCurveToPoint:CGPointMake(250, 280) controlPoint:CGPointMake(50, 50)];
    [path stroke];
}
//画直线
-(void)drawLine
{
    
    //1.获取上下文(获取，创建上下文都以UIGraphics开头 )
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //2.绘制路径
    UIBezierPath *path=[UIBezierPath bezierPath];
    //起点
    [path moveToPoint:CGPointMake(50, 100)];
    //添加一条线到终点
    [path addLineToPoint:CGPointMake(250, 50)];
    [path addLineToPoint:CGPointMake(220, 150)];
    
    //    //画第二条线
    //    [path moveToPoint:CGPointMake(100, 100)];
    //    [path addLineToPoint:CGPointMake(220, 50)];
    
    //上下文的状态
    CGContextSetLineWidth(ctx, 10);
    //线的连接方式
    CGContextSetLineJoin(ctx, kCGLineJoinRound);//连接点的样式
    //线的顶角样式
    CGContextSetLineCap(ctx, kCGLineCapRound);
    //线颜色
    [[UIColor redColor]set];
    
    //3.把绘制的内容保存到上下文中
    CGContextAddPath(ctx, path.CGPath);
    //4.把上下文的内容显示到view(渲染到view上)
    CGContextStrokePath(ctx);
}
@end
