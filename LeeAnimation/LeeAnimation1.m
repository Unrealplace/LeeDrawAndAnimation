//
//  LeeAnimation1.m
//  LeeAnimation
//
//  Created by LiYang on 16/12/29.
//  Copyright © 2016年 LiYang. All rights reserved.
//

#import "LeeAnimation1.h"

@interface LeeAnimation1 ()

@property (nonatomic,strong)UIView * blueView;

@property (nonatomic,strong)UIView * redView;

@property (nonatomic,strong)UIView  * purpleView;


@end

@implementation LeeAnimation1

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

    
    [self.redView.layer removeAllAnimations];
    [self.blueView.layer removeAllAnimations];
    [self.purpleView.layer removeAllAnimations ];
   // [self movPositon];
    
    
  //  [self movPositionX];
    
   // [self movPositionY];
    
   // [self rotationX];
//    [self rotationY];
//    [self rotationZ];
//    
//    [self scaleX];
//    [self scaleY];
//    [self scale];
//    
//    [self bounds];
//    [self opaticy];
    
 //   [self backgroundColor];
//    [self cornerRadius];
//    [self borderWidth];
    
   // [self contents];
    
   // [self shadowColor];
   // [self shadowOffset];
    
    //[self shadowOpacity];
    [self shadowRadius];
    
}
//yes
-(void)movPositon{

    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.toValue = [NSValue valueWithCGPoint:self.blueView.center];
    
//       fillMode：视图在非Active时的行为
//    　　removedOnCompletion：动画执行完毕后是否从图层上移除，默认为YES（视图会恢复到动画前的状态），可设置为NO（图层保持动画执行后的状态，前提是fillMode设置为kCAFillModeForwards）
    
  //  　　timingFunction：动画的时间节奏控制
    animation.removedOnCompletion = NO;
    animation.repeatCount = HUGE;
    //animation.autoreverses = YES;
    animation.fillMode = kCAFillModeBackwards;
    animation.duration = 0.8;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.redView.layer addAnimation:animation forKey:@"PostionAni"];
    
    [self.view bringSubviewToFront:self.redView];
    
    
}
//yes
-(void)movPositionX{

    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.purpleView.center.x, self.redView.center.y)];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBackwards;
    animation.autoreverses = YES;
    animation.repeatCount = HUGE;

    animation.duration = 0.8;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.redView.layer addAnimation:animation forKey:@"position.x"];
    
    [self.view bringSubviewToFront:self.redView];

}
//yes
-(void)movPositionY{

    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.redView.center.x, self.blueView.center.y + 20)];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBackwards;
    animation.autoreverses = YES;
    animation.repeatCount = HUGE;
    animation.duration = 0.8;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    [self.redView.layer addAnimation:animation forKey:@"position.x"];
    
    [self.view bringSubviewToFront:self.redView];
    
    
}
//yes
-(void)rotationX{

//    CABasicAnimation* rotationAnimation;
//    //绕哪个轴，那么就改成什么：这里是绕y轴 ---> transform.rotation.y
//    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
//    //旋转角度
//    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI];
//    //每次旋转的时间（单位秒）
//    rotationAnimation.duration = 0.3;
//    rotationAnimation.cumulative = YES;
//    //重复旋转的次数，如果你想要无数次，那么设置成MAXFLOAT
//    rotationAnimation.repeatCount = 0;
//    [yourView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

    
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation.toValue = [NSNumber numberWithFloat:M_PI];
    animation.duration = 0.5;
    animation.autoreverses = YES;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = HUGE;
    [self.redView.layer addAnimation:animation forKey:@"rotationx"];
    
}

//yes
-(void)rotationY{

    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.toValue = [NSNumber numberWithFloat:M_PI];
    animation.duration = 0.5;
    animation.autoreverses = YES;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = HUGE;
    [self.redView.layer addAnimation:animation forKey:@"rotationy"];
}
//yes
-(void)rotationZ{

    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithFloat:M_PI];
    animation.duration = 0.5;
   // animation.autoreverses = YES;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = HUGE;
    [self.blueView.layer addAnimation:animation forKey:@"rotationz"];
}

//yes
-(void)scaleX{

    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    theAnimation.duration= 1;
    theAnimation.removedOnCompletion = YES;
    theAnimation.autoreverses = YES;
    theAnimation.repeatCount = HUGE;
    theAnimation.fromValue = [NSNumber numberWithFloat:1];
    theAnimation.toValue = [NSNumber numberWithFloat:1.6];
    
    [self.redView.layer addAnimation:theAnimation forKey:@"animateTransform"];
    
}
//yes
-(void)scaleY{

    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    theAnimation.duration= 1;
    theAnimation.removedOnCompletion = YES;
    theAnimation.autoreverses = YES;
    theAnimation.repeatCount = HUGE;
    theAnimation.fromValue = [NSNumber numberWithFloat:1];
    theAnimation.toValue = [NSNumber numberWithFloat:1.6];
    
    [self.purpleView.layer addAnimation:theAnimation forKey:@"animateTransform"];
}

//yes
-(void)scale{

   // x轴，y轴同时按比例缩放：
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    theAnimation.duration=8;
    theAnimation.removedOnCompletion = YES;
    theAnimation.fromValue = [NSNumber numberWithFloat:1];
    theAnimation.toValue = [NSNumber numberWithFloat:0.5];
    [self.blueView.layer addAnimation:theAnimation forKey:@"animateTransform"];
    
   // 以上缩放是以view的中心点为中心缩放的，如果需要自定义缩放点，可以设置卯点：
    //中心点
   // [yourView.layer setAnchorPoint:CGPointMake(0.5, 0.5)];
    
    //左上角
    //[self.blueView.layer setAnchorPoint:CGPointMake(0, 0)];
    
    //右下角
    //[yourView.layer setAnchorPoint:CGPointMake(1, 1)];
}

-(void)transation{

    
}
//yes
-(void)bounds{

    CABasicAnimation *theAnimation;
    

    theAnimation=[CABasicAnimation animationWithKeyPath:@"bounds"];
    theAnimation.duration= 0.8;
    theAnimation.removedOnCompletion = YES;
    theAnimation.autoreverses = YES;
    theAnimation.repeatCount = HUGE;
    
    theAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, self.blueView.frame.size.width + 10, self.blueView.frame.size.height + 20)];
    
    
    
    [self.blueView.layer addAnimation:theAnimation forKey:@"bounds"];
}
//yes
-(void)size{

    
    
    CABasicAnimation *theAnimation;
    
    
    theAnimation=[CABasicAnimation animationWithKeyPath:@"size"];
    theAnimation.duration= 0.8;
    theAnimation.removedOnCompletion = YES;
    theAnimation.autoreverses = YES;
    theAnimation.repeatCount = HUGE;
    theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    theAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(self.blueView.frame.size.width + 40, 100)];
    
    
    
    
    [self.blueView.layer addAnimation:theAnimation forKey:@"ke_size"];
    
}
//yes
-(void)opaticy{

    
    CABasicAnimation *theAnimation;
    
    
    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    theAnimation.duration= 0.8;
    theAnimation.removedOnCompletion = YES;
    theAnimation.autoreverses = YES;
    theAnimation.repeatCount = HUGE;
    theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
   
    theAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    theAnimation.toValue  = [NSNumber numberWithFloat:0.3];
    
    [self.redView.layer addAnimation:theAnimation forKey:@"opacity__kk"];
}
//yes
-(void)backgroundColor{

    CABasicAnimation *theAnimation;
    
    theAnimation=[CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    theAnimation.duration= 1;
    theAnimation.removedOnCompletion = YES;
    theAnimation.autoreverses = YES;
    theAnimation.repeatCount = HUGE;
    theAnimation.fillMode = kCAFillModeForwards;
   // theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    theAnimation.fromValue = (id)[UIColor orangeColor].CGColor;
    
    theAnimation.toValue  = (id)[UIColor purpleColor].CGColor;
    
    [self.redView.layer addAnimation:theAnimation forKey:@"backgroundColor"];

}
//yes
-(void)cornerRadius{

    CABasicAnimation *theAnimation;
    
    theAnimation=[CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    theAnimation.duration= 1;
    theAnimation.removedOnCompletion = YES;
    theAnimation.autoreverses = YES;
    theAnimation.repeatCount = HUGE;
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    theAnimation.fromValue = @(0);
    theAnimation.toValue  = @(20);

    
    [self.redView.layer addAnimation:theAnimation forKey:@"cornerRadius"];
    
}
//yes
-(void)borderWidth{

    CABasicAnimation *theAnimation;
    
    theAnimation=[CABasicAnimation animationWithKeyPath:@"borderWidth"];
    theAnimation.duration= 1;
    theAnimation.removedOnCompletion = YES;
    theAnimation.autoreverses = YES;
    theAnimation.repeatCount = HUGE;
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    theAnimation.fromValue = @(0);
    theAnimation.toValue  = @(10);
    self.redView.layer.borderColor = [UIColor orangeColor].CGColor;
    
    
    [self.redView.layer addAnimation:theAnimation forKey:@"borderWidth"];
}

//yes
-(void)contents{

    CABasicAnimation *theAnimation;
    
    theAnimation=[CABasicAnimation animationWithKeyPath:@"contents"];
    theAnimation.duration= 1;
    theAnimation.removedOnCompletion = YES;
    theAnimation.autoreverses = YES;
    theAnimation.repeatCount = CGFLOAT_MAX;
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    theAnimation.fromValue = (id)[UIImage imageNamed:@"111.png"].CGImage;
    theAnimation.toValue  = (id)[UIImage imageNamed:@"222.png"].CGImage;
    
    
    [self.redView.layer addAnimation:theAnimation forKey:@"contents"];
    
}
//yes
-(void)shadowColor{
    CABasicAnimation *theAnimation;
    
    [self.redView.layer
     setShadowOffset:CGSizeMake(2,2)];
    [self.redView.layer
     setShadowOpacity:1];
    
    
    theAnimation=[CABasicAnimation animationWithKeyPath:@"shadowColor"];
    theAnimation.duration= 1;
    theAnimation.removedOnCompletion = YES;
    theAnimation.autoreverses = YES;
    theAnimation.repeatCount = CGFLOAT_MAX;
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    theAnimation.fromValue = (id)[UIColor blackColor].CGColor;
    theAnimation.toValue = (id)[UIColor orangeColor].CGColor;
    
    
    [self.redView.layer addAnimation:theAnimation forKey:@"shadowColor"];
    
}

//no
-(void)shadowOffset{

    
    CABasicAnimation *theAnimation;
    
    theAnimation=[CABasicAnimation animationWithKeyPath:@"shadowOffset"];
    theAnimation.duration= 1;
    theAnimation.removedOnCompletion = YES;
    theAnimation.autoreverses = YES;
    theAnimation.repeatCount = CGFLOAT_MAX;
    theAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(0,0)];
    theAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(10,10)];

    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    
    
    [self.redView.layer addAnimation:theAnimation forKey:@"shadowOffset"];
}
//yes
-(void)shadowOpacity{

    
    [self.redView.layer
     setShadowOffset:CGSizeMake(2,2)];
    CABasicAnimation *theAnimation;
    
    theAnimation=[CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
    theAnimation.duration= 1;
    theAnimation.removedOnCompletion = YES;
    theAnimation.autoreverses = YES;
    theAnimation.repeatCount = CGFLOAT_MAX;
    
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    theAnimation.fromValue = @(0.3);
    
    theAnimation.toValue = @(1.0);

    
    
    [self.redView.layer addAnimation:theAnimation forKey:@"shadowOpacity"];

}

//no
-(void)shadowRadius{

    [self.redView.layer
     setShadowOffset:CGSizeMake(10,10)];
    CABasicAnimation *theAnimation;
    [self.redView.layer
     setShadowColor:[UIColor orangeColor].CGColor];
    self.redView.layer.shadowRadius = 4;
    
    
    theAnimation=[CABasicAnimation animationWithKeyPath:@"shadowRadius"];
    
    theAnimation.fromValue = [NSNumber numberWithInt:10];
    
    theAnimation.toValue =[NSNumber numberWithInt:5];
    
    theAnimation.duration= 1;
    theAnimation.removedOnCompletion = YES;
    theAnimation.autoreverses = YES;
    theAnimation.repeatCount = CGFLOAT_MAX;
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
   
    
    
    
    [self.redView.layer addAnimation:theAnimation forKey:nil];

}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:YES];
    [self.redView.layer removeAllAnimations];
    [self.blueView.layer removeAllAnimations];
    [self.purpleView.layer removeAllAnimations ];
    
}

//我们可以通过animationWithKeyPath键值对的方式来改变动画
//
//animationWithKeyPath的值：
//
//　 transform.scale = 比例轉換 ／／
//
//transform.scale.x = 闊的比例轉換 ／／
//
//transform.scale.y = 高的比例轉換 ／／
//
//transform.rotation.z = 平面圖的旋轉 ／／
//
//opacity = 透明度
//
//margin
//
//zPosition//
//
//backgroundColor  //  背景颜色
//
//cornerRadius    圆角 //
//
//borderWidth//
//
//bounds//
//
//contents//
//
//contentsRect
//
//cornerRadius
//
//frame
//
//hidden
//
//mask
//
//masksToBounds
//
//opacity//
//
//position//
//
//shadowColor//
//
//shadowOffset
//
//shadowOpacity//
//
//shadowRadius
@end
