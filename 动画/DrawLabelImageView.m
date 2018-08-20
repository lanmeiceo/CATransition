//
//  DrawLabelImageView.m
//  动画
//
//  Created by BlueBerry on 2018/8/19.
//  Copyright © 2018年 蓝莓. All rights reserved.
//

#import "DrawLabelImageView.h"

@implementation DrawLabelImageView

//画文字，图片

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self drawImage:rect];
}

//画图片
-(void)drawImage:(CGRect)rect
{
    UIImage *image=[UIImage imageNamed:@"第1名"];
    //drawAtPoint绘制的是原始图片的大小
//    [image drawAtPoint:CGPointZero];
    
    //把绘制的图片填充到给定区域
//    [image drawInRect:rect];
    
    //裁剪，超过裁剪区域以外的内容都会被自动裁剪掉
    //设置裁剪区域一定要在绘制之前设置
    UIRectClip(CGRectMake(0, 0, 50, 50));
    //平铺
    [image drawAsPatternInRect:self.bounds];
  
    
//    UIRectFill(CGRectMake(50, 50, 50, 50));
}
//画文字
-(void)drawText
{
    NSString *str=@"Created by BlueBerry on";
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[NSFontAttributeName]=[UIFont systemFontOfSize:20];
    dic[NSForegroundColorAttributeName]=[UIColor redColor];
    //描边
    dic[NSStrokeColorAttributeName]=[UIColor greenColor];
    dic[NSStrokeWidthAttributeName]=@2;
    //阴影
    NSShadow *shadw=[[NSShadow alloc]init];
    shadw.shadowColor=[UIColor blueColor];
    shadw.shadowOffset=CGSizeMake(1, 1);
    shadw.shadowBlurRadius=2.0;
    dic[NSShadowAttributeName]=shadw;
    [str drawAtPoint:CGPointZero withAttributes:dic];//不会自动换行
    
   //    [str drawInRect:rect withAttributes:dic];//会自动换行
}
@end
