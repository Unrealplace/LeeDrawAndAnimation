//
//  LeeUIDynamicAnimator.m
//  LeeAnimation
//
//  Created by LiYang on 17/1/1.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "LeeUIDynamic.h"

@interface LeeUIDynamic ()

@property (nonatomic,strong)UIDynamicAnimator * animator;

@property (nonatomic,strong)UIView  * someView;

@property (nonatomic,strong)UIAttachmentBehavior * attachmentBehavior;

@end

@implementation LeeUIDynamic

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);
    self.someView = [UIView new];
    self.someView.frame = CGRectMake(30, 200, 60, 60);
    self.someView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.someView];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    
    [self.someView addGestureRecognizer:pan];
    
    
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
   // [self animateTest1];
   // [self animatio3];
    //[self animation4];
    [self animation5];
    

}

//使用UIDynamic，需要理解几个概念：1、UIDynamicAnimator，2、UIDynamicBehavior，3、UIDynamicItem。
//UIDynamicAnimator 相当于动画引擎。它初始化时，需要一个ReferenceView，用它的坐标系统作为参考坐标系。
//UIDynamicBehavior 相当于仿真动画体。创建时，需要附带动画将要作用的视图（即UIDynamicItem）,可以传一个包含多个视图的数组。
//UIDynamicItem 就是仿真动画将要作用的视图。

//常用的UIDynamicBehavior有：
//UIGravityBehavior 重力行为
//UICollisionBehavior 碰撞行为
//UIAttachmentBehavior 附着行为
//UIPushBehavior 推动行为
//UIDynamicItemBehavior 动力行为
//UISnapBehavior 捕获行为


- (void)animateTest1
{
    
 
    // 重力行为
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[_someView]];
    gravityBehavior.gravityDirection = CGVectorMake(0, 1);
    gravityBehavior.magnitude = 2.5;
    [_animator addBehavior:gravityBehavior];
    
    // 碰撞行为
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[_someView]];
    //设置碰撞边界有如下几张方式：
    //1.设置碰撞边界为referenceView的边界。
    //    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    // 2.设置碰撞边界以referenceView作为参考，设置insets作为边界。
    [collisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets:UIEdgeInsetsMake(0, 0, 20, 0)];
    // 3.用两个点的连线作为碰撞边界
    //    [collisionBehavior addBoundaryWithIdentifier:@"pointBoundary" fromPoint:CGPointMake(0, 300) toPoint:CGPointMake(320, 600)];
    // 4.以某个贝塞尔曲线作为碰撞边界
    //    [collisionBehavior addBoundaryWithIdentifier:@"pathBoundary" forPath:_bezierPath];
    [_animator addBehavior:collisionBehavior];
}

//附着行为
- (void)panAction:(UIPanGestureRecognizer *)panGesture
{
    CGPoint location = [panGesture locationInView:self.view];
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        _attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:_someView attachedToAnchor:location];
        [_animator addBehavior:_attachmentBehavior];
    } else if (panGesture.state == UIGestureRecognizerStateChanged) {
        _attachmentBehavior.anchorPoint = location;
    } else if (panGesture.state == UIGestureRecognizerStateEnded) {
        [_animator removeBehavior:_attachmentBehavior];
    }
}

//4.UIPushBehavior（推动行为）
//
//推动行为的mode有连个值，一个是持续的推力，一个是初始推力。
//pushDirection与重力的参数类似，表示二维坐标系中推力的方向。
//magnitude系数，影响加速度。
//下面的动画，是给视图一个向上的推力，然后在重力的作用下运动到最高点后下落，最后在设置好的碰撞边界处慢慢趋于静止。

-(void)animatio3{

    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[_someView] mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.pushDirection = CGVectorMake(0, - 80.0);
    pushBehavior.magnitude = 2.0;
    [_animator addBehavior:pushBehavior];
    
    // 重力行为
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[_someView]];
    gravityBehavior.gravityDirection = CGVectorMake(0, 1);
    gravityBehavior.magnitude = 2.5;
    [_animator addBehavior:gravityBehavior];
    
    // 碰撞行为
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[_someView]];
    //设置碰撞边界为referenceView的边界。
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:collisionBehavior];
}

//5.UIDynamicItemBehavior （动力行为）
//因为可以设置摩擦力、弹力、密度、阻力等参数，在模拟视图运动的能量损失
//给视图一个初始向上的推力，然后在摩擦力，阻力等参数下慢慢减速至静止。遇到边界碰撞时会有能量损失。效果图如下:
-(void)animation4{

    //动力行为
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[_someView]];
    itemBehavior.elasticity = 0.6; //弹力
    itemBehavior.friction = 1;     //摩擦力
    itemBehavior.density = 1;    //密度
    itemBehavior.resistance = 2; // 阻力
    itemBehavior.allowsRotation = YES; //允许旋转
    [_animator addBehavior:itemBehavior];
    
    // 推动行为
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[_someView] mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.pushDirection = CGVectorMake(0,  80.0);
    pushBehavior.magnitude = 2.0;
    [_animator addBehavior:pushBehavior];
    
    // 碰撞行为
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[_someView]];
    //设置碰撞边界为referenceView的边界。
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:collisionBehavior];
}
//6.UISnapBehavior （捕获行为）
//捕获行为，是移动视图到某个位置，然后到达后，有一个摆动效果。
- (void)animation5
{
    // 捕获行为
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:_someView snapToPoint:self.view.center];
    snapBehavior.damping = 0.1; // 0.0~~1.0，阻尼系数，影响能量损失。
    [_animator addBehavior:snapBehavior];
}
@end
