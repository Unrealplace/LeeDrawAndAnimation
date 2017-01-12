//
//  LeeDrawView2.m
//  LeeAnimation
//
//  Created by LiYang on 17/1/12.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "LeeDrawView2.h"

@implementation LeeDrawView2

//当你在图形上下文中绘图时，当前图形上下文的相关属性设置将决定绘图的行为与外观。因此，绘图的一般过程是先设定好图形上下文参数，然后绘图。比方说，要画一根红线，接着画一根蓝线。那么首先需要将上下文的线条颜色属性设定为为红色，然后画红线；接着设置上下文的线条颜色属性为蓝色，再画出蓝线。表面上看,红线和蓝线是分开的，但事实上，在你画每一条线时，线条颜色却是整个上下文的属性。无论你用的是UIKit方法还是Core Graphics函数。
//
//因为图形上下文在每一时刻都有一个确定的状态，该状态概括了图形上下文所有属性的设置。为了便于操作这些状态，图形上下文提供了一个用来持有状态的栈。调用CGContextSaveGState函数，上下文会将完整的当前状态压入栈顶；调用CGContextRestoreGState函数，上下文查找处在栈顶的状态，并设置当前上下文状态为栈顶状态。
//
//因此一般绘图模式是：在绘图之前调用CGContextSaveGState函数保存当前状态，接着根据需要设置某些上下文状态，然后绘图，最后调用CGContextRestoreGState函数将当前状态恢复到绘图之前的状态。要注意的是，CGContextSaveGState函数和CGContextRestoreGState函数必须成对出现，否则绘图很可能出现意想不到的错误，这里有一个简单的做法避免这种情况。代码如下：





//许多的属性组成了一个图形上下文状态，这些属性设置决定了在你绘图时图形的外观和行为。下面我列出了一些属性和对应修改属性的函数；虽然这些函数是关于Core Graphics的，但记住，实际上UIKit同样是调用这些函数操纵上下文状态。
//
//线条的宽度和线条的虚线样式
//CGContextSetLineWidth、CGContextSetLineDash
//
//线帽和线条联接点样式 连接线的斜接限制
//CGContextSetLineCap、CGContextSetLineJoin、CGContextSetMiterLimit
//
//线条描边颜色和线条模式
//CGContextSetRGBStrokeColor、CGContextSetGrayStrokeColor、CGContextSetStrokeColorWithColor、CGContextSetStrokePattern
//
//填充颜色和模式

//CGContextSetRGBFillColor,CGContextSetGrayFillColor,CGContextSetFillColorWithColor, CGContextSetFillPattern
//
//阴影
//CGContextSetShadow、CGContextSetShadowWithColor
//
//混合模式
//CGContextSetBlendMode（决定你当前绘制的图形与已经存在的图形如何被合成）
//
//整体透明度
//CGContextSetAlpha（个别颜色也具有alpha成分）
//
//文本属性
//CGContextSelectFont、CGContextSetFont、CGContextSetFontSize、CGContextSetTextDrawingMode、CGContextSetCharacterSpacing
//
//是否开启反锯齿和字体平滑
//CGContextSetShouldAntialias、CGContextSetShouldSmoothFonts
//
//另外一些属性设置：
//
//裁剪区域:在裁剪区域外绘图不会被实际的画出来。
//
//变换（或称为“CTM“，意为当前变换矩阵): 改变你随后指定的绘图命令中的点如何被映射到画布的物理空间。
//
//许多这些属性设置接下来我都会举例说明。
//





//路径与绘图
//通过编写移动虚拟画笔的代码描画一段路径，这样的路径并不构成一个图形。绘制路径意味着对路径描边或填充该路径，也或者两者都做。同样，你应该从某些绘图程序中得到过相似的体会。
//
//一段路径是由点到点的描画构成。想象一下绘图系统是你手里的一只画笔，你首先必须要设置画笔当前所处的位置，然后给出一系列命令告诉画笔如何描画随后的每段路径。每一段新增的路径开始于当前点，当完成一条路径的描画，路径的终点就变成了当前点。
//
//下面列出了一些路径描画的命令：
//
//定位当前点
//CGContextMoveToPoint
//
//描画一条线
//CGContextAddLineToPoint、CGContextAddLines
//
//描画一个矩形
//CGContextAddRect、CGContextAddRects
//
//描画一个椭圆或圆形
//CGContextAddEllipseInRect
//
//描画一段圆弧
//CGContextAddArcToPoint、CGContextAddArc
//
//通过一到两个控制点描画一段贝赛尔曲线
//CGContextAddQuadCurveToPoint、CGContextAddCurveToPoint
//
//关闭当前路径
//CGContextClosePath 这将从路径的终点到起点追加一条线。如果你打算填充一段路径，那么就不需要使用该命令，因为该命令会被自动调用。
//
//描边或填充当前路径
//CGContextStrokePath、CGContextFillPath、CGContextEOFillPath、CGContextDrawPath。对当前路径描边或填充会清除掉路径。如果你只想使用一条命令完成描边和填充任务，可以使用CGContextDrawPath命令，因为如果你只是使用CGContextStrokePath对路径描边，路径就会被清除掉，你就不能再对它进行填充了。
//

//创建路径并描边路径或填充路径只需一条命令就可完成的函数：CGContextStrokeLineSegments、CGContextStrokeRect、CGContextStrokeRectWithWidth、CGContextFillRect、CGContextFillRects、CGContextStrokeEllipseInRect、CGContextFillEllipseInRect。
//
//一段路径是被合成的，意思是它是由多条独立的路径组成。举个例子，一条单独的路径可能由两个独立的闭合形状组成：一个矩形和一个圆形。当你在构造一条路径的中间过程（意思是在描画了一条路径后没有调用描边或填充命令，或调用CGContextBeginPath函数来清除路径）调用CGContextMoveToPoint函数，就像是你拾起画笔，并将画笔移动到一个新的位置，如此来准备开始一段独立的相同路径。如果你担心当你开始描画一条路径的时候，已经存在的路径和新的路径会被认为是已存在路径的一个合成部分，你可以调用CGContextBeginPath函数指定你绘制的路径是一条独立的路径；苹果的许多例子都是这样做的，但在实际开发中我发现这是非必要的。



//CGContextClearRect函数的功能是擦除一个区域。这个函数会擦除一个矩形内的所有已存在的绘图；并对该区域执行裁剪。结果像是打了一个贯穿所有已存在绘图的孔。



//CGContextClearRect函数的行为依赖于上下文是透明还是不透明。当在图形上下文中绘图时，这会尤为明显和直观。如果图片上下文是透明的（UIGraphicsBeginImageContextWithOptions第二个参数为NO），那么CGContextClearRect函数执行擦除后的颜色为透明，反之则为黑色。



//当在一个视图中直接绘图（使用drawRect：或drawLayer：inContext：方法），如果视图的背景颜色为nil或颜色哪怕有一点点透明度，那么CGContextClearRect的矩形区域将会显示为透明的，打出的孔将穿过视图包括它的背景颜色。如果背景颜色完全不透明，那么CGContextClearRect函数的结果将会是黑色。这是因为视图的背景颜色决定了是否视图的图形上下文是透明的还是不透明的。


//图5 CGContextClearRect函数的应用


//如图5，在左边的蓝色正方形被挖去部分留为黑色，然而在右边的蓝色正方形也被挖去部分留为透明。但这两个正方形都是UIView子类的实例，采用相同的绘图代码！不同之处在于视图的背景颜色，左边的正方形的背景颜色在nib文件中


//但是这却完全改变了CGContextClearRect函数的效果。UIView子类的drawRect：方法看起来像这样：


//一个简单的路径绘图
-(void)drawRect:(CGRect)rect{

    CGContextRef con = UIGraphicsGetCurrentContext();
    
    // 绘制一个黑色的垂直黑色线，作为箭头的杆子
    CGContextMoveToPoint(con, 100, 100);
    
    CGContextAddLineToPoint(con, 100, 19);
    
    CGContextSetLineWidth(con, 20);
    
    CGContextStrokePath(con);
    
    // 绘制一个红色三角形箭头
    CGContextSetFillColorWithColor(con, [UIColor redColor].CGColor);
    
    CGContextMoveToPoint(con, 80, 25);
    
    CGContextAddLineToPoint(con, 100, 0);
    
    CGContextAddLineToPoint(con, 120, 25);
    
    CGContextFillPath(con);
    
    
    // 从箭头杆子上裁掉一个三角形，使用清除混合模式
    CGContextMoveToPoint(con, 90, 101);
    
    CGContextAddLineToPoint(con, 100, 90);
    
    CGContextAddLineToPoint(con, 110, 101);
    
    CGContextSetBlendMode(con, kCGBlendModeClear);
    
    CGContextFillPath(con);
    
    
}



@end
