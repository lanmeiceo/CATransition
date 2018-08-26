//
//  MusicLabelView.m
//  动画
//
//  Created by BlueBerry on 2018/8/26.
//  Copyright © 2018年 蓝莓. All rights reserved.
//

#import "MusicLabelView.h"

@implementation MusicLabelView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self creatSubView];
    }
    return self;
    
}
-(void)creatSubView
{
    CAReplicatorLayer *relayer=[CAReplicatorLayer layer];
    relayer.frame=self.bounds;
    [self.layer addSublayer:relayer];
    
    relayer.instanceCount=5;
    relayer.instanceTransform=CATransform3DMakeTranslation(45, 0, 0);
    relayer.instanceDelay=1;//复制出来的子层动画延时执行
    
    //创建震动条
    CALayer *layer=[CALayer layer];
    layer.backgroundColor=[UIColor redColor].CGColor;
    layer.bounds=CGRectMake(0, 0, 30, 100);
    //让它往底部缩放
    layer.anchorPoint=CGPointMake(0, 1);
    layer.position=CGPointMake(0, self.bounds.size.height);
    [relayer addSublayer:layer];
    
    //添加动画
    CABasicAnimation *ani=[CABasicAnimation animation];
    ani.keyPath=@"transform.scale.y";
    ani.toValue=@0;
    ani.repeatCount=MAXFLOAT;
    ani.duration=1;
    ani.autoreverses=YES;
    [layer addAnimation:ani forKey:nil];
}
@end
