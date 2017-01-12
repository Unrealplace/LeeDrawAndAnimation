//
//  LeeView1.m
//  LeeAnimation
//
//  Created by LiYang on 17/1/1.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "LeeView1.h"

@implementation LeeView1


-(instancetype)init{

    if (self = [super init]) {
        self.controlWidth = 0.0f;
        
    }
    return self;
    

}
//如果将路径显示的图案显示到视图上呢？
//有三种方式：1、直接使用UIBezierPath的方法；2、使用CoreGraphics绘制；3、利用CAShapeLayer绘制
-(void)drawRect:(CGRect)rect{

    
    
    UIColor * fllColor = [UIColor redColor];
    
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint:CGPointMake(0, 0)];
    
    [bezierPath addLineToPoint:CGPointMake(rect.size.width -50, 0)];
    
    [bezierPath addQuadCurveToPoint:CGPointMake(rect.size.width - 50, rect.size.height) controlPoint:CGPointMake(rect.size.width - 50 + _controlWidth, rect.size.height / 2)];
    
    [bezierPath addLineToPoint:CGPointMake(0, rect.size.height)];
    
    [bezierPath addLineToPoint:CGPointMake(0, 0)];
    [bezierPath closePath];
    
//    // 1、bezierPath方法
//        [fllColor setFill];
//        [bezierPath fill];
    
    // 2、使用CoreGraphics
//        CGContextRef ctx = UIGraphicsGetCurrentContext();
//        CGContextAddPath(ctx, bezierPath.CGPath);
//        CGContextSetFillColorWithColor(ctx, fllColor.CGColor);
//        CGContextFillPath(ctx);
    
    // 3.CAShaperLayer
   // [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.fillColor = fllColor.CGColor;
    [self.layer addSublayer:shapeLayer];
    
    
}

-(void)setControlWidth:(CGFloat)controlWidth{

    _controlWidth = controlWidth;
    
     
    [self setNeedsDisplay];
    
    
}

@end
