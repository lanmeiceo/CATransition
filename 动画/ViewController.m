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
#import "DisplayLinkTimerView.h"
#import "MusicLabelView.h"
@interface ViewController ()<CAAnimationDelegate>
@property(nonatomic ,strong) UIImageView *imageView;
@property (nonatomic, copy) NSArray *images;
@property(nonatomic ,strong)CALayer *shipLayer;
@property (nonatomic, strong) CALayer *colorLayer;
@property (nonatomic, strong) UIView *colorView;

@property (nonatomic, strong) UIImageView *ballView;
@property(strong,nonatomic)UISlider *slider;
@property(strong,nonatomic)ProgressView *progressView;
@property (nonatomic, strong) UILabel *numL;
@property (nonatomic, assign) NSInteger num,i;
@property (nonatomic, strong) UILabel *tipLable;
@end

@implementation ViewController
#define AngleFromNumber(num) ((num)/180.0*M_PI)
#define HOME_SCREEN_SIZE         [UIScreen mainScreen].bounds.size
#define HOME_SCREEN_WIDTH        HOME_SCREEN_SIZE.width
#define HOME_SCREEN_HEIGHT       HOME_SCREEN_SIZE.height
/*
 UIView动画与核心动画区别
 1.核心动画只作用在layer
 2.核心动画看到的都是假象，它并没有修改UIView的真实位置
 
 使用核心动画的情况
 1.不需要用户交互时
 2.要根据路径做动画时
 3要做转场动画时
 */
//UIView动画只是Core Animation动画的UIKit层封装，都是CAAnimation对象完成的
/**
 核心动画中所有类都遵守CAMediaTiming。
 CAAnaimation是个抽象类，不具备动画效果，必须用它的子类（CAAnimationGroup和CATransition）才有动画效果。
 CAAnimationGroup（动画组），可以同时进行缩放，旋转。
 CATransition（转场动画），界面之间跳转都可以用转场动画。用于做转场动画，能够为层提供移出屏幕和移入屏幕的动画效果。iOS比Mac OS X的转场动画效果少一点.UINavigationController就是通过CATransition实现了将控制器的视图推入屏幕的动画效果
 
 使用UIView动画函数实现转场动画
 单视图
 + (void)transitionWithView:(UIView *)view ...
 双视图
 + (void)transitionFromView:(UIView *)fromView...
 
 CAPropertyAnimation也是个抽象类，本身不具备动画效果，只有子类（CABasicAnimation和CAKeyframeAnimation）才有动画效果。
 CABasicAnimation（基础动画），做一些简单效果。
 CAKeyframeAnimation（帧动画），做一些连续的流畅的动画。
 */



//显示动画
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.imageView= [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 200, 400)];
//      self.imageView.center=self.view.center;
//      [self.view addSubview:self.imageView];
    
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

    //画文字图片
//        DrawLabelImageView *drawV=[[DrawLabelImageView alloc]initWithFrame:CGRectMake(50, 50,  self.view.frame.size.width-100,  self.view.frame.size.width-100)];
//        drawV.backgroundColor=[UIColor grayColor];
//
//        [self.view addSubview:drawV];
    
    //定时器（DisplayLink更顺畅）
//    DisplayLinkTimerView *view=[[DisplayLinkTimerView alloc]initWithFrame:self.view.bounds];
//    [self.view addSubview:view];
    
    //调用traiAni时打开注释
//    self.imageView= [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 200, 400)];
//    self.imageView.center=self.view.center;
//    [self.view addSubview:self.imageView];
    
    //音乐条
//    MusicLabelView *view=[[MusicLabelView alloc]initWithFrame:CGRectMake(50, 50, 300, 300)];
//    view.backgroundColor=[UIColor grayColor];
//    [self.view addSubview:view];

//    [self makeTransform];
    

//     _num = 10;
//    self.numL = ({
//              UILabel *numL = [[UILabel alloc]init];
//        numL.text = [NSString stringWithFormat:@"%ld",(long)_num];
//        [self.view addSubview:numL];
//        numL.frame = CGRectMake( 100, 100, 30, 20);
//              numL;
//          });
    [self creatImgView];

    self.ballView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"第1名"]];
    self.ballView.frame = CGRectMake(200, 200, 50, 50);
    [self.view addSubview:self.ballView];
  
}

//https://www.renfei.org/blog/ios-8-spring-animation.html
/**
 usingSpringWithDamping的范围为0.0f到1.0f，数值越小「弹簧」的振动效果越明显。
 initialSpringVelocity则表示初始的速度，数值越大一开始移动越快.值得注意的是，初始速度取值较高而时间较短时，也会出现反弹情况。
 */
//礼物数字
- (void)giftNum {
    _num ++;
    self.numL.text = [NSString stringWithFormat:@"%ld",(long)_num];
    self.numL.transform = CGAffineTransformMakeScale(2, 2);
    [UIView animateWithDuration:0.7 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:0.3 options:0 animations:^{
        self.numL.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
         
    }];
}

- (void)giftPic {
    
    self.ballView.transform = CGAffineTransformMakeScale(2, 2);
    [UIView animateWithDuration:0.7 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:0.3 options:0 animations:^{
        self.ballView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
         
    }];
}

//放大过程中出现的缓慢动画
- (void) shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.2;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
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
//    [self traiAni];
//    [self AniGroup];
//    [self makeTransform];
//    [self KeyframeAnimationANDCAMediaTimingFunction];
//    [self viewTiming];
    
//    [self shakeToShow:_colorView];
    
//    [self giftNum];
//    [self rotationAni];
//    [self baseAnimation];
//    [self basic];
//    [self CAMediaTimingFunction];

//    [self beziePatchAnimation];
//    [self giftPic];
//    [self grupAnimation];
    //转场
//    [self transitionAnimation];
    //
//    [self loop];
//    [self shaperLayerAnimations];
    [self twoblock];
}

-(void)creatImgView
{
        self.imageView= [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 80, 80)];
//    self.imageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, HOME_SCREEN_HEIGHT, HOME_SCREEN_WIDTH, 300)];

//        self.imageView.center=self.view.center;
//    self.imageView.backgroundColor=[UIColor blackColor];
        self.imageView.image=[UIImage imageNamed:@"666"];
        [self.view addSubview:self.imageView];
  

}

- (void)creatLabel {
    self.tipLable = [[UILabel alloc]initWithFrame:CGRectMake(-200, 100, 200, 20)];
    self.tipLable.text = @"欢迎进入直播间";
    [self.view addSubview:self.tipLable];
    
}

#pragma mark 动画组
- (void)grupAnimation{
    //动画组可以执行一组动画
    //创建一个动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];

    //平移
    CABasicAnimation *anim = [CABasicAnimation animation];

    anim.keyPath = @"position.y";
    anim.toValue = @400;

    //缩放

    CABasicAnimation *scaleAnim = [CABasicAnimation animation];
    scaleAnim.keyPath = @"transform.scale";
    scaleAnim.toValue = @2.0;

    //设置动画组属性
    group.animations = @[anim,scaleAnim];

    //    group.duration = 1;
    //    group.repeatCount = MAXFLOAT;
    //    group.autoreverses = YES;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    //添加动画
    [self.imageView.layer addAnimation:group forKey:nil];
    /**
      使用动画组的好处,不需要每次都去添加动画,设置动画完成时的属性.
      只需要把要执行的动画,添加到动画组的animations数组当中即可,
      最后把组动画添加到层上面,就会自动执行数组当中的动画.
      动画完成时设置的属性也只需要设置一次.
     */
}
#pragma mark 转场动画
- (void)transitionAnimation{
    //转场动画
    //什么是转场动画？
    //就是从一个场景转换到另外一个场景，像导航控制器的push效果，就是一个转场

    //创建一个转场动画
    CATransition * anim = [CATransition animation];
    //设置转场类型
    anim.type = @"cube";
    anim.duration = 1;
    //设置转场的方向
    anim.subtype = kCATransitionFromLeft;
    //设置动画开始的位置
    //anim.startProgress = 0.5;
    //设置动画结束的位置
    //anim.endProgress = 0.8;
    //添加动画
    [self.imageView.layer addAnimation:anim forKey:nil];
    
    _i += 1;
    if (_i > 3) {
        _i = 1;
    }
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",(long)_i]];

    //使用uiview进行转场动画
    [UIView transitionWithView:self.imageView duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
  
        self->_i += 1;
        if (self->_i > 3) {
            self->_i = 1;
     }
        self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",self->_i]];
  
} completion:nil];
}

//转圈
- (void)loop {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
      //     设置动画属性
      anim.keyPath = @"position";
      //设置path************************
      UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(60, 60, 100, 100)];
      anim.path = path.CGPath;
      anim.duration = 0.25;
      // 取消反弹
      anim.removedOnCompletion = NO;
      anim.fillMode = kCAFillModeForwards;
      anim.repeatCount = MAXFLOAT;
      [self.imageView.layer addAnimation:anim forKey:nil];
}

-(void)shaperLayerAnimations{
//图形开始位置的动画
CABasicAnimation *startAnim = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
startAnim.duration = 5;
startAnim.fromValue = @(0);
startAnim.toValue = @(0.6);
    
//图形结束位置的动画
CABasicAnimation *endAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
endAnim.duration = 5;
endAnim.fromValue = @(0.4);
endAnim.toValue = @(1);
    
//把两个动画合并，绘制的区域就会不断变动
CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
group.animations = @[startAnim, endAnim];
group.duration = 5;
group.autoreverses = YES;
    
CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
shapeLayer.frame = self.view.bounds;
   
//图形是一大一小两个圆相切嵌套
UIBezierPath *path = [[UIBezierPath alloc] init];
[path addArcWithCenter:CGPointMake(100, 300) radius:100 startAngle:0 endAngle:M_PI*2 clockwise:YES];
[path addArcWithCenter:CGPointMake(150, 300) radius:50 startAngle:0 endAngle:M_PI*2 clockwise:YES];
shapeLayer.path = [path CGPath];
shapeLayer.strokeColor = [UIColor redColor].CGColor;
shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    
[shapeLayer addAnimation:group forKey:@"runningLine"];
[self.view.layer addSublayer:shapeLayer];
}
//Nesting Animation Blocks-嵌套动画块
/**
 您可以通过嵌套其他动画块，为动画块的某些部分分配不同的时序和配置选项。 顾名思义，嵌套动画块是在现有动画块内创建新的动画块。 嵌套动画与任何父动画同时启动，但运行（大多数情况下）具有自己的配置选项。 默认情况下，嵌套动画会继承父级的持续时间和动画曲线，如果需要重新设置，只需要在嵌套动画块中使用UIViewAnimationOptionOverrideInheritedCurve和UIViewAnimationOptionOverrideInheritedDuration键，这两个值允许为第二个动画设置自己的动画曲线和持续时间值。

 */
/**
 alpha是不透明度，属性为浮点类型的值，取值范围从0到1.0，表示从完全透明到完全不透明，其特性有当前UIView的alpha值会被其所有subview继承。alpha值会影响到UIView跟其所有subview，alpha具有动画效果。当alpha为0时，跟hidden为YES时效果一样，但是alpha主要用于实现隐藏的动画效果，在动画块中将hidden设置为YES没有动画效果。
 
 设置backgroundColor的alpha值只影响当前UIView的背景，并不会影响其所有subview。Clear Color就是backgroundColor的alpha为1.0。alpha值会影响backgroundColor最终的alpha,假设UIView的alpha为0.8，backgroundColor的alpha为0.5，那么backgroundColor最终的alpha为0.4(0.8*0.5)。

这里如果把alpha = 0.0改为hidden = YES  无动画效果
 */
- (void)twoblock {
    [UIView animateWithDuration:1.0
    delay: 1.0
    options:UIViewAnimationOptionCurveEaseOut
    animations:^{
        self.imageView.alpha = 0.0;
        // Create a nested animation that has a different
        // duration, timing curve, and configuration.
        [UIView animateWithDuration:0.2
             delay:0.0
             options: UIViewAnimationOptionOverrideInheritedCurve |
                      UIViewAnimationOptionCurveLinear |
                      UIViewAnimationOptionOverrideInheritedDuration |
                      UIViewAnimationOptionRepeat |
                      UIViewAnimationOptionAutoreverse
             animations:^{
                  [UIView setAnimationRepeatCount:2.5];
                  self.ballView.alpha = 0.0;

             }
             completion:nil];

    }
    completion:nil];
}
#pragma mark - 各种动画
//动画组
-(void)AniGroup
{
    [self creatImgView];
    CABasicAnimation *ani = [CABasicAnimation animation];
    ani.keyPath = @"transform.scale";
    ani.toValue = @0.5;
    
    CABasicAnimation *ani2 = [CABasicAnimation animation];
    ani2.keyPath = @"position.y";
    ani2.toValue = @130;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[ani,ani2];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [self.imageView.layer addAnimation:group forKey:nil];

}
//转场动画
static int i=0;
-(void)traiAni
{
    /*
     //注释代码写在写在viewdidiload
     self.imageView= [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 200, 400)];
     self.imageView.center=self.view.center;
     [self.view addSubview:self.imageView];
     */
    //方法在touchbegan调用
    i++;
    if (i==5) {
        i=1;
    }
    self.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
    
    CATransition *tra = [CATransition animation];
    tra.duration = 3;

    tra.type = @"pageCurl";//翻页效果（上翻） 下翻是pageUnCurl
    //动画起始结束位置
    tra.startProgress=0.5;
    tra.endProgress=0.3;
 /*
  fade 交叉淡化过渡
  push 新视图把旧视图推送出去
  moveIn 新视图移到旧视图上面
  cube 立体翻滚
  reveal 旧视图移开，显示下面的新视图
  oglFlip 上下左右翻转效果
  suckEffect 收缩效果，如一块布被抽走
  rippleEffect 水滴效果
  pageCurl 翻页效果（上翻）
  pageUnCurl 下翻
  cameraTrisHollowOpen 相机镜头打开效果
  cameraTrisHollowClose 相机镜头关闭效果


  */
    [self.imageView.layer addAnimation:tra forKey:nil];
    
    
    //这里也可以用
  /*  [UIView transitionWithView:self.imageView duration:2.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        i++;
        if (i==5) {
            i=1;
        }
        self.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
    } completion:^(BOOL finished) {
        
    }];
   */
}
//-----CAKeyframeAnimation动画---
//类似iPhone APP删除时icon抖动效果
//1.指定values
-(void)rotationAni
{

//    [self creatImgView];
     //CAKeyframeAnimation可以设置多个值
    CAKeyframeAnimation *ani=[CAKeyframeAnimation animation];
    //属性值
    ani.keyPath=@"transform.rotation";
    ani.values=@[@(AngleFromNumber(-5)),@(AngleFromNumber(5))];
    //执行次数
    ani.repeatCount=MAXFLOAT;//这里等价于    ani.values=@[@(AngleFromNumber(-5)),@(AngleFromNumber(5)),@(AngleFromNumber(-5))];
   //执行时间（可以控制动画的快慢）
    ani.duration= 1;
    
    //执行完后自动返回
    ani.autoreverses=YES;
    [self.imageView.layer addAnimation:ani forKey:nil];
}
//2.指定path
-(void)keyFrameAniWithPath
{
    [self creatImgView];
    CAKeyframeAnimation *ani=[CAKeyframeAnimation animation];
   
    ani.keyPath=@"position";
    
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 50)];
    [path addLineToPoint:CGPointMake(200, 100)];
    [path addLineToPoint:CGPointMake(250, 130)];
    ani.path=path.CGPath;
    ani.duration=2.0;
    [self.imageView.layer addAnimation:ani forKey:nil];
    

}
//-------------
//平移
-(void)makeTransform
{
   
    [self creatLabel];
    self.tipLable.alpha = 1;

//    [UIView animateWithDuration:1.0f delay:0.3 usingSpringWithDamping:1.0 initialSpringVelocity:1.0 options:0 animations:^{
//        self.tipLable.transform = CGAffineTransformMakeTranslation(300, 0);
//    } completion:^(BOOL finished) {
//        self.tipLable.alpha = 0;
//    }];
    
    
    [UIView animateWithDuration:1.0f animations:^{
        //可以通过按钮点击比较两个效果
        //使用make,是相对于最原始的位置做的改变
        //把这个也打开试试
        self.tipLable.transform = CGAffineTransformMakeTranslation(200, 0);
        //相对于上一次做改变
//        self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, 0, 200);
    }];
}
//旋转
-(void)makeRotaion
{
    [self creatImgView];

    [UIView animateWithDuration:2 animations:^{
    self.imageView.transform=CGAffineTransformMakeRotation(M_PI_4);
    self.imageView.transform=CGAffineTransformRotate(self.imageView.transform, M_PI_4);
    }];
}

//缩放
-(void)makeScale
{
    [self creatImgView];

    [UIView animateWithDuration:2 animations:^{
        self.imageView.transform=CGAffineTransformMakeScale(0.8, 0.8);
        self.imageView.transform=CGAffineTransformScale(self.imageView.transform, 0.8, 0.8);
    }];
}



//每个方法都是一个动画demo
//
-(void)baseAnimation
{
    UIView *redV=[[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    redV.backgroundColor=[UIColor redColor];
    [self.view addSubview:redV];
    //设置动画对象（layer的属性）
    CABasicAnimation *ani=[CABasicAnimation animation];
    //设置属性值
    ani.keyPath=@"position.x";
    ani.toValue=@300;
    //动画完成会自动删除动画

    //两个同时设置可不返回
    [ani setRemovedOnCompletion:NO];
    ani.fillMode=kCAFillModeForwards;
    [redV.layer addAnimation:ani forKey:nil];
    
}
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
    //效果是手指点到哪儿colorLayer跟着移动
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
//    self.colorLayer.position = [[touches anyObject] locationInView:self.view];
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
    //+ timing function
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    //CAKeyframeAnimation有一个NSArray类型的timingFunctions属性，我们可以用它来对每次动画的步骤指定不同的计时函数。但是指定函数的个数一定要等于keyframecas数组的元素个数减一，因为它是描述每一帧之间动画速度的函数。
    animation.timingFunctions = @[fn, fn, fn];
    //应用 animation 到 layer
    [self.colorLayer addAnimation:animation forKey:nil];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
