//
//  ViewController.m
//  动画
//
//  Created by BlueBerry on 2018/7/2.
//  Copyright © 2018年 蓝莓. All rights reserved.
//

#import "ViewController.h"
#import "RedView.h"
#import "DrawView.h"
#import "ProgressView.h"
#import "DrawLabelImageView.h"
@interface ViewController ()<CAAnimationDelegate>
@property(nonatomic ,strong) UIImageView *imageView;
@property (nonatomic, copy) NSArray *images;
@property(nonatomic ,strong)CALayer *shipLayer;
@property (nonatomic, strong) CALayer *colorLayer;
@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, strong) UIImageView *ballView;
@property(strong,nonatomic)UISlider *slider;
@property(strong,nonatomic)ProgressView *progressView;
@end

@implementation ViewController


//显示动画
- (void)viewDidLoad {
    [super viewDidLoad];
 
    //每个view对应一个demo，而本类中每个方法(部分方法除外)对应一个demo
    //任意拖拽view
//    RedView *redView=[[RedView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    redView.backgroundColor=[UIColor redColor];
//    [self.view addSubview:redView];
    
    //上下文
//    DrawView *drawV=[[DrawView alloc]initWithFrame:self.view.bounds];
//    drawV.backgroundColor=[UIColor whiteColor];
//
//    [self.view addSubview:drawV];
    
    //进度条结合动画,未达到预期效果
//     self.progressView=[[ProgressView alloc]initWithFrame:CGRectMake(50, 50,  self.view.frame.size.width-100,  self.view.frame.size.width-100)];
//    self.progressView.backgroundColor=[UIColor redColor];
//    [self.view addSubview:self.progressView];
//    [self.view addSubview:self.slider];

        DrawLabelImageView *drawV=[[DrawLabelImageView alloc]initWithFrame:CGRectMake(50, 50,  self.view.frame.size.width-100,  self.view.frame.size.width-100)];
        drawV.backgroundColor=[UIColor grayColor];
    
        [self.view addSubview:drawV];
    
}
//-----progressview----

-(UISlider *)slider
{
    if (!_slider) {
        _slider=[[UISlider alloc]initWithFrame:CGRectMake(0, 500, self.view.frame.size.width, 10)];
        _slider.minimumValue=0.0;
        _slider.maximumValue=100.0;
        [_slider addTarget:self action:@selector(sliderMethod:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _slider;
}
-(void)sliderMethod:(UISlider*)slider
{
    NSLog(@"%.2f",slider.value);
    self.progressView.progressValue=slider.value;
}
//----
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //通过调用不同的方法来查看各个动画效果
//    [self animationGroup];
    //configure the transaction

}

//平移
-(void)makeTransform
{
    self.imageView= [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 20, 30)];
    self.imageView.center=self.view.center;
    self.imageView.image=[UIImage imageNamed:@"第1名"];
    [self.view addSubview:self.imageView];
    [UIView animateWithDuration:2 animations:^{
        //可以通过按钮点击比较两个效果
        //使用make,是相对于最原始的位置做的改变
//        self.imageView.transform=CGAffineTransformMakeTranslation(0, 100);
        //相对于上一次做改变
        self.imageView.transform=CGAffineTransformTranslate(self.imageView.transform, 0, 100);
    }];
}
//旋转
-(void)makeRotaion
{
    self.imageView= [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 20, 30)];
    self.imageView.center=self.view.center;
    self.imageView.image=[UIImage imageNamed:@"第1名"];
    [self.view addSubview:self.imageView];
    [UIView animateWithDuration:2 animations:^{
    self.imageView.transform=CGAffineTransformMakeRotation(M_PI_4);
    self.imageView.transform=CGAffineTransformRotate(self.imageView.transform, M_PI_4);
    }];
}

//缩放
-(void)makeScale
{
    self.imageView= [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 20, 30)];
    self.imageView.center=self.view.center;
    self.imageView.image=[UIImage imageNamed:@"第1名"];
    [self.view addSubview:self.imageView];
    [UIView animateWithDuration:2 animations:^{
        self.imageView.transform=CGAffineTransformMakeScale(0.8, 0.8);
        self.imageView.transform=CGAffineTransformScale(self.imageView.transform, 0.8, 0.8);
    }];
}



//每个方法都是一个动画demo
//
-(void)trasition

{  //
    self.imageView= [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 20, 30)];
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


//贝塞尔曲线的动画
-(void)beziePatchAnimation
{
    //创建BezierPat
    UIBezierPath *bezierPath=[[UIBezierPath alloc]init];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    
    //draw the path using a CAShapeLayer
    
    CAShapeLayer *pathLayer=[CAShapeLayer layer];
    pathLayer.path=bezierPath.CGPath;
    pathLayer.fillColor=[UIColor clearColor].CGColor;
    pathLayer.strokeColor=[UIColor redColor].CGColor;
    pathLayer.lineWidth=3.0f;
    [self.view.layer addSublayer:pathLayer];
    
    //add the ship
    CALayer *shipLayer=[CALayer layer];
    shipLayer.frame=CGRectMake(0, 0, 20, 30);
    shipLayer.position=CGPointMake(0, 150);
    shipLayer.contents=(__bridge id)[UIImage imageNamed:@"第1名"].CGImage;
    [self.view.layer addSublayer:shipLayer];
    
    //create the keyframe animation
    
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animation];
    animation.keyPath=@"position";
    animation.duration=4.0;
    
    animation.rotationMode=kCAAnimationRotateAuto;//指向曲线切线的方向,图层将会根据曲线的切线自动旋转
    animation.path=bezierPath.CGPath;
    [shipLayer addAnimation:animation forKey:nil];
    
    
    
    
}

-(void)basic
{
    //add the ship
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 128, 128);
    shipLayer.position = CGPointMake(150, 150);
    shipLayer.contents = (__bridge id)[UIImage imageNamed: @"第1名"].CGImage;
    [self.view.layer addSublayer:shipLayer];
    //animate the ship rotation
    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"transform";
     animation.keyPath = @"transform.rotation";//和下面的同时改
    animation.duration = 2.0;
//    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0, 0, 1)];
    animation.byValue = @(M_PI * 2);

    [shipLayer addAnimation:animation forKey:nil];
   
    /*
    用transform.rotation而不是transform做动画的好处如下：
     我们可以不通过关键帧一步旋转多于180度的动画。
     可以用相对值而不是绝对值旋转（设置byValue而不是toValue）。
     可以不用创建CATransform3D，而是使用一个简单的数值来指定角度。
     不会和transform.position或者transform.scale冲突（同样是使用关键路径来做独立的动画属性）。
     */
}


//动画组：CABasicAnimation和CAKeyframeAnimation仅仅作用于单独的属性，而CAAnimationGroup可以把这些动画组合在一起。CAAnimationGroup是另一个继承于CAAnimation的子类，它添加了一个animations数组的属性，用来组合别的动画。
-(void)animationGroup
{
    //create a path
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;//注释掉这句即可知道效果
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];
    //add a colored layer
    CALayer *colorLayer = [CALayer layer];
    colorLayer.frame = CGRectMake(0, 0, 64, 64);
    colorLayer.position = CGPointMake(0, 150);
    colorLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:colorLayer];
    //create the position animation
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"position";
    animation1.path = bezierPath.CGPath;
    animation1.rotationMode = kCAAnimationRotateAuto;
    //create the color animation
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"backgroundColor";
    animation2.toValue = (__bridge id)[UIColor redColor].CGColor;
    //create group animation
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation1, animation2];
    groupAnimation.duration = 4.0;
    //add the animation to the color layer
    [colorLayer addAnimation:groupAnimation forKey:nil];
}

//动画速度
-(void)CAMediaTimingFunction
{
    //写在view DidLoad里
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.position = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height/2.0);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
    
    
    //写在touchbegin里
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    /*
     kCAMediaTimingFunctionLinear  线性的计时函数
     kCAMediaTimingFunctionEaseIn 慢慢加速然后突然停止
     kCAMediaTimingFunctionEaseOut 全速开始，然后慢慢减速停止
     kCAMediaTimingFunctionEaseInEaseOut 慢加速然后再慢慢减速的过程
     kCAMediaTimingFunctionDefault
     */
    //set the position
    //运行打开注释
 //   self.colorLayer.position = [[touches anyObject] locationInView:self.view];
    //commit transaction
    [CATransaction commit];
}

//UIView的动画缓冲

-(void)viewTiming
{    //写在view DidLoad里

    self.colorView = [[UIView alloc] init];
    self.colorView.bounds = CGRectMake(0, 0, 100, 100);
    self.colorView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    self.colorView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.colorView];
    
    //写在touchbegin里
    [UIView animateWithDuration:1.0 delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         //set the position
                         //运行打开注释

                       //  self.colorView.center = [[touches anyObject] locationInView:self.view];
                     }
                     completion:NULL];
}

//缓冲和关键帧动画
//对CAKeyframeAnimation使用CAMediaTimingFunction
-(void)KeyframeAnimationANDCAMediaTimingFunction
{
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
    [self.view.layer addSublayer:self.colorLayer];
    
    //点击后
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[
                         (__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor ];
    //add timing function
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    //CAKeyframeAnimation有一个NSArray类型的timingFunctions属性，我们可以用它来对每次动画的步骤指定不同的计时函数。但是指定函数的个数一定要等于keyframes数组的元素个数减一，因为它是描述每一帧之间动画速度的函数。
    animation.timingFunctions = @[fn, fn, fn];
    //apply animation to layer
    [self.colorLayer addAnimation:animation forKey:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
