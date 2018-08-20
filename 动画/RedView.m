//
//  RedView.m
//  动画
//
//  Created by BlueBerry on 2018/8/18.
//  Copyright © 2018年 蓝莓. All rights reserved.
//

#import "RedView.h"

@implementation RedView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//做一个能任意拖拽的view：通过获取当前点和之前点，进行移动动画可以实现


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //UITouch触摸的位置，时间，阶段等手指信息
    UITouch *touch=[touches anyObject];
    
    CGPoint prePoint=[touch previousLocationInView:self];
    CGPoint currentPoint=[touch locationInView:self];
    
    CGFloat offsetX=currentPoint.x-prePoint.x;
    CGFloat offsetY=currentPoint.y-prePoint.y;
    
    self.transform=CGAffineTransformTranslate(self.transform, offsetX, offsetY);
    

}
@end
