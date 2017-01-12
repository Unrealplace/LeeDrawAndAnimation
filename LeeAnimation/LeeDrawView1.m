//
//  LeeDrawView1.m
//  LeeAnimation
//
//  Created by LiYang on 17/1/5.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "LeeDrawView1.h"
#import "LeeLayer.h"

@implementation leeLayerDelegate

 
@end

@interface LeeDrawView1()

@end

@implementation LeeDrawView1

//两种方式的对比
//
//UIKit 也是基于 Core Graphics 的,是对 Core Graphics 的一种封装,使用起来更简便, Core Graphics 的功能更强大但也更复杂.
//UIKit 只能基于当前Context绘制,可以通过 UIGraphicsGetCurrentContext 函数获得当前的图形上下文。

//a. UIKit
//这种方式就是对 Core Graphics 方式的一种简化封装,你可以用面向对象的方式很方便的做各种绘图操作,主要是通过 UIBezierPath 这个类来实现的, UIBezierPath 可以创建基于矢量的路径,例如各种直线,曲线,圆等等
//b. Core Graphics
//这种方式使用起来要比 UIKit 方式复杂一些,它是面向过程的,它的每一个绘图函数都需要传入一个context对象,如果你当前位于UIGraphicsBeginImageContextWithOptions函数或drawRect：方法中，并没有引用一个上下文。为了使用 Core Graphics ，你可以调用UIGraphicsGetCurrentContext函数获得当前的图形上下文。

//3. 六种绘图形式
//至此，我们有了两大绘图框架的支持以及三种获得图形上下文的方法 (drawRect:、drawRect: inContext:、UIGraphicsBeginImageContextWithOptions) 。那么我们就有6种绘图的形式:


#pragma mark - 1.drawRect-直接利用UIKit提供的绘图方法
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    NSLog(@"2-drawRect:");
//    NSLog(@"CGContext:%@",UIGraphicsGetCurrentContext());//得到的当前图形上下文正是drawLayer中传递的
//    //得到这个矩形（Rect）的内切椭圆
//    //根据测试看出来stroke在Rect范围外，填充内容在Rect范围内
//    UIBezierPath* p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,100,200)];
////    UIBezierPath* p = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0,0,100,200) cornerRadius:100];
//    p.lineWidth = 18;
//    [[UIColor blueColor] setStroke];
//    [[UIColor redColor]setFill];
//    [p stroke];
//    [p fill];
//}


#pragma mark - 2.drawRect-利用Core Graphics实现绘图方法，可通过UIGraphicsGetCurrentContext获得当前上下文
//-(void)drawRect:(CGRect)rect {
//    NSLog(@"2-drawRect:");
//    CGContextRef con = UIGraphicsGetCurrentContext();
//     NSLog(@"CGContext:%@",con);//得到的当前图形上下文正是drawLayer中传递的
//
//    CGContextSetLineWidth(con,18);
////    CGContextSetStrokeColorWithColor(con, [UIColor redColor].CGColor);//红色
//    CGContextSetRGBStrokeColor(con, 1, 1, 0, 1);//与上面方法等价 黄色
//    CGContextAddEllipseInRect(con, CGRectMake(0,0,100,200));//画椭圆
////    CGContextSetFillColorWithColor(con, [UIColor greenColor].CGColor);//绿色
//    CGContextSetRGBFillColor(con, 0, 0, 1, 1);//与上面方法等价 蓝色
//
//    //kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
//
////    CGContextStrokePath(con);//对应CGContextDrawPath(con,kCGPathStroke);只画边框没有填充（无填充和有填充但填充没设置颜色默认黑色是不一样的）
////    CGContextFillPath(con);//对应CGContextDrawPath(con,kCGPathFill);只填充无边框
//    CGContextDrawPath(con,kCGPathFillStroke);//既有填充又有边框
//}

//-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
//
//    NSLog(@"1-drawLayer:inContext:");
//    NSLog(@"CGContext:%@",ctx);
//    [super drawLayer:layer inContext:ctx];
//
//}

//第三种绘图形式：我将在UIView子类的drawLayer:inContext：方法中实现绘图任务。drawLayer:inContext：方法是一个绘制图层内容的代理方法。为了能够调用drawLayer:inContext：方法，我们需要设定图层的代理对象。但要注意，不应该将UIView对象设置为显示层的委托对象，这是因为UIView对象已经是隐式层的代理对象，再将它设置为另一个层的委托对象就会出问题。轻量级的做法是：编写负责绘图形的代理类。在MyView.h文件中声明如下代码：

#pragma mark - 3.drawLayer:inContext-利用UIKit提供的绘图方法,需将该context转为当前上下文。[super drawLayer:inContext:]会触发drawRect方法，若drawRect未实现，drawLayer也不会被调用。
//-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
//   [super drawLayer:layer inContext:ctx];
//    NSLog(@"1-drawLayer:inContext:");
//    NSLog(@"CGContext:%@",ctx);
//    UIGraphicsPushContext(ctx);//必加
//    UIBezierPath* p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,100,100)];
//    [[UIColor blueColor] setFill];
//    [p fill];
//    UIGraphicsPopContext();
//
//
//}


#pragma mark - 4.drawLayer:inContext-利用Core Graphics提供的绘图方法，ctx直接引用
//CALayerDelegate
//-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
//    [super drawLayer:layer inContext:ctx];
//    NSLog(@"1-drawLayer:inContext:");
//    NSLog(@"CGContext:%@",ctx);
//    CGContextAddEllipseInRect(ctx, CGRectMake(0,0,100,100));
//    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
//    CGContextFillPath(ctx);
//}


#pragma mark - 5.UIGraphicsBeginImageContextWithOptions绘图方法 －drawRect- UIKit实现
//-(void)drawRect:(CGRect)rect
//{
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100,100), NO, 0);
//    UIBezierPath* p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,100,100)];
//    [[UIColor purpleColor] setFill];
//    [p fill];
//    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [self addSubview:[[UIImageView alloc]initWithImage:im]];
//}

#pragma mark - 6.UIGraphicsBeginImageContextWithOptions绘图方法 －drawRect- Core Graphics实现
//-(void)drawRect:(CGRect)rect
//{
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100,100), NO, 0);
//    CGContextRef con = UIGraphicsGetCurrentContext();
//    CGContextAddEllipseInRect(con, CGRectMake(0,0,100,100));
//    CGContextSetFillColorWithColor(con, [UIColor blueColor].CGColor);
//    CGContextFillPath(con);
//    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//[self addSubview:[[UIImageView alloc]initWithImage:im]];
//}

#pragma mark - 7.UIGraphicsBeginImageContextWithOptions绘图方法 －drawLayer:inContext- UIKit实现
//-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
//    
//        UIGraphicsBeginImageContextWithOptions(CGSizeMake(100,100), NO, 0);
//        UIBezierPath* p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,100,100)];
//        [[UIColor purpleColor] setFill];
//        [p fill];
//        UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        [self addSubview:[[UIImageView alloc]initWithImage:im]];
//    
//}

//-(void)drawRect:(CGRect)rect{}

#pragma mark - 8.UIGraphicsBeginImageContextWithOptions绘图方法 －drawLayer:inContext- Core Graphics实现

//-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
//
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100,100), NO, 0);
//        CGContextRef con = UIGraphicsGetCurrentContext();
//        CGContextAddEllipseInRect(con, CGRectMake(0,0,100,100));
//        CGContextSetFillColorWithColor(con, [UIColor blueColor].CGColor);
//        CGContextFillPath(con);
//        UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//    [self addSubview:[[UIImageView alloc]initWithImage:im]];
//}
#pragma mark - 9.如果self.layer add了一个子layer，并调用[sublayer setNeedsDisplay];则会触发CALayer的drawInContext方法
/*可以看出当一个view被addsubview到其他view上时
 1.先隐式地把此view的layer的CALayerDelegate设置成此view
 2.调用此view的self.layer的drawInContext方法
 3.由于drawLayer方法的注释 If defined, called by the default implementation of -drawInContext:
 说明了drawInContext里if([self.delegate responseToSelector:@selector(drawLayer:inContext:)])时就执行drawLayer:inContext:方法，这里我们因为实现了drawLayer:inContext:所以会执行
 4.[super drawLayer:layer inContext:ctx]会让系统自动调用此view的drawRect:方法
 至此self.layer画出来了
 5.在self.layer上再加一个子layer，当调用[layer setNeedsDisplay];时会自动调用此layer的drawInContext方法。drawInContext方法不能手动调用，只能通过这个方法让系统自动调用
 6.如果drawRect不重写，就不会调用其layer的drawInContext方法，也就不会调用drawLayer:inContext方法*/

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        LeeLayer *layer=[[LeeLayer alloc]init];
        layer.bounds=CGRectMake(0, 0, 185, 185);
        layer.position=CGPointMake(160,284);
        layer.backgroundColor=[UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
        
        //显示图层
        [layer setNeedsDisplay];
        NSLog(@"before addsublayer");
        [self.layer addSublayer:layer];
    }
    return self;
    
}


//如果drawRect不重写，就不会调用其layer的drawInContext方法，也就不会调用drawLayer:inContext方法
//-(void)drawRect:(CGRect)rect{
//    NSLog(@"2-drawRect:");
//    NSLog(@"drawRect里的CGContext:%@",UIGraphicsGetCurrentContext());//得到的当前图形上下文正是drawLayer中传递过来的
//    [super drawRect:rect];
//    
//}


#pragma mark - CALayer delegate
//-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
//    
//    NSLog(@"1-drawLayer:inContext:");
//    NSLog(@"drawLayer里的CGContext:%@",ctx);
//    [super drawLayer:layer inContext:ctx];// 如果去掉此句就不会执行drawRect!!!!!!!!
//}


//*****************************************//
// UIView的setNeedsDisplay和setNeedsLayout方法。
//1.首先两个方法都是异步执行的。
//2.setNeedsDisplay会调用自动调用drawRect方法，这样可以拿到UIGraphicsGetCurrentContext，就可以画画了。
//3.setNeedsLayout会默认调用layoutSubViews，就可以处理子视图中的一些数据。
//综上两个方法都是异步执行的，layoutSubviews方便数据计算，drawRect方便视图重绘。
//*****************************************//
//*****************************************//

//先大概看下ios layout机制相关的这几个方法：
//
//- (CGSize)sizeThatFits:(CGSize)size
//
//- (void)sizeToFit
//
//——————-
//
//
//- (void)layoutIfNeeded
//
//- (void)setNeedsLayout
//
//- (void)layoutSubviews

//——————–
//
//- (void)setNeedsDisplay
//
//- (void)drawRect

//*****************************************//
//*****************************************//

//一、
//layoutSubviews在以下情况下会被调用：
//
//1、init初始化不会触发layoutSubviews。
//
//2、addSubview会触发layoutSubviews。
//
//3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化。
//
//4、滚动一个UIScrollView会触发layoutSubviews。
//
//5、旋转Screen会触发父UIView上的layoutSubviews事件。
//
//6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件。
//
//7、直接调用setLayoutSubviews。
//
//8、直接调用setNeedsLayout。
//
//在苹果的官方文档中强调:You should override this method only if the autoresizing behaviors of the subviews do not offer the behavior you want.
//
//layoutSubviews, 当我们在某个类的内部调整子视图位置时，需要调用。
//
//反过来的意思就是说：如果你想要在外部设置subviews的位置，就不要重写。
//
//
//
//刷新子对象布局
//
//-layoutSubviews方法：这个方法，默认没有做任何事情，需要子类进行重写
//
//-setNeedsLayout方法： 标记为需要重新布局，异步调用layoutIfNeeded刷新布局，不立即刷新，但layoutSubviews一定会被调用
//-layoutIfNeeded方法：如果，有需要刷新的标记，立即调用layoutSubviews进行布局（如果没有标记，不会调用layoutSubviews）
//
//如果要立即刷新，要先调用[view setNeedsLayout]，把标记设为需要布局，然后马上调用[view layoutIfNeeded]，实现布局
//
//在视图第一次显示之前，标记总是“需要刷新”的，可以直接调用[view layoutIfNeeded]

//*****************************************//
//*****************************************//


//二、
//drawRect在以下情况下会被调用：
//
//1、如果在UIView初始化时没有设置rect大小，将直接导致drawRect不被自动调用。drawRect 掉用是在Controller->loadView, Controller->viewDidLoad 两方法之后掉用的.所以不用担心在 控制器中,这些View的drawRect就开始画了.这样可以在控制器中设置一些值给View(如果这些View draw的时候需要用到某些变量 值).
//
//2、该方法在调用sizeToFit后被调用，所以可以先调用sizeToFit计算出size。然后系统自动调用drawRect:方法。
//
//sizeToFit会自动调用sizeThatFits方法；
//
//sizeToFit不应该在子类中被重写，应该重写sizeThatFits
//
//sizeThatFits传入的参数是receiver当前的size，返回一个适合的size
//
//sizeToFit可以被手动直接调用
//
//sizeToFit和sizeThatFits方法都没有递归，对subviews也不负责，只负责自己
//
//3、通过设置contentMode属性值为UIViewContentModeRedraw。那么将在每次设置或更改frame的时候自动调用drawRect:。
//
//4、直接调用setNeedsDisplay，或者setNeedsDisplayInRect:触发drawRect:，但是有个前提条件是rect不能为0。
//
//-setNeedsDisplay方法：标记为需要重绘，异步调用drawRect
//
//-setNeedsDisplayInRect:(CGRect)invalidRect方法：标记为需要局部重绘


//以上1,2推荐；而3,4不提倡
//
//drawRect方法使用注意点：
//
//1、 若使用UIView绘图，只能在drawRect：方法中获取相应的contextRef并绘图。如果在其他方法中获取将获取到一个invalidate 的ref并且不能用于画图。drawRect：方法不能手动显示调用，必须通过调用setNeedsDisplay 或 者 setNeedsDisplayInRect，让系统自动调该方法。
//
//2、若使用calayer绘图，只能在drawInContext: 中（类似鱼drawRect）绘制，或者在delegate中的相应方法绘制。同样也是调用setNeedDisplay等间接调用以上方法
//
//3、若要实时画图，不能使用gestureRecognizer，只能使用touchbegan等方法来掉用setNeedsDisplay实时刷新屏幕

//*****************************************//
//*****************************************//

//三、
//layoutSubviews对subviews重新布局
//
//layoutSubviews方法调用先于drawRect
//
//setNeedsLayout在receiver标上一个需要被重新布局的标记，在系统runloop的下一个周期自动调用layoutSubviews
//
//layoutIfNeeded方法如其名，UIKit会判断该receiver是否需要layout.根据Apple官方文档,layoutIfNeeded方法应该是这样的
//
//layoutIfNeeded遍历的不是superview链，应该是subviews链
//
//drawRect是对receiver的重绘，能获得context
//
//setNeedDisplay在receiver标上一个需要被重新绘图的标记，在下一个draw周期自动重绘，iphone device的刷新频率是60hz，也就是1/60秒后重绘
//*****************************************//
//*****************************************//


//layoutsubview和viewDidlayoutsubview(控制器）被调用的集中情况
//                                   
// 一：当view的frame或bounds发生改变
//                                   
// 1：直接改view的frame或bounds 会调用view中layoutsubview
//                                   
// 2:当屏幕旋转的时候，视图控制器中根view发生变化，会调用视图控制中viewDidLayoutsuview）
//                                   
//  二：在当前view上addsubvie添加子view，会调用view中layoutSubview
//                                   
//  三：改变view的大小的时候，会触发父view的layoutsubview被调用
//                                   
//  四：当UIScroller中滚动的时候，会调用自身layoutsubview.


@end
