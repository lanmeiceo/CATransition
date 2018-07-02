//
//  ViewController.m
//  动画
//
//  Created by BlueBerry on 2018/7/2.
//  Copyright © 2018年 蓝莓. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic ,strong) UIImageView *imageView;
@property (nonatomic, copy) NSArray *images;
@end

@implementation ViewController


//显示动画
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ///
    self.imageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 30)];
    self.imageView.center=self.view.center;
    self.images = @[[UIImage imageNamed:@"第1名"],
                    [UIImage imageNamed:@"第2名"],
                    [UIImage imageNamed:@"第3名"],
                    [UIImage imageNamed:@"第4名"]];
    [self.view addSubview:self.imageView];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
