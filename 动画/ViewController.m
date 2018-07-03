//
//  ViewController.m
//  动画
//
//  Created by BlueBerry on 2018/7/2.
//  Copyright © 2018年 蓝莓. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>
@property(nonatomic ,strong) UIImageView *imageView;
@property (nonatomic, copy) NSArray *images;
@property(nonatomic ,strong)CALayer *shipLayer;
@end

@implementation ViewController


//显示动画
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ///
  

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self startOrStopAnimation];
    

}

//
-(void)trasition

{
    self.imageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 30)];
    self.imageView.center=self.view.center;
    self.images = @[[UIImage imageNamed:@"第1名"],
                    [UIImage imageNamed:@"第2名"],
                    [UIImage imageNamed:@"第3名"],
                    [UIImage imageNamed:@"第4名"]];
    [self.view addSubview:self.imageView];
    
        //过渡
        CATransition *trasition=[CATransition animation];
        trasition.type=kCATransitionFade;
        /*
        kCATransitionFade//平滑的淡入淡出效果
        kCATransitionMoveIn//从顶部滑动进入，但不像推送动画那样把老土层推走
        kCATransitionPush//创建了一个新的图层，从边缘的一侧滑动进来，把旧图层从另一侧推出去的效果
        kCATransitionReveal//把原始的图层滑动出去来显示新的外观，而不是把新的图层滑动进入
         */
        [self.imageView.layer addAnimation:trasition forKey:nil];
    
        UIImage *image=self.imageView.image;
    
        NSUInteger index=[self.images indexOfObject:image];
        NSLog(@"%ld",index);
        index=(index+1)%self.images.count;
    
    
        self.imageView.image=self.images[index];
}

//
-(void)transitionWithView
{
    self.imageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 30)];
    self.imageView.center=self.view.center;
    self.images = @[[UIImage imageNamed:@"第1名"],
                    [UIImage imageNamed:@"第2名"],
                    [UIImage imageNamed:@"第3名"],
                    [UIImage imageNamed:@"第4名"]];
    [self.view addSubview:self.imageView];
    
    [UIView transitionWithView:self.imageView duration:1.0
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        //cycle to next image
                        UIImage *currentImage = self.imageView.image;
                        NSUInteger index = [self.images indexOfObject:currentImage];
                        index = (index + 1) % [self.images count];
                        self.imageView.image = self.images[index];
                    }
                    completion:NULL];
}

//
-(void)performTransition
{
    //获取截屏
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *coverImg=UIGraphicsGetImageFromCurrentImageContext();
    
    UIView *coverImgV=[[UIImageView alloc]initWithImage:coverImg];
    coverImgV.frame=self.view.bounds;
    [self.view addSubview:coverImgV];
    
    CGFloat red=arc4random()/(CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
  
    [UIView animateWithDuration:1.0 animations:^{
        CGAffineTransform transform=CGAffineTransformMakeScale(0.1, 0.1);
        transform=CGAffineTransformRotate(transform, M_PI_2);
        coverImgV.transform=transform;
        coverImgV.alpha=0.0;
    } completion:^(BOOL finished) {
        [coverImgV removeFromSuperview];
    }];
    

}



//在动画过程中取消动画
-(void)startOrStopAnimation
{
    self.shipLayer=[CALayer layer];
    self.shipLayer.frame=CGRectMake(0, 0, 20, 30);
    self.shipLayer.position=CGPointMake(150, 150);
    self.shipLayer.contents=(__bridge id)[UIImage imageNamed:@"第1名"].CGImage;
    [self.view.layer addSublayer:self.shipLayer];
  

    UIButton *startBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-64, 100, 64)];
        startBtn.backgroundColor=[UIColor blueColor];
    [startBtn setTitle:@"start" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startM) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    UIButton *stopBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-100, self.view.frame.size.height-64, 100, 64)];
    stopBtn.backgroundColor=[UIColor blueColor];
    [stopBtn setTitle:@"stop" forState:UIControlStateNormal];
    [stopBtn addTarget:self action:@selector(stopM) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];

   
}
-(void)startM
{
    //开始
    CABasicAnimation *animation=[CABasicAnimation animation];
    animation.keyPath=@"transform.rotation";
    animation.duration=2.0;
    animation.byValue=@(M_PI*2);
    animation.delegate=self;
    [self.shipLayer addAnimation:animation forKey:@"rorateAni"];
}
-(void)stopM
{
    [self.shipLayer removeAnimationForKey:@"rorateAni"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //log that the animation stopped
    NSLog(@"The animation stopped (finished: %@)", flag? @"YES": @"NO");
}
////为了终止一个指定的动画，你可以用如下方法把它从图层移除掉：
//- (void)removeAnimationForKey:(NSString *)key;
////或者移除所有动画：
//- (void)removeAllAnimations;


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
