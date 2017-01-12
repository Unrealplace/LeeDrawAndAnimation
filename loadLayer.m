//
//  loadLayer.m
//  LeeAnimation
//
//  Created by LiYang on 17/1/2.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "loadLayer.h"

@implementation loadLayer
//CAReplicatorLayer 可以多次拷贝某个layer，然后重新布局，实现动画效果。
//多个视图绕Y轴旋转，可以做loading效果：
-(void)animation1{
    
    CGFloat margin = 5.0;
    CGFloat width = self.layer.bounds.size.width;
    CGFloat dotW = (width - 2 * margin) / 3;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, (width - dotW) * 0.5, dotW, dotW);
    shapeLayer.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, dotW, dotW)].CGPath;
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(0, 0, width, width);
    replicatorLayer.instanceDelay = 0.1;
    replicatorLayer.instanceCount = 5;
    CATransform3D transform = CATransform3DMakeTranslation(margin + dotW, 0, 0);
    
    replicatorLayer.instanceTransform = transform;
    [replicatorLayer addSublayer:shapeLayer];
    [self.layer addSublayer:replicatorLayer];
    
    CABasicAnimation *basicAnima = [CABasicAnimation animationWithKeyPath:@"transform"];
    basicAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DIdentity, 0, 0, 1.0, 0)];
    basicAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DIdentity, M_PI, 0, 1.0, 0)];
    basicAnima.repeatCount = HUGE;
    basicAnima.duration = 0.6;
    
    [shapeLayer addAnimation:basicAnima forKey:@"scaleAnimation"];
}

-(void)animation2{

    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    CAShapeLayer *pulseLayer = [CAShapeLayer layer];
    pulseLayer.frame = self.layer.bounds;
    pulseLayer.path = [UIBezierPath bezierPathWithOvalInRect:pulseLayer.bounds].CGPath;
    pulseLayer.fillColor = [UIColor redColor].CGColor;
    pulseLayer.opacity = 0.0;
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = self.bounds;
    replicatorLayer.instanceCount = 8;
    replicatorLayer.instanceDelay = 0.5;
    [replicatorLayer addSublayer:pulseLayer];
    [self.layer addSublayer:replicatorLayer];
    
    CABasicAnimation *opacityAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnima.fromValue = @(0.3);
    opacityAnima.toValue = @(0.0);
    
    CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scaleAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    groupAnima.animations = @[opacityAnima, scaleAnima];
    groupAnima.duration = 4.0;
    groupAnima.autoreverses = NO;
    groupAnima.repeatCount = HUGE;
    [pulseLayer addAnimation:groupAnima forKey:@"groupAnimation"];
}

-(void)animation3{

    CGFloat margin = 5.0;
    CGFloat cols = 3;
    CGFloat width = self.layer.bounds.size.width;
    CGFloat dotW = (width - margin * (cols - 1)) / cols;
    
    CAShapeLayer *dotLayer = [CAShapeLayer layer];
    dotLayer.frame = CGRectMake(0, 0, dotW, dotW);
    dotLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, dotW, dotW)].CGPath;
    dotLayer.fillColor = [UIColor redColor].CGColor;
    
    CAReplicatorLayer *replicatorLayerX = [CAReplicatorLayer layer];
    replicatorLayerX.frame = CGRectMake(0, 0, width, width);
    replicatorLayerX.instanceDelay = 0.3;
    replicatorLayerX.instanceCount = cols;
    [replicatorLayerX addSublayer:dotLayer];
    
    CATransform3D transform = CATransform3DTranslate(CATransform3DIdentity, dotW + margin, 0, 0);
    replicatorLayerX.instanceTransform = transform;
    transform = CATransform3DScale(transform, 1, -1, 0);
    
    CAReplicatorLayer *replicatorLayerY = [CAReplicatorLayer layer];
    replicatorLayerY.frame = CGRectMake(0, 0, width, width);
    replicatorLayerY.instanceDelay = 0.3;
    replicatorLayerY.instanceCount = 3;
    [replicatorLayerY addSublayer:replicatorLayerX];
    
    CATransform3D transforY = CATransform3DTranslate(CATransform3DIdentity, 0, dotW + margin, 0);
    replicatorLayerY.instanceTransform = transforY;
    
    
    [self.layer addSublayer:replicatorLayerY];
    //    [self.layer addSublayer:replicatorLayerX];
    
    //添加动画
    CABasicAnimation *opacityAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnima.fromValue = @(0.3);
    opacityAnima.toValue = @(0.3);
    
    CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    scaleAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 0.0)];
    
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    groupAnima.animations = @[opacityAnima, scaleAnima];
    groupAnima.duration = 1.0;
    groupAnima.autoreverses = YES;
    groupAnima.repeatCount = HUGE;
    [dotLayer addAnimation:groupAnima forKey:@"groupAnimation"];
}


@end
