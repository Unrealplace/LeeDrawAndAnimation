//
//  LeeCAEmitterLayer.m
//  LeeAnimation
//
//  Created by LiYang on 17/1/1.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "LeeCAEmitterLayer.h"
#import "LeeBoomBtn.h"

@interface LeeCAEmitterLayer ()
@property (nonatomic,strong)LeeBoomBtn * leeBtn;

@end

@implementation LeeCAEmitterLayer

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);
    
    self.leeBtn = [[LeeBoomBtn alloc] initWithFrame:CGRectMake(100, 100, 44, 44)];
    self.leeBtn.backgroundColor = [UIColor redColor];
    
    
    [self.view addSubview:self.leeBtn];
    [self.leeBtn addTarget:self action:@selector(startAnimate) forControlEvents:UIControlEventTouchUpInside];
    
    

    

}





- (void)startAnimate
{

    
    [self performSelector:@selector(explode) withObject:nil afterDelay:0.2];
}

- (void)explode
{
    self.leeBtn.explosionLayer.beginTime = CACurrentMediaTime();
    [self.leeBtn.explosionLayer setValue:@500 forKeyPath:@"emitterCells.explosion.birthRate"];
    [self performSelector:@selector(stop) withObject:nil afterDelay:0.1];
}

- (void)stop
{

    [self.leeBtn.explosionLayer setValue:@0 forKeyPath:@"emitterCells.explosion.birthRate"];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    //[self setEmitter];
    //[self setOpenEmitter];
    [self fireworks];
    
    
}
//CAEmitterLayer
//Emitter 发射器，因为可以用它来做爆炸、发射、下雪等效果。
//比如，这个下雪效果：
- (void)setEmitter
{
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    //发射点的位置
    snowEmitter.emitterPosition = CGPointMake(self.view.bounds.size.width * 0.5, -30);
    //
    snowEmitter.emitterSize = CGSizeMake(self.view.bounds.size.width * 2.0, 0.0);
    snowEmitter.emitterShape = kCAEmitterLayerLine;
    snowEmitter.emitterMode = kCAEmitterLayerOutline;
    
    snowEmitter.shadowColor = [UIColor whiteColor].CGColor;
    snowEmitter.shadowOffset = CGSizeMake(0.0, 1.0);
    snowEmitter.shadowRadius = 0.0;
    snowEmitter.shadowOpacity = 1.0;
    
    CAEmitterCell *snowCell = [CAEmitterCell emitterCell];
    
    snowCell.birthRate = 1.0; //每秒出现多少个粒子
    snowCell.lifetime = 20; // 粒子的存活时间
    snowCell.velocity = -10; //速度
    snowCell.velocityRange = 10; // 平均速度
    snowCell.yAcceleration = 2;//粒子在y方向上的加速度
    snowCell.emissionRange = 0.5 * M_PI; //发射的弧度
    snowCell.spinRange = 0.25 * M_PI; // 粒子的平均旋转速度
    snowCell.contents = (id)[UIImage imageNamed:@"222"].CGImage;
    snowCell.color = [UIColor colorWithRed:0.6 green:0.658 blue:0.743 alpha:1.0].CGColor;
    
    snowEmitter.emitterCells = @[snowCell];
    
    [self.view.layer insertSublayer:snowEmitter atIndex:0];
}

//粒子喷射效果
- (void)setOpenEmitter
{
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    //发射点的位置
    snowEmitter.emitterPosition = self.view.center;
    //
    snowEmitter.emitterSize = CGSizeMake(10.0, 0.0);
    snowEmitter.emitterShape = kCAEmitterLayerLine;
    snowEmitter.emitterMode = kCAEmitterLayerOutline;
    
    CAEmitterCell *snowCell = [CAEmitterCell emitterCell];
    
    snowCell.birthRate = 50.0;
    snowCell.lifetime = 10.0;
    snowCell.velocity = 40;
    snowCell.velocityRange = 10;
    snowCell.yAcceleration = 2;
    snowCell.emissionRange =  M_PI / 9;
    snowCell.scale = 0.1; //缩小比例
    snowCell.scaleRange = 0.08;// 平均缩小比例
    snowCell.contents = (id)[self createImageWithColor:[UIColor orangeColor]].CGImage;
    snowCell.color = [UIColor colorWithRed:0.6 green:0.658 blue:0.743 alpha:1.0].CGColor;
    
    snowEmitter.emitterCells = @[snowCell];
    
    [self.view.layer insertSublayer:snowEmitter atIndex:0];
}

//爆炸效果
- (void)fireworks
{
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.view.bounds;
    [self.view.layer addSublayer:emitter];
    
    //configure emitter
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = self.view.center;
    emitter.emitterSize = CGSizeMake(25, 0);
    
    //create a particle template
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (id)[self createImageWithColor:[UIColor blueColor]].CGImage;
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.scale = 0.1;
    cell.scaleRange = 0.08;
    cell.emissionRange = M_PI * 2.0;
    
    emitter.emitterCells = @[cell];
}

- (UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect = CGRectMake(0.0f,0.0f,20.0f,25.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}


@end
