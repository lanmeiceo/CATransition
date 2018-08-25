//
//  DisplayLinkTimerView.m
//  动画
//
//  Created by BlueBerry on 2018/8/22.
//  Copyright © 2018年 蓝莓. All rights reserved.
//

#import "DisplayLinkTimerView.h"

@implementation DisplayLinkTimerView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
//        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeY) userInfo:nil repeats:YES];
        
        //CADisplayLink工作要添加到主循环中
        //每次屏幕刷新的时候就会调用指定方法（屏幕每秒刷新60次）
        //因为跟随屏幕熟悉所以更顺畅
        CADisplayLink *dl=[CADisplayLink displayLinkWithTarget:self selector:@selector(changeY)];
        [dl addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}
static int _cy=0;

-(void)changeY
{
    _cy+=10;
    if (_cy>[UIScreen mainScreen].bounds.size.height) {
        _cy=0;
    }
    //重绘
    [self setNeedsDisplay];//会自动调用drawRect方法，并不是马上调用，当下一次屏幕刷新的时候调用
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIImage *img=[UIImage imageNamed:@"第1名"];
    [img drawAtPoint:CGPointMake(0, _cy)];
}


@end
