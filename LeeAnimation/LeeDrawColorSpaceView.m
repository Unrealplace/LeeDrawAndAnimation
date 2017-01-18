//
//  LeeDrawColorSpaceView.m
//  LeeAnimation
//
//  Created by LiYang on 17/1/18.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "LeeDrawColorSpaceView.h"

@implementation LeeDrawColorSpaceView

- (void)drawRect:(CGRect)rect {
    
    // [self drawLineaGradient:UIGraphicsGetCurrentContext()];
    
    [self drawRadialGradient:UIGraphicsGetCurrentContext()];
    
    
}

//线线渐变
-(void)drawLineaGradient:(CGContextRef)context{
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    ///*指定渐变色
    // space:颜色空间
    // components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
    // 如果有三个颜色则这个数组有4*3个元素
    // locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
    // count:渐变个数，等于locations的个数
    // */
    CGFloat compoents[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    
    CGFloat locations[3]={0,0.3,1.0};
    
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    
    
    ///*绘制线性渐变
    //     context:图形上下文
    //     gradient:渐变色
    //     startPoint:起始位置
    //     endPoint:终止位置
    //     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，到结束位置之后不再绘制，
    //     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，到结束点之后继续填充
    //  */
    
    CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(150, 200), kCGGradientDrawsAfterEndLocation);
    
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
    
}


#pragma mark 径向渐变
-(void)drawRadialGradient:(CGContextRef)context{
    //使用rgb颜色空间
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    
    /*指定渐变色
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
    CGFloat compoents[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[3]={0,0.3,1.0};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    
    /*绘制径向渐变
     context:图形上下文
     gradient:渐变色
     startCenter:起始点位置
     startRadius:起始半径（通常为0，否则在此半径范围内容无任何填充）
     endCenter:终点位置（通常和起始点相同，否则会有偏移）
     endRadius:终点半径（也就是渐变的扩散长度）
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，但是到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，但到结束点之后继续填充
     */
    CGContextDrawRadialGradient(context, gradient, CGPointMake(160, 284),0, CGPointMake(165, 289), 150, kCGGradientDrawsAfterEndLocation);
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
}

@end
