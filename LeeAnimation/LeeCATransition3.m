//
//  LeeCATransition3.m
//  LeeAnimation
//
//  Created by LiYang on 16/12/31.
//  Copyright © 2016年 LiYang. All rights reserved.
//

#import "LeeCATransition3.h"

@interface LeeCATransition3 ()

@property (nonatomic,strong)UIView * blueView;

@property (nonatomic,strong)UIView * redView;

@property (nonatomic,strong)UIView  * purpleView;
@end

@implementation LeeCATransition3

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

    [self TransitionFade];
    
}
//CAKeyframeAnimation的重要属性：
//
//　　type：过渡动画的类型
//type的enum值如下：
//kCATransitionFade 渐变
//kCATransitionMoveIn 覆盖
//kCATransitionPush 推出
//kCATransitionReveal 揭开
//还有一些私有动画类型，效果很炫酷，不过不推荐使用。
//　　私有动画类型的值有："cube"、"suckEffect"、"oglFlip"、 "rippleEffect"、"pageCurl"、"pageUnCurl"等等。



//subtype： 过渡动画的方向
//subtype的enum值如下：
//kCATransitionFromRight 从右边
//kCATransitionFromLeft 从左边
//kCATransitionFromTop 从顶部
//kCATransitionFromBottom 从底部
//以渐变效果为例
-(void)TransitionFade{

    CATransition * ani = [CATransition animation];
    ani.type = kCATransitionMoveIn;
    ani.subtype = kCATransitionFromLeft;
    ani.duration = 1;
    ani.autoreverses = YES;
    ani.repeatCount = HUGE;
    
    self.redView.layer.contents = (id)[UIImage imageNamed:@"222.png"].CGImage;
    
    [self.redView.layer addAnimation:ani forKey:@"transitionAni"];
}

@end
