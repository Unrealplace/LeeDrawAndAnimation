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


//1 一个简单的路径绘图
//-(void)drawRect:(CGRect)rect{
//
//    CGContextRef con = UIGraphicsGetCurrentContext();
//    
//    // 绘制一个黑色的垂直黑色线，作为箭头的杆子
//    
//    CGContextMoveToPoint(con, 100, 100);
//    
//    CGContextAddLineToPoint(con, 100, 19);
//    
//    CGContextSetLineWidth(con, 20);
//    
//    CGContextStrokePath(con);
//    
//    // 绘制一个红色三角形箭头
//    
//    CGContextSetFillColorWithColor(con, [[UIColor redColor] CGColor]);
//    
//    CGContextMoveToPoint(con, 80, 25);
//    
//    CGContextAddLineToPoint(con, 100, 0);
//    
//    CGContextAddLineToPoint(con, 120, 25);
//    
//    CGContextFillPath(con);
//    
//    // 从箭头杆子上裁掉一个三角形，使用清除混合模式
//    
//    CGContextMoveToPoint(con, 90, 100);
//    
//    CGContextAddLineToPoint(con, 100, 70);
//    
//    CGContextAddLineToPoint(con, 110, 100);
//    
//    CGContextSetBlendMode(con, kCGBlendModeClear);
//    
//    CGContextFillPath(con);
//
//    
//}

//如果一段路径需要重用或共享，你可以将路径封装为CGPath（具体类型是CGPathRef）。你可以创建一个新的CGMutablePathRef对象并使用多个类似于图形的路径函数的CGPath函数构造路径，或者使用CGContextCopyPath函数复制图形上下文的当前路径。有许多CGPath函数可用于创建基于简单几何形状的路径（CGPathCreateWithRect、CGPathCreateWithEllipseInRect）或基于已存在路径（CGPathCreateCopyByStrokingPath、CGPathCreateCopyDashingPath、CGPathCreateCopyByTransformingPath）。


//UIKit的UIBezierPath类包装了CGPath。它提供了用于绘制某种形状路径的方法，以及用于描边、填充、存取某些当前上下文状态的设置方法。类似地，UIColor提供了用于设置当前上下文描边与填充的颜色。因此我们可以重写我们之前绘制箭头的代码：
//2 UIBezierPath 绘制
//-(void)drawRect:(CGRect)rect{
//
//    UIBezierPath * p = [UIBezierPath bezierPath];
//    [p moveToPoint:CGPointMake(100, 100)];
//    [p addLineToPoint:CGPointMake(100, 19)];
//    [p setLineWidth:20];
//    [p stroke];
//    
//    [[UIColor redColor] setFill];
//    [p removeAllPoints];
//    [p moveToPoint:CGPointMake(80, 25)];
//    [p addLineToPoint:CGPointMake(100, 0)];
//    [p addLineToPoint:CGPointMake(120, 25)];
//    [p fill];
//    
//    [p removeAllPoints];
//    [p moveToPoint:CGPointMake(90, 101)];
//    [p addLineToPoint:CGPointMake(100, 90)];
//    [p addLineToPoint:CGPointMake(110, 101)];
//    [p fillWithBlendMode:kCGBlendModeClear alpha:1.0];
//    
//}
//在这种特殊情况下，完成同样的工作并没有节省多少代码，但是UIBezierPath仍然还是有用的。如果你需要对象特性，UIBezierPath提供了一个便利方法：bezierPathWithRoundedRect：cornerRadius：，它可用于绘制带有圆角的矩形，如果是使用Core Graphics就相当冗长乏味了。还可以只让圆角出现在左上角和右上角。
//3绘制圆角的图像
//-(void)drawRect:(CGRect)rect{
//
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//   // core graphics 方式改变画笔描边颜色
//    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
//    
//    CGContextSetLineWidth(ctx, 3);
//    
//    UIBezierPath * path;
//    
//    path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 100, 100) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
//    
//    //uikit 的方式改变画笔填充颜色
//    [[UIColor purpleColor] setFill];
//    
//
//    
//    [path fill];
//    [path stroke];
//
//    
//}


//裁剪
//路径的另一用处是遮蔽区域，以防对遮蔽区域进一步绘图。这种用法被称为裁剪。裁剪区域外的图形不会被绘制到。默认情况下，一个图形上下文的裁剪区域是整个图形上下文。你可在上下文中的任何地方绘图。
//
//总的来说，裁剪区域是上下文的一个特性。与已存在的裁剪区域相交会出现新的裁剪区域。所以如果你应用了你自己的裁剪区域，稍后将它从图形上下文中移除的做法是使用CGContextSaveGState和CGContextRestoreGState函数将代码包装起来。
//
//为了便于说明这一点，我使用裁剪而不是使用混合模式在箭头杆子上打孔的方法重写了生成箭头的代码。这样做有点小复杂，因为我们想要裁剪区域不在三角形内而在三角形外部。为了表明这一点，我们使用了一个三角形和一个矩形组成了一个组合路径。
//
//当填充一个组合路径并使用它表示一个裁剪区域时，系统遵循以下两规则之一：
//
//环绕规则（Winding rule）环绕规则 CGContextClip
//如果边界是顺时针绘制，那么在其内部逆时针绘制的边界所包含的内容为空。如果边界是逆时针绘制，那么在其内部顺时针绘制的边界所包含的内容为空。

//// 逆时针 绘制的案例
//CGContextMoveToPoint(con, 0, 0);
//CGContextAddLineToPoint(con, 0, 200);
//CGContextAddLineToPoint(con, 200, 200);
//CGContextAddLineToPoint(con, 200, 0);
//CGContextAddLineToPoint(con, 0, 0);
//
//// 顺时针 绘制的案例
//CGContextMoveToPoint(con, 50, 50);
//CGContextAddLineToPoint(con, 150, 50);
//CGContextAddLineToPoint(con, 150, 150);
//CGContextAddLineToPoint(con, 50, 150);
//CGContextAddLineToPoint(con, 50, 50);


//奇偶规则 奇偶规则 CGContextEOClip
//最外层的边界代表内部都有效，都要填充；之后向内第二个边界代表它的内部无效，不需填充；如此规则继续向内寻找边界线。我们的情况非常简单，所以使用奇偶规则就很容易了。这里我们使用CGContextEOCllip设置裁剪区域然后进行绘图。（如果不是很明白，可以参见这篇文章：五种方法绘制有孔的2d形状）

//4 使用奇偶裁剪绘图
//-(void)drawRect:(CGRect)rect{
//
//    CGContextRef con = UIGraphicsGetCurrentContext();
//    
//    // 在上下文裁剪区域中挖一个三角形状的孔
//    
//    CGContextMoveToPoint(con, 90, 100);
//    
//    CGContextAddLineToPoint(con, 100, 90);
//    
//    CGContextAddLineToPoint(con, 110, 100);
//    
//    CGContextClosePath(con);
//    
//    CGContextAddRect(con, CGContextGetClipBoundingBox(con));
//    
//    // 使用奇偶规则，裁剪区域为矩形减去三角形区域
//    
//    CGContextEOClip(con);
//    
//    // 绘制垂线
//    
//    CGContextMoveToPoint(con, 100, 100);
//    
//    CGContextAddLineToPoint(con, 100, 19);
//    
//    CGContextSetLineWidth(con, 20);
//    
//    CGContextStrokePath(con);
//    
//    // 画红色箭头
//    
//    CGContextSetFillColorWithColor(con, [[UIColor redColor] CGColor]);
//    
//    CGContextMoveToPoint(con, 80, 25);
//    
//    CGContextAddLineToPoint(con, 100, 0);
//    
//    CGContextAddLineToPoint(con, 120, 25);
//    
//    CGContextFillPath(con);
//}

//5 使用 CGMutablePathRef 路径
//-(void)drawRect:(CGRect)rect{
//
//    //1.取得图形上下文对象
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    //2.创建路径对象
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, nil, 20, 50);//移动到指定位置（设置路径起点）
//    CGPathAddLineToPoint(path, nil, 20, 100);//绘制直线（从起始位置开始）
//    CGPathAddLineToPoint(path, nil, 300, 100);//绘制另外一条直线（从上一直线终点开始绘制）
//    
//    
//    
//    //3.添加路径到图形上下文
//    CGContextAddPath(context, path);
//    
//    //4.设置图形上下文状态属性
//    CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1);//设置笔触颜色
//    CGContextSetRGBFillColor(context, 0, 1.0, 0, 1);//设置填充色
//    CGContextSetLineWidth(context, 2.0);//设置线条宽度
//    CGContextSetLineCap(context, kCGLineCapRound);//设置顶点样式,（20,50）和（300,100）是顶点
//    CGContextSetLineJoin(context, kCGLineJoinRound);//设置连接点样式，(20,100)是连接点
//    /*设置线段样式
//     phase:虚线开始的位置
//     lengths:虚线长度间隔（例如下面的定义说明第一条线段长度8，然后间隔3重新绘制8点的长度线段，当然这个数组可以定义更多元素）
//     count:虚线数组元素个数
//     */
//    CGFloat lengths[2] = { 18, 9 };
//    CGContextSetLineDash(context, 0, lengths, 2);
//    /*设置阴影
//     context:图形上下文
//     offset:偏移量
//     blur:模糊度
//     color:阴影颜色
//     */
//    CGColorRef color = [UIColor grayColor].CGColor;//颜色转化，由于Quartz 2D跨平台，所以其中不能使用UIKit中的对象，但是UIkit提供了转化方法
//    CGContextSetShadowWithColor(context, CGSizeMake(2, 2), 0.8, color);
//    
//    //5.绘制图像到指定图形上下文
//    /*CGPathDrawingMode是填充方式,枚举类型
//     kCGPathFill:只有填充（非零缠绕数填充），不绘制边框
//     kCGPathEOFill:奇偶规则填充（多条路径交叉时，奇数交叉填充，偶交叉不填充）
//     kCGPathStroke:只有边框
//     kCGPathFillStroke：既有边框又有填充
//     kCGPathEOFillStroke：奇偶填充并绘制边框
//     */
//    CGContextDrawPath(context, kCGPathFillStroke);//最后一个参数是填充类型
//    
//    //6.释放对象
//    CGPathRelease(path);
//}

//-(void)drawRect:(CGRect)rect{
//
//    //从Bundle中读取图片
//    UIImage *srcImg = [UIImage imageNamed:@"222"];
//    CGFloat width = srcImg.size.width;
//    CGFloat height = srcImg.size.height;
//    
//    //开始绘制图片
//    UIGraphicsBeginImageContext(srcImg.size);
//    CGContextRef gc = UIGraphicsGetCurrentContext();
//    
////    接下来绘制Clip区域。使用Quartz中的Path创建操作去绘制一个菱形边框，最后使用CGContextClip函数把当前Path作为Clip区域。
////    
////    把下面代码插入到上方“开始绘制图片”和“坐标系转化”之间。因为如果在画完图后在设置Clip区域那就没有任何意义了
//    //绘制Clip区域
//    CGContextMoveToPoint(gc, width/2, 0);
//    CGContextAddLineToPoint(gc, width, height/2);
//    CGContextAddLineToPoint(gc, width/2, height);
//    CGContextAddLineToPoint(gc, 0, height/2);
//    CGContextClosePath(gc);
//    CGContextClip(gc);
//    
//    
//    //坐标系转换
//    //因为CGContextDrawImage会使用Quartz内的以左下角为(0,0)的坐标系
//    CGContextTranslateCTM(gc, 0, height);
//    CGContextScaleCTM(gc, 1, -1);
//    CGContextDrawImage(gc, CGRectMake(0, 0, width, height), [srcImg CGImage]);
//    
//    //结束绘画
//    UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    //创建UIImageView并显示在界面上
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:destImg];
//    
//    [self addSubview:imgView];
//    
//    
// }


//接下来完成第二个图的效果。第二个图是这样完成的，我们不仅需要加入第一个图绘制的菱形，同时还要把最外层的边框加入到Path中。后者可以通过CGContextGetClipBoundingBox函数直接得到。
//
//接下来需要讲一下Even-Odd规则，这个规则其实在诸多平台的绘图框架中都有使用，都也是用在填充或者Clip操作中的。

//可以看到，所谓Even odd规则就是被偶数条线包围的区域会被填充。
//
//所以，有了外面的大边框，被菱形分割的四个小角就是被偶数条线所包围，Clip会生效。注意使用CGContextEOClip函数来做Even odd模式的Clip操作。

// 6 裁剪图片
//-(void)drawRect:(CGRect)rect{
//
//  
//    //从Bundle中读取图片
//    UIImage *srcImg = [UIImage imageNamed:@"222"];
//    CGFloat width = srcImg.size.width;
//    CGFloat height = srcImg.size.height;
//    
//    //开始绘制图片
//    UIGraphicsBeginImageContext(srcImg.size);
//    CGContextRef gc = UIGraphicsGetCurrentContext();
//    
//    //    接下来绘制Clip区域。使用Quartz中的Path创建操作去绘制一个菱形边框，最后使用CGContextClip函数把当前Path作为Clip区域。
//    //
//    //    把下面代码插入到上方“开始绘制图片”和“坐标系转化”之间。因为如果在画完图后在设置Clip区域那就没有任何意义了
//    //绘制Clip区域
//    //绘制Clip区域
//    CGContextMoveToPoint(gc, width/2, 0);
//    CGContextAddLineToPoint(gc, width, height/2);
//    CGContextAddLineToPoint(gc, width/2, height);
//    CGContextAddLineToPoint(gc, 0, height/2);
//    CGContextClosePath(gc);
//    //加入矩形边框并调用CGContextEOClip函数
//    CGContextAddRect(gc, CGContextGetClipBoundingBox(gc));
//    CGContextEOClip(gc);
//
//    //坐标系转换
//    //因为CGContextDrawImage会使用Quartz内的以左下角为(0,0)的坐标系
//    CGContextTranslateCTM(gc, 0, height);
//    CGContextScaleCTM(gc, 1, -1);
//    CGContextDrawImage(gc, CGRectMake(0, 0, width, height), [srcImg CGImage]);
//    
//    //结束绘画
//    UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    //创建UIImageView并显示在界面上
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:destImg];
//    
//    [self addSubview:imgView];
//    
//}


//渐变
//渐变可以很简单也可以很复杂。一个简单的渐变（接下来要讨论的）由一端点的颜色与另一端点的颜色决定，如果在中间点加入颜色（可选），那么渐变会在上下文的两个点之间线性的绘制或在上下文的两个圆之间放射状的绘制。不能使用渐变作为路径的填充色，但可使用裁剪限制对路径形状的渐变。

// 7 渐变色效果绘制
//-(void)drawRect:(CGRect)rect{
//
//    CGContextRef con = UIGraphicsGetCurrentContext();
//    
//    CGContextSaveGState(con);
//    
//    // 在上下文裁剪区域挖一个三角形孔
//    
//    CGContextMoveToPoint(con, 90, 100);
//    
//    CGContextAddLineToPoint(con, 100, 90);
//    
//    CGContextAddLineToPoint(con, 110, 100);
//    
//    CGContextClosePath(con);
//    
//    //获取裁剪区域 CGContextGetClipBoundingBox(con)
//    CGContextAddRect(con, CGContextGetClipBoundingBox(con));
//    
//    CGContextEOClip(con);
//    
//    //    CGContextEOClip(con);// 奇偶规则
//    //    CGContextClip(con);// 环绕规则
//    //    CGContextClipToRect(con, CGRectMake(0, 0, 100, 100));// 范围内可见（可画）
//    //    CGContextClipToMask(con, CGRectMake(0, 0, 100, 100), alphaMask);// 蒙版，范围内 可见（可画）
//
//    
//    
//    //绘制一个垂线，让它的轮廓形状成为裁剪区域
//    
//    CGContextMoveToPoint(con, 100, 100);
//    
//    CGContextAddLineToPoint(con, 100, 19);
//    
//    CGContextSetLineWidth(con, 20);
//    
//    // 使用路径的描边版本替换图形上下文的路径
//    
//    CGContextReplacePathWithStrokedPath(con);
//    
//    // 对路径的描边版本实施裁剪
//    
//    CGContextClip(con);
//    
//    
//    
//    
//    
//    // 绘制渐变
//    
//    CGFloat locs[3] = { 0.0, 0.5, 1.0 };
//    
//    CGFloat colors[12] = {
//        
//        0.3,0.3,0.3,0.8, // 开始颜色，透明灰
//        
//        0.0,0.0,0.0,1.0, // 中间颜色，黑色
//        
//        0.3,0.3,0.3,0.8 // 末尾颜色，透明灰
//        
//    };
//    
//    CGColorSpaceRef sp = CGColorSpaceCreateDeviceGray();
//    
//    CGGradientRef grad = CGGradientCreateWithColorComponents (sp, colors, locs, 3);
//    
//    CGContextDrawLinearGradient(con, grad, CGPointMake(89,0), CGPointMake(111,0), 0);
//    
//    CGColorSpaceRelease(sp);
//    
//    CGGradientRelease(grad);
//    
//    CGContextRestoreGState(con); // 完成裁剪
//    
//
//    // 绘制红色箭头
//    
//    CGContextSetFillColorWithColor(con, [[UIColor redColor] CGColor]);
//    
//    CGContextMoveToPoint(con, 80, 25);
//    
//    CGContextAddLineToPoint(con, 100, 0);
//    
//    CGContextAddLineToPoint(con, 120, 25);
//    
//    CGContextFillPath(con);
//    
//}

//调用CGContextReplacePathWithStrokedPath函数假装对当前路径描边，并使用当前线段宽度和与线段相关的上下文状态设置。但接着创建的是描边路径外部的一个新的路径。因此，相对于使用粗的线条，我们使用了一个矩形区域作为裁剪区域。
//
//虽然过程比较冗长但是非常的简单；我们将渐变描述为一组在一端点（0.0）和另一端点（1.0）之间连续区上的位置，以及设置与每个位置相对应的颜色。为了提亮边缘的渐变，加深中间的渐变，我使用了三个位置，黑色点的位置是0.5。为了创建渐变，还需要提供一个颜色空间。最后，我创建出了该渐变，并对裁剪区域绘制线性渐变，最后释放了颜色空间和渐变。



//颜色与模板
//在iOS中，CGColor表示颜色（具体类型为CGColorRef）。使用UIColor的colorWithCGColor：和CGColor方法可bridged cast到UIColor。
//
//在iOS中，模板表示为CGPattern（具体类型为CGPatternRef）。你可以创建一个模板并使用它进行描边或填充。其过程是相当复杂的。作为一个非常简单的例子，我将使用红蓝相间的三角形替换箭头的三角形部分。现在移除下面行：
//CGContextSetFillColorWithColor（con， [UIColor redColor].CGColor））；

//8
-(void)drawRect:(CGRect)rect{

        CGContextRef con = UIGraphicsGetCurrentContext();
    
        CGContextSaveGState(con);
    
        // 在上下文裁剪区域挖一个三角形孔
    
        CGContextMoveToPoint(con, 90, 100);
    
        CGContextAddLineToPoint(con, 100, 90);
    
        CGContextAddLineToPoint(con, 110, 100);
    
        CGContextClosePath(con);
    
        //获取裁剪区域 CGContextGetClipBoundingBox(con)
        CGContextAddRect(con, CGContextGetClipBoundingBox(con));
    
        CGContextEOClip(con);
    
        //    CGContextEOClip(con);// 奇偶规则
        //    CGContextClip(con);// 环绕规则
        //    CGContextClipToRect(con, CGRectMake(0, 0, 100, 100));// 范围内可见（可画）
        //    CGContextClipToMask(con, CGRectMake(0, 0, 100, 100), alphaMask);// 蒙版，范围内 可见（可画）
    
    
    
        //绘制一个垂线，让它的轮廓形状成为裁剪区域
    
        CGContextMoveToPoint(con, 100, 100);
    
        CGContextAddLineToPoint(con, 100, 19);
    
        CGContextSetLineWidth(con, 20);
    
        // 使用路径的描边版本替换图形上下文的路径
    
        CGContextReplacePathWithStrokedPath(con);
    
        // 对路径的描边版本实施裁剪
    
        CGContextClip(con);
    
    
    
    
    
        // 绘制渐变
    
        CGFloat locs[3] = { 0.0, 0.5, 1.0 };
    
        CGFloat colors[12] = {
    
            0.3,0.3,0.3,0.8, // 开始颜色，透明灰
    
            0.0,0.0,0.0,1.0, // 中间颜色，黑色
    
            0.3,0.3,0.3,0.8 // 末尾颜色，透明灰
    
        };
    
        CGColorSpaceRef sp = CGColorSpaceCreateDeviceGray();
    
        CGGradientRef grad = CGGradientCreateWithColorComponents (sp, colors, locs, 3);
    
        CGContextDrawLinearGradient(con, grad, CGPointMake(89,0), CGPointMake(111,0), 0);
    
        CGColorSpaceRelease(sp);
    
        CGGradientRelease(grad);
    
        CGContextRestoreGState(con); // 完成裁剪
    
    
        // 绘制红色箭头
        

    CGColorSpaceRef sp2 = CGColorSpaceCreatePattern(NULL);
    
    CGContextSetFillColorSpace (con, sp2);
    
    CGColorSpaceRelease (sp2);
    
    CGPatternCallbacks callback = {0, &drawStripes, NULL };
    
    CGAffineTransform tr = CGAffineTransformIdentity;
    
    CGPatternRef patt = CGPatternCreate(NULL,CGRectMake(0,0,4,4), tr, 4, 4, kCGPatternTilingConstantSpacingMinimalDistortion, true, &callback);
    
    CGFloat alph = 1.0;
    
    CGContextSetFillPattern(con, patt, &alph);
    
    CGPatternRelease(patt);
    
    
        CGContextMoveToPoint(con, 80, 25);
        
        CGContextAddLineToPoint(con, 100, 0);
        
        CGContextAddLineToPoint(con, 120, 25);
        
        CGContextFillPath(con);
    
}


void drawStripes (void *info, CGContextRef con) {
    
    // assume 4 x 4 cell
    
    CGContextSetFillColorWithColor(con, [[UIColor redColor] CGColor]);
    
    CGContextFillRect(con, CGRectMake(0,0,4,4));
    
    CGContextSetFillColorWithColor(con, [[UIColor blueColor] CGColor]);
    
    CGContextFillRect(con, CGRectMake(0,0,4,2));
    
}

@end
