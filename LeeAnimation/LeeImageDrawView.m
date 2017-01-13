
//
//  LeeImageDrawView.m
//  demoView
//
//  Created by mac on 17/1/12.
//  Copyright © 2017年 Oliver. All rights reserved.
//

#import "LeeImageDrawView.h"

@implementation LeeImageDrawView

//但是在iphone的Retina屏幕上，如你使用UIGraphicsBeginImageContext这个方法来获取图形上下文进行绘制的话就会出现你绘制出来的图片相当的模糊，其实原因很简单
//
//因为 UIGraphicsBeginImageContext(size) = UIGraphicsBeginImageContextWithOptions(size,NO,1.0)
//
//那么UIGraphicsBeginImageContextWithOptions这个方法里面有3个属性，一个是size就是绘制的范围，还有一个是opaque,也就是这个图层是否完全透明，一般情况下最好设置为YES，这样可以让图层在渲染的时候效率更高。最关键的一个就是scale这个参数，那么这个参数的意思就是缩放比例，一般是1.0但是如果是在Retina屏幕上最好不要自己手动打个设置他的缩放比例，直接设置0，系统就会自动进行最佳的缩放

//移动图片在绘制
//-(void)drawRect:(CGRect)rect{
//
//    UIImage * image = [UIImage imageNamed:@"屏幕快照 2017-01-12 15.18.08"];
//    CGSize   sz     = image.size;
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width * 2, sz.height), YES, 0.0);
//    
//    [image drawAtPoint:CGPointMake(0, 0)];
//    
//    [image drawAtPoint:CGPointMake(sz.width, 0)];
//    
//    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    UIImageView * newImageV = [[UIImageView alloc] initWithImage:newImage];
// 
//    [self addSubview:newImageV];
//    
//}

//相当于图片的缩放操作了
//-(void)drawRect:(CGRect)rect{
//    
//    UIImage * image = [UIImage imageNamed:@"屏幕快照 2017-01-12 15.18.08"];
//    CGSize   sz     = image.size;
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width * 2, sz.height*2), YES, 0.0);
//    
//    [image drawInRect:CGRectMake(0, 0, sz.width * 2, sz.height*2)];
//    
//    [image drawInRect:CGRectMake(sz.width / 2.0f, sz.height/2.0f, sz.width, sz.height)];
//    
//    
//    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    UIImageView * newImageV = [[UIImageView alloc] initWithImage:newImage];
//    
//    [self addSubview:newImageV];
//    
//}

//相当于图片的裁剪
//UIImage没有提供截取图片指定区域的功能。但通过创建一个较小的图形上下文并移动图片到一个适当的图形上下文坐标系内，指定区域内的图片就会被获取

//-(void)drawRect:(CGRect)rect{
//
//        UIImage * image = [UIImage imageNamed:@"屏幕快照 2017-01-12 15.18.08"];
//        CGSize   sz     = image.size;
//        UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width / 2, sz.height), YES, 0.0);
//    
//
//        [image drawAtPoint:CGPointMake(- sz.width /2, 0)];
//
//    
//    
//        UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//        UIGraphicsEndImageContext();
//    
//        UIImageView * newImageV = [[UIImageView alloc] initWithImage:newImage];
//        
//        [self addSubview:newImageV];
//}

//CGImage常用的绘图操作
//UIImage的Core Graphics版本是CGImage（具体类型是CGImageRef）。两者可以直接相互转化: 使用UIImage的CGImage属性可以访问Quartz图片数据；将CGImage作为UIImage方法imageWithCGImage:或initWithCGImage:的参数创建UIImage对象。
//
//一个CGImage对象可以让你获取原始图片中指定区域的图片（也可以获取指定区域外的图片，UIImage却办不到）。


//你也许发现绘出的图是上下颠倒的！图片的颠倒并不是因为被旋转了。当你创建了一个CGImage并使用CGContextDrawImage方法绘图就会引起这种问题。这主要是因为原始的本地坐标系统（坐标原点在左上角）与目标上下文（坐标原点在左下角）不匹配。有很多方法可以修复这个问题，其中一种方法就是使用CGContextDrawImage方法先将CGImage绘制到UIImage上，然后获取UIImage对应的CGImage，此时就得到了一个倒转的CGImage。当再调用CGContextDrawImage方法，我们就将倒转的图片还原回来了。实现代码如下：

//-(void)drawRect:(CGRect)rect{
//
//    UIImage* mars = [UIImage imageNamed:@"屏幕快照 2017-01-12 15.18.08"];
//    
//    // 抽取图片的左右半边
//    
//    CGSize sz = [mars size];
//    
//    
//    CGImageRef marsLeft1 = CGImageCreateWithImageInRect([mars CGImage],CGRectMake(0,0,sz.width/2.0,sz.height));
//    
//    CGImageRef marsRight1 = CGImageCreateWithImageInRect([mars CGImage],CGRectMake(sz.width/2.0,0,sz.width/2.0,sz.height));
//    
//    // 将每一个CGImage绘制到图形上下文中
//    
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width*1.5, sz.height), NO, 0);
//    
//    //获得设置好的绘图上下文
//    CGContextRef con = UIGraphicsGetCurrentContext();
//    
//    CGContextDrawImage(con, CGRectMake(0,0,sz.width/2.0,sz.height), flip(marsLeft1));
//    
//    CGContextDrawImage(con, CGRectMake(sz.width,0,sz.width/2.0,sz.height), flip(marsRight1));
//    
//    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    // 记得释放内存，ARC在这里无效 
//    
//    CGImageRelease(marsLeft1);
//    
//    CGImageRelease(marsRight1);
//    
//    UIImageView * newImageV = [[UIImageView alloc] initWithImage:im];
//    
//    [self addSubview:newImageV];
//}




//倒转绘制方法.相当于绘制两次负负得正了
 CGImageRef flip (CGImageRef im) {
    
    CGSize sz = CGSizeMake(CGImageGetWidth(im), CGImageGetHeight(im));
    
    UIGraphicsBeginImageContextWithOptions(sz, NO, 0);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, sz.width, sz.height), im);
    
    CGImageRef result = [UIGraphicsGetImageFromCurrentImageContext() CGImage];
    
    UIGraphicsEndImageContext();
    
    return result; 
    
}

//上面的代码初看上去很繁杂，不过不用担心，这里还有另一种修复倒置问题的方案。相对于使用flip函数，你可以在绘图之前将CGImage包装进UIImage中，这样做有两大优点：
//1.当UIImage绘图时它会自动修复倒置问题
//2.当你从CGImage转化为Uimage时，可调用imageWithCGImage:scale:orientation:方法生成CGImage作为对缩放性的补偿。

-(void)drawRect:(CGRect)rect{

    UIImage* mars = [UIImage imageNamed:@"屏幕快照 2017-01-12 15.18.08"];
    
    CGSize sz = [mars size];
    
    CGImageRef marsCG = [mars CGImage];
    
    CGSize szCG = CGSizeMake(CGImageGetWidth(marsCG), CGImageGetHeight(marsCG));
    
    CGImageRef marsLeft = CGImageCreateWithImageInRect(marsCG, CGRectMake(0,0,szCG.width/2.0,szCG.height));
    
    CGImageRef marsRight = CGImageCreateWithImageInRect(marsCG, CGRectMake(szCG.width/2.0,0,szCG.width/2.0,szCG.height));
    
    
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width*1.5, sz.height), NO, 0);
    
    [[UIImage imageWithCGImage:marsLeft scale:[mars scale] orientation:UIImageOrientationDown] drawAtPoint:CGPointMake(0,0)];
    
    [[UIImage imageWithCGImage:marsRight scale:[mars scale] orientation:UIImageOrientationUp] drawAtPoint:CGPointMake(sz.width,0)];
    
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGImageRelease(marsLeft); CGImageRelease(marsRight);
    
    UIImageView * newiamgeV = [[UIImageView alloc] initWithImage:im];
    
    [self addSubview:newiamgeV];
    
   
}
//还有另一种解决倒置问题的方案是在绘制CGImage之前，对上下文应用变换操作，有效地倒置上下文的内部坐标系统。这里先不做讨论。
//
//为什么会发生倒置问题
//究其原因是因为Core Graphics源于Mac OS X系统，在Mac OS X中，坐标原点在左下方并且正y坐标是朝上的，而在iOS中，原点坐标是在左上方并且正y坐标是朝下的。在大多数情况下，这不会出现任何问题，因为图形上下文的坐标系统是会自动调节补偿的。但是创建和绘制一个CGImage对象时就会暴露出倒置问题。

@end
