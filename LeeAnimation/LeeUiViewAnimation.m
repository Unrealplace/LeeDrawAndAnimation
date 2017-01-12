//
//  LeeUiViewAnimation.m
//  LeeAnimation
//
//  Created by LiYang on 17/1/3.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "LeeUiViewAnimation.h"

@interface LeeUiViewAnimation ()

@property (nonatomic,strong)UIImageView * imageView;

@property (nonatomic,strong)UIView      * redView;


@end

@implementation LeeUiViewAnimation

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);

    
    self.imageView = [UIImageView new];
    [self.view addSubview:self.imageView];
    self.imageView.frame = CGRectMake(100, 100, 100, 100);
    self.imageView.image = [UIImage imageNamed:@"222"];
    
    self.redView = [UIView new];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    self.redView.frame = CGRectMake(0, 0, 150, 150);
    self.redView.center = self.view.center;
    
    
    
    

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    //[self changeFrame];
   // [self flipAni];
    
    //[self blockAni2];
   // [self blockAni3];
    //[self blockAni4];
    
   // [self blockAni5];
   // [self blockAni6];
    [self blockAni7];
    
    
    
}



//UIView动画实质上是对Core Animation的封装，提供简洁的动画接口。
//
//UIView动画可以设置的动画属性有:
//1、大小变化(frame)
//2、拉伸变化(bounds)
//3、中心位置(center)
//4、旋转(transform)
//5、透明度(alpha)
//6、背景颜色(backgroundColor)
//7、拉伸内容(contentStretch)


- (void)changeFrame {
//    第一个参数：动画标识
//    第二个参数：附加参数，在设置了代理的情况下，此参数将发送到setAnimationWillStartSelector和setAnimationDidStopSelector所指定的方法。大部分情况下，我们设置为nil即可。
    
    [UIView beginAnimations:@"FreAni" context:@"context"];
    
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(startAni:)];
    [UIView setAnimationDidStopSelector:@selector(stopAni:)];
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.imageView.frame = CGRectMake(200, 300, 120, 120);
    
    [UIView commitAnimations];
}


////设置视图的过渡效果
//[UIView setAnimationTransition:(UIViewAnimationTransition) forView:(nonnull UIView *) cache:(BOOL)];
//第一个参数：UIViewAnimationTransition的枚举值如下
//UIViewAnimationTransitionNone,              //不使用动画
//UIViewAnimationTransitionFlipFromLeft,      //从左向右旋转翻页
//UIViewAnimationTransitionFlipFromRight,     //从右向左旋转翻页
//UIViewAnimationTransitionCurlUp,            //从下往上卷曲翻页
//UIViewAnimationTransitionCurlDown,          //从上往下卷曲翻页
//第二个参数：需要过渡效果的View
//第三个参数：是否使用视图缓存，YES：视图在开始和结束时渲染一次；NO：视图在每一帧都渲染
- (void)flipAni {
    [UIView beginAnimations:@"FlipAni" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(startAni:)];
    [UIView setAnimationDidStopSelector:@selector(stopAni:)];
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.imageView cache:YES];
    self.imageView.image = [UIImage imageNamed:@"111"];
    [UIView commitAnimations];
}

- (void)startAni:(NSString *)aniID {
    NSLog(@"%@ start",aniID);
}

- (void)stopAni:(NSString *)aniID {
    NSLog(@"%@ stop",aniID);
}
/////////////////////////////////////////
//1）Block动画方法
//1、最简洁的Block动画：包含时间和动画
//[UIView animateWithDuration:(NSTimeInterval)  //动画持续时间
//                 animations:^{
//                     //执行的动画
//                 }];

//2、带有动画完成回调的Block动画
//[UIView animateWithDuration:(NSTimeInterval)  //动画持续时间
//                 animations:^{
//                     //执行的动画
//                 }                completion:^(BOOL finished) {
//                     //动画执行完毕后的操作
//                 }];


//3、可设置延迟时间和过渡效果的Block动画
//[UIView animateWithDuration:(NSTimeInterval) //动画持续时间
//                      delay:(NSTimeInterval) //动画延迟执行的时间
//                    options:(UIViewAnimationOptions) //动画的过渡效果
//                 animations:^{
//                     //执行的动画
//                 }                completion:^(BOOL finished) {
//                     //动画执行完毕后的操作
//                 }];


//UIViewAnimationOptions的枚举值如下，可组合使用：
//UIViewAnimationOptionLayoutSubviews            //进行动画时布局子控件
//UIViewAnimationOptionAllowUserInteraction      //进行动画时允许用户交互
//UIViewAnimationOptionBeginFromCurrentState     //从当前状态开始动画
//UIViewAnimationOptionRepeat                    //无限重复执行动画
//UIViewAnimationOptionAutoreverse               //执行动画回路
//UIViewAnimationOptionOverrideInheritedDuration //忽略嵌套动画的执行时间设置
//UIViewAnimationOptionOverrideInheritedCurve    //忽略嵌套动画的曲线设置
//UIViewAnimationOptionAllowAnimatedContent      //转场：进行动画时重绘视图
//UIViewAnimationOptionShowHideTransitionViews   //转场：移除（添加和移除图层的）动画效果
//UIViewAnimationOptionOverrideInheritedOptions  //不继承父动画设置
//
//UIViewAnimationOptionCurveEaseInOut            //时间曲线，慢进慢出（默认值）
//UIViewAnimationOptionCurveEaseIn               //时间曲线，慢进
//UIViewAnimationOptionCurveEaseOut              //时间曲线，慢出
//UIViewAnimationOptionCurveLinear               //时间曲线，匀速
//
//UIViewAnimationOptionTransitionNone            //转场，不使用动画
//UIViewAnimationOptionTransitionFlipFromLeft    //转场，从左向右旋转翻页
//UIViewAnimationOptionTransitionFlipFromRight   //转场，从右向左旋转翻页
//UIViewAnimationOptionTransitionCurlUp          //转场，下往上卷曲翻页
//UIViewAnimationOptionTransitionCurlDown        //转场，从上往下卷曲翻页
//UIViewAnimationOptionTransitionCrossDissolve   //转场，交叉消失和出现
//UIViewAnimationOptionTransitionFlipFromTop     //转场，从上向下旋转翻页
//UIViewAnimationOptionTransitionFlipFromBottom  //转场，从下向上旋转翻页

//4、Spring动画
//iOS7.0后新增Spring动画（iOS系统动画大部分采用Spring Animation，适用于所有可被添加动画效果的属性）
//[UIView animateWithDuration:(NSTimeInterval)//动画持续时间
//                      delay:(NSTimeInterval)//动画延迟执行的时间
//     usingSpringWithDamping:(CGFloat)//震动效果，范围0~1，数值越小震动效果越明显
//      initialSpringVelocity:(CGFloat)//初始速度，数值越大初始速度越快
//                    options:(UIViewAnimationOptions)//动画的过渡效果
//                 animations:^{
//                     //执行的动画
//                 }
//                 completion:^(BOOL finished) {
//                     //动画执行完毕后的操作
//                 }];


//5、Keyframes动画
//iOS7.0后新增关键帧动画，支持属性关键帧，不支持路径关键帧
//[UIView animateKeyframesWithDuration:(NSTimeInterval)//动画持续时间
//                               delay:(NSTimeInterval)//动画延迟执行的时间
//                             options:(UIViewKeyframeAnimationOptions)//动画的过渡效果
//                          animations:^{
//                              //执行的关键帧动画
//                          }
//                          completion:^(BOOL finished) {
//                              //动画执行完毕后的操作
//                          }];

// UIViewKeyframeAnimationOptions的枚举值如下，可组合使用：
//UIViewAnimationOptionLayoutSubviews           //进行动画时布局子控件
//UIViewAnimationOptionAllowUserInteraction     //进行动画时允许用户交互
//UIViewAnimationOptionBeginFromCurrentState    //从当前状态开始动画
//UIViewAnimationOptionRepeat                   //无限重复执行动画
//UIViewAnimationOptionAutoreverse              //执行动画回路
//UIViewAnimationOptionOverrideInheritedDuration //忽略嵌套动画的执行时间设置
//UIViewAnimationOptionOverrideInheritedOptions //不继承父动画设置
//UIViewKeyframeAnimationOptionCalculationModeLinear     //运算模式 :连续
//UIViewKeyframeAnimationOptionCalculationModeDiscrete   //运算模式 :离散
//UIViewKeyframeAnimationOptionCalculationModePaced      //运算模式 :均匀执行
//UIViewKeyframeAnimationOptionCalculationModeCubic      //运算模式 :平滑
//UIViewKeyframeAnimationOptionCalculationModeCubicPaced //运算模式 :平滑均匀

// 增加关键帧的方法：
//[UIView addKeyframeWithRelativeStartTime:(double)//动画开始的时间（占总时间的比例）
//                        relativeDuration:(double) //动画持续时间（占总时间的比例）
//                              animations:^{
//                                  //执行的动画
//                              }];


//6、转场动画
//6.1 从旧视图转到新视图的动画效果
//[UIView transitionFromView:(nonnull UIView *)
//                    toView:(nonnull UIView *)
//                  duration:(NSTimeInterval)
//                   options:(UIViewAnimationOptions)
//                completion:^(BOOL finished) {
//                    //动画执行完毕后的操作
//                }];

// 6.2 单个视图的过渡效果
//[UIView transitionWithView:(nonnull UIView *)
//                  duration:(NSTimeInterval)
//                   options:(UIViewAnimationOptions)
//                animations:^{
//                    //执行的动画
//                }
//                completion:^(BOOL finished) {
//                    //动画执行完毕后的操作
//                }];




- (void)blockAni1 {
    [UIView animateWithDuration:1.0 animations:^{
        self.imageView.frame = self.redView.frame;
    }];
}
- (void)blockAni2 {
    [UIView animateWithDuration:1.0 animations:^{
        self.imageView.frame = self.redView.frame;
    } completion:^(BOOL finished) {
        NSLog(@"动画结束");
    }];
}
- (void)blockAni3 {
    [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionRepeat animations:^{
        self.imageView.frame = self.redView.frame;
    } completion:^(BOOL finished) {
        NSLog(@"动画结束");
    }];
}
//spring 动画
- (void)blockAni4 {
    [UIView animateWithDuration:1.0 delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.imageView.layer.position = CGPointMake(self.imageView.layer.position.x, self.imageView.layer.position.y + 100);
        
    } completion:^(BOOL finished) {
        NSLog(@"动画结束");
    }];
}
//3、Keyframes动画
//这里以实现视图背景颜色变化（红-绿-蓝-紫）的过程来演示关键帧动画。
- (void)blockAni5 {

    [UIView animateKeyframesWithDuration:4.0 delay:0.f options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.f relativeDuration:1.0 / 4 animations:^{
            self.redView.backgroundColor = [UIColor colorWithRed:0.9475 green:0.1921 blue:0.1746 alpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:1.0 / 4 relativeDuration:1.0 / 4 animations:^{
            self.redView.backgroundColor = [UIColor colorWithRed:0.1064 green:0.6052 blue:0.0334 alpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:2.0 / 4 relativeDuration:1.0 / 4 animations:^{
            self.redView.backgroundColor = [UIColor colorWithRed:0.1366 green:0.3017 blue:0.8411 alpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:3.0 / 4 relativeDuration:1.0 / 4 animations:^{
            self.redView.backgroundColor = [UIColor colorWithRed:0.619 green:0.037 blue:0.6719 alpha:1.0];
        }];
    
    } completion:^(BOOL finished) {
        NSLog(@"动画结束");
    }];
}

//转场动画
- (void)blockAni6 {
    [UIView transitionWithView:self.imageView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        self.imageView.image = [UIImage imageNamed:@"111"];
    } completion:^(BOOL finished) {
        NSLog(@"动画结束");
    }];
}
//4.2 从旧视图转到新视图的动画效果
- (void)blockAni7 {
    UIImageView * newCenterShow = [[UIImageView alloc]initWithFrame:self.imageView.frame];
    newCenterShow.image = [UIImage imageNamed:@"111"];
    [UIView transitionFromView:self.imageView toView:newCenterShow duration:1.0 options:UIViewAnimationOptionTransitionCurlDown completion:^(BOOL finished) {
        NSLog(@"动画结束");
    }];
}
//在该动画过程中，fromView 会从父视图中移除，并讲 toView 添加到父视图中，注意转场动画的作用对象是父视图（过渡效果体现在父视图上）。
@end
