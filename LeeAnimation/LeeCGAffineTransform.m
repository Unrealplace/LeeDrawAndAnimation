//
//  LeeCGAffineTransform.m
//  LeeAnimation
//
//  Created by LiYang on 17/1/2.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "LeeCGAffineTransform.h"

@interface LeeCGAffineTransform ()

@property (nonatomic,strong)UIImageView * changeImageView;

@end

@implementation LeeCGAffineTransform

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);

    self.changeImageView = [UIImageView new];
    self.changeImageView.frame = CGRectMake(100, 100, 120, 120);
    self.changeImageView.image = [UIImage imageNamed:@"222"];
    self.changeImageView.userInteractionEnabled = YES;
    
    [self.view addSubview:self.changeImageView];
    
    [self addPanGesture];
    [self addPinchGesture];
    [self addRotationGesture];
    
    
    
}


//总得来说，这个类中包含3张不同类型，分别使用如下3个方法创建数值；
//
//1.CGAffineTransformMakeTranslation(CGFloat tx, CGFloat ty)（平移:设置平移量）
//
//2.CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)（缩放:设置缩放比例）仅通过设置缩放比例就可实现视图扑面而来和缩进频幕的效果。
//
//3.CGAffineTransformMakeRotation(CGFloat angle)（旋转:设置旋转角度）
//
//这3种方法分别对应另外一种方法：
//
//1.CGAffineTransformMakeTranslation
//
//2.CGAffineTransformMakeRotation
//
//3.CGAffineTransformMakeScale
//
//区别在于：下面这种方法这种方法每次形变都不能叠加形变，所以再次触发形变动作时形变会先还原，而上面这种方法每次都是以传入的transform为参照（既有叠加效果）
//
//以上3个都是针对视图的原定最初位置的中心点为起始参照进行相应操作的，在操作结束之后可对设置量进行还原：
//
//view.transform＝CGAffineTransformIdentity;


- (void)addPanGesture{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    [_changeImageView addGestureRecognizer:pan];
}

- (void)addRotationGesture{
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationAction:)];
    [_changeImageView addGestureRecognizer:rotation];
}

- (void)addPinchGesture{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchAction:)];
    [_changeImageView addGestureRecognizer:pinch];
}
//退拽平移
- (void)panAction:(UIPanGestureRecognizer *)pan{
    NSLog(@"pan");
    CGPoint offPoint = [pan translationInView:pan.view];
   
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, offPoint.x, offPoint.y);
    //每一次平移后，产生X轴和Y轴的增量要归零
    [pan setTranslation:CGPointZero inView:pan.view];
}
//旋转
- (void)rotationAction:(UIRotationGestureRecognizer *)rotation{
    NSLog(@"rotation");
    //    rotation.view.transform =CGAffineTransformMakeRotation(rotation.rotation);
    rotation.view.transform = CGAffineTransformRotate(rotation.view.transform, rotation.rotation);
    //每次旋转完成后，设置旋转弧度为0
    rotation.rotation = 0;
}
//捏合缩放
- (void)pinchAction:(UIPinchGestureRecognizer *)pinch{
    NSLog(@"pinch");
    //    pinch.view.transform =CGAffineTransformMakeScale(pinch.scale, pinch.scale);
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale, pinch.scale);
    //每次缩放完成后，比例设置成1；
    pinch.scale = 1;
}


-(void)translate{

}

-(void)makeScale{

}
-(void)makeRotate{

    
}



@end
