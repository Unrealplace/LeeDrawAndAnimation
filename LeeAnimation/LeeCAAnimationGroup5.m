//
//  LeeCAAnimationGroup5.m
//  LeeAnimation
//
//  Created by LiYang on 17/1/1.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "LeeCAAnimationGroup5.h"

@interface LeeCAAnimationGroup5 ()
@property (nonatomic,strong)UIView * blueView;

@property (nonatomic,strong)UIView * redView;

@property (nonatomic,strong)UIView  * purpleView;
@end

@implementation LeeCAAnimationGroup5

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = NSStringFromClass([self class]);
    self.blueView = [UIView new];
    self.redView  = [UIView new];
    self.purpleView = [UIView new];
    
    
    self.blueView.backgroundColor = [UIColor blueColor];
    self.redView.backgroundColor  = [UIColor redColor];
    self.purpleView.backgroundColor = [UIColor purpleColor];
    
    
    self.blueView.frame = CGRectMake(100, 100, 200, 200);
    self.redView.frame  = CGRectMake(100, 360, 100, 100);
    self.purpleView.frame = CGRectMake(200, 360, 100, 100);
    
    [self.view addSubview:self.purpleView];
    [self.view addSubview:self.redView];
    [self.view addSubview:self.blueView];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self animationGroup];
    
    
}

//　使用Group可以将多个动画合并一起加入到层中，Group中所有动画并发执行，可以方便地实现需要多种类型动画的场景。
//
//　　以实现视图的position、bounds和opacity改变的组合动画为例
-(void)animationGroup{
    
    CABasicAnimation * posAni = [CABasicAnimation animationWithKeyPath:@"position"];
    posAni.toValue = [NSValue valueWithCGPoint:self.blueView.center];
    
    CABasicAnimation * opcAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opcAni.toValue = [NSNumber numberWithFloat:1.0];
    opcAni.toValue = [NSNumber numberWithFloat:0.3];
    
    CABasicAnimation * bodAni = [CABasicAnimation animationWithKeyPath:@"bounds"];
    bodAni.toValue = [NSValue valueWithCGRect:self.blueView.bounds];
    
    CASpringAnimation * spring = [CASpringAnimation animationWithKeyPath:@"position.y"];
    spring.fromValue = @(self.redView.layer.position.y);
    spring.toValue  = @(self.blueView.layer.position.y);
    spring.mass = 1.0f;
    spring.stiffness = 10;
    spring.initialVelocity = 0;
    spring.damping = 10;
    spring.duration = spring.settlingDuration;
    
    CAAnimationGroup * groupAni = [CAAnimationGroup animation];
    groupAni.animations = @[posAni, opcAni, bodAni,spring];
    groupAni.duration = 1.0;
    groupAni.fillMode = kCAFillModeForwards;
    groupAni.removedOnCompletion = NO;
    groupAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.redView.layer addAnimation:groupAni forKey:@"groupAni"];
    [self.view bringSubviewToFront:self.redView];
    
    
}

@end
