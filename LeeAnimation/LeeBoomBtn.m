//
//  LeeBoomBtn.m
//  LeeAnimation
//
//  Created by LiYang on 17/1/1.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "LeeBoomBtn.h"


@interface LeeBoomBtn ()

@property (nonatomic,strong)CAEmitterLayer * explosionLayer;
@property (nonatomic,strong)NSArray * emitterCells;

@end
@implementation LeeBoomBtn


-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
        emitterCell.name = @"explosion";
        emitterCell.alphaRange = 0.2;
        emitterCell.alphaSpeed = -1.0;
        
        emitterCell.lifetime = 0.7;
        emitterCell.lifetimeRange = 0.2;
        emitterCell.birthRate = 0;
        emitterCell.velocity = 40;
        emitterCell.velocityRange = 10.0;
        emitterCell.scale = 0.05;
        emitterCell.scaleRange = 0.02;
        emitterCell.contents = (id)[self createImageWithColor:[UIColor purpleColor]].CGImage;
        
        _explosionLayer = [CAEmitterLayer layer];
        _explosionLayer.name = @"emitterLayer";
        _explosionLayer.emitterShape = kCAEmitterLayerCircle;
        _explosionLayer.emitterMode = kCAEmitterLayerOutline;
        _explosionLayer.emitterPosition = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        _explosionLayer.emitterSize = CGSizeMake(25, 0);
        _explosionLayer.emitterCells = @[emitterCell];
        _explosionLayer.renderMode = kCAEmitterLayerOldestFirst;
        [self.layer addSublayer:_explosionLayer];
        
        self.emitterCells = @[emitterCell];
    }
    return self;
    
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
