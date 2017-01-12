//
//  LeeCATransaction6.m
//  LeeAnimation
//
//  Created by LiYang on 17/1/1.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "LeeCATransaction6.h"

@interface LeeCATransaction6 ()
@property (nonatomic,strong)CALayer * blueView;

@property (nonatomic,strong)CALayer * redView;

@property (nonatomic,strong)UIView  * purpleView;
@end

@implementation LeeCATransaction6

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = NSStringFromClass([self class]);
    self.blueView = [CALayer new];
    self.redView  = [CALayer new];
    self.purpleView = [UIView new];
    
    
    self.blueView.backgroundColor = [UIColor blueColor].CGColor;
    self.redView.backgroundColor  = [UIColor redColor].CGColor;
    self.purpleView.backgroundColor = [UIColor purpleColor];
    
    
    self.blueView.frame = CGRectMake(100, 100, 200, 200);
    self.redView.frame  = CGRectMake(100, 360, 100, 100);
    self.purpleView.frame = CGRectMake(200, 360, 100, 100);
    
    [self.view addSubview:self.purpleView];
    [self.view.layer addSublayer:self.redView];
    [self.view.layer addSublayer:self.blueView];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     
    [self transaction];
    
}

//　最后讲一下事务，在核心动画里面存在事务（CATransaction）这样一个概念，它负责协调多个动画原子更新显示操作。
//　　简单来说事务是核心动画里面的一个基本的单元，动画的产生必然伴随着layer的Animatable属性的变化，而layer属性的变化必须属于某一个事务。
//　　因此，核心动画依赖事务。
//
//　　事务的作用：保证一个或多个layer的一个或多个属性变化同时进行
//　　事务分为隐式和显式：
//　　1.隐式：没有明显调用事务的方法，由系统自动生成事务。比如直接设置一个layer的position属性，则会在当前线程自动生成一个事务，并在下一个runLoop中自动commit事务。
//　　2.显式：明显调用事务的方法（[CATransaction begin]和[CATransaction commit]）。
//
//　　CA事务的可设置属性（会覆盖隐式动画的设置）：

//animationDuration：动画时间
//animationTimingFunction：动画时间曲线
//disableActions：是否关闭动画
//completionBlock：动画执行完毕的回调
-(void)transaction{

    [CATransaction begin];
    [CATransaction setAnimationDuration:2.0];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [CATransaction setDisableActions:NO]; //设置为YES就关闭动画
    [CATransaction setCompletionBlock:^{
    
        NSLog(@"fjdlhglsgld");
        
    }];
    
    self.redView.bounds = self.blueView.bounds;
    [CATransaction commit];
}
//注意：只有非root layer才有隐式动画，如果你是直接设置self.cartCenter.layer.bounds = self.centerShow.layer.bounds;是不会有动画效果的。

@end
