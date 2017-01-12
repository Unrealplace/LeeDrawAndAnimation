//
//  LeeCAKeyframeAnimation2.m
//  LeeAnimation
//
//  Created by LiYang on 16/12/31.
//  Copyright © 2016年 LiYang. All rights reserved.
//

#import "LeeCAKeyframeAnimation2.h"

@interface LeeCAKeyframeAnimation2 ()
@property (nonatomic,strong)UIView * blueView;

@property (nonatomic,strong)UIView * redView;

@property (nonatomic,strong)UIView  * purpleView;

@end

@implementation LeeCAKeyframeAnimation2

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
    
    
    self.blueView.frame = CGRectMake(40, 100, 280, 200);
    self.redView.frame  = CGRectMake(100, 360, 100, 100);
    self.purpleView.frame = CGRectMake(200, 360, 100, 100);
    
    [self.view addSubview:self.purpleView];
    [self.view addSubview:self.redView];
    [self.view addSubview:self.blueView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

   // [self animationValues];
    
    [self animationPath];
    
    
}
//　values：关键帧数组对象，里面每一个元素即为一个关键帧，动画会在对应的时间段内，依次执行数组中每一个关键帧的动画。
//　　path：动画路径对象，可以指定一个路径，在执行动画时路径会沿着路径移动，Path在动画中只会影响视图的Position。
//　　keyTimes：设置关键帧对应的时间点，范围：0-1。如果没有设置该属性，则每一帧的时间平分。


-(void)animationValues{

    CAKeyframeAnimation * ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ani.duration = 4.0;
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.autoreverses =YES;
    ani.repeatCount = HUGE;
    
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    NSValue * value1 = [NSValue valueWithCGPoint:CGPointMake(150, 200)];
    NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(250, 200)];
    NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(250, 300)];
    NSValue *value4=[NSValue valueWithCGPoint:CGPointMake(150, 300)];
    NSValue *value5=[NSValue valueWithCGPoint:CGPointMake(150, 200)];
    ani.values = @[value1, value2, value3, value4, value5];
    
    [self.blueView.layer addAnimation:ani forKey:@"PostionKeyframeValueAni"];
    
}


//path：动画路径对象，可以指定一个路径，在执行动画时路径会沿着路径移动，Path在动画中只会影响视图的Position。
//改变路径显示动画
-(void)animationPath{

    CAKeyframeAnimation * ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(130, 200, 200, 250));
    ani.path = path;
    CGPathRelease(path);
    ani.duration = 1.0;
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.repeatCount = HUGE;
    ani.autoreverses = YES;
    
    [self.blueView.layer addAnimation:ani forKey:@"PostionKeyframePathAni"];
}


@end
