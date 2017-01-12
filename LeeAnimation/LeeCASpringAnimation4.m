//
//  LeeCASpringAnimation4.m
//  LeeAnimation
//
//  Created by LiYang on 17/1/1.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "LeeCASpringAnimation4.h"

@interface LeeCASpringAnimation4 ()
@property (nonatomic,strong)UIView * blueView;

@property (nonatomic,strong)UIView * redView;

@property (nonatomic,strong)UIView  * purpleView;
@end

@implementation LeeCASpringAnimation4

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

    [self springAnimation];
    [self springAnimationY];
    
}


//CASpringAnimation是iOS9新加入动画类型，是CABasicAnimation的子类，用于实现弹簧动画。
//　　CASpringAnimation的重要属性：
//　　mass：质量（影响弹簧的惯性，质量越大，弹簧惯性越大，运动的幅度越大）
//　　stiffness：弹性系数（弹性系数越大，弹簧的运动越快）
//　　damping：阻尼系数（阻尼系数越大，弹簧的停止越快）
//　　initialVelocity：初始速率（弹簧动画的初始速度大小，弹簧运动的初始方向与初始速率的正负一致，若初始速率为0，表示忽略该属性）
//　　settlingDuration：结算时间（根据动画参数估算弹簧开始运动到停止的时间，动画设置的时间最好根据此时间来设置）
//　　CASpringAnimation和UIView的SpringAnimation对比：
//
//　　1.CASpringAnimation 可以设置更多影响弹簧动画效果的属性，可以实现更复杂的弹簧动画效果，且可以和其他动画组合。
//　　2.UIView的SpringAnimation实际上就是通过CASpringAnimation来实现。
//

-(void)springAnimation{

    CASpringAnimation * ani = [CASpringAnimation animationWithKeyPath:@"bounds"];
    ani.mass = 10.0; //质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
    ani.stiffness = 1000; //刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快
    ani.damping = 10.0;//阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
    ani.initialVelocity = 5.f;//初始速率，动画视图的初始速度大小;速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
    ani.duration = ani.settlingDuration;
    ani.fromValue = [NSValue valueWithCGRect:CGRectMake(self.redView.bounds.origin.x, self.redView.bounds.origin.y, 80, 80)];
    
    ani.toValue = [NSValue valueWithCGRect:self.redView.bounds];
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.autoreverses = YES;
    ani.repeatCount = HUGE;
    
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.redView.layer addAnimation:ani forKey:@"boundsAni"];
}

-(void)springAnimationY{
    
    CASpringAnimation * ani = [CASpringAnimation animationWithKeyPath:@"position.y"];
    ani.mass = 1; //质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
    ani.stiffness = 2000; //刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快
    ani.damping = 10.0;//阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
    ani.initialVelocity = 0;//初始速率，动画视图的初始速度大小;速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
    ani.duration = ani.settlingDuration;
    ani.fromValue = @(self.purpleView.layer.position.y);
    
    
    ani.toValue = @(self.purpleView.layer.position.y+100);
    
    ani.removedOnCompletion = YES;
    ani.fillMode = kCAFillModeForwards;
//    ani.autoreverses = YES;
//    ani.repeatCount = HUGE;
    
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.purpleView.layer addAnimation:ani forKey:@"positionxx"];
}

 
@end
