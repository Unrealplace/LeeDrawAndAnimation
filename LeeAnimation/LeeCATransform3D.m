//
//  LeeCATransform3D.m
//  LeeAnimation
//
//  Created by LiYang on 17/1/2.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "LeeCATransform3D.h"

@interface LeeCATransform3D ()
@property (nonatomic,strong)UIImageView * imageV;

@end

@implementation LeeCATransform3D

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);

    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    imageView.image = [UIImage imageNamed:@"222"];
    
    self.imageV = imageView;
    
    [self.view addSubview:imageView];
    

    //[self traslation];
    
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    //[self traslation];
   // [self makeScale];
   // [self rotate];
    
    [self rotateAndRevert];
    
    
}
//平移动变换。
-(void)traslation{

   
//    //返回一个平移变换的transform3D对象 tx，ty，tz对应x，y，z轴的平移
//    
//    CATransform3D CATransform3DMakeTranslation (CGFloat tx, CGFloat ty, CGFloat tz);
//    
//    //在某个transform3D变换的基础上进行平移变换，t是上一个transform3D，其他参数同上
//    
//    CATransform3D CATransform3DTranslate (CATransform3D t, CGFloat tx, CGFloat ty, CGFloat tz);


    
    /* The identity transform: [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1]. */

    CATransform3D trans = CATransform3DMakeTranslation(10, 200, 0);
    
    self.imageV.layer.transform =trans;
}

//缩放变换
-(void)makeScale{

    
    
    CATransform3D trans = CATransform3DMakeScale(2, 1, 1);
    
    self.imageV.layer.transform =trans;

}



////angle参数是旋转的角度，为弧度制 0-2π
//
////x，y，z决定了旋转围绕的中轴，取值为-1——1之间，例如（1，0，0）,则是绕x轴旋转（0.5，0.5，0），则是绕x轴与y轴中间45度为轴旋转,依次进行计算
//CATransform3D CATransform3DMakeRotation (CGFloat angle, CGFloat x, CGFloat y, CGFloat z);
//
////在一个transform3D的基础上进行旋转变换，其他参数如上
//CATransform3D CATransform3DRotate (CATransform3D t, CGFloat angle, CGFloat x, CGFloat y, CGFloat z);

-(void)rotate{

    // 另外，当我们有垂直于z轴的旋转分量时，设置m34的值可以增加透视效果，也可以理解为景深效果，例如：
    CATransform3D trans = CATransform3DIdentity;
    trans.m34 = -1/100.0;
    trans = CATransform3DRotate(trans, M_PI/4, 0, 1, 0);
    self.imageV.layer.transform =trans;
    
    
//    CATransform3D trans = CATransform3DMakeRotation(M_PI/2, 0.5, 0.5, 0.5);
//    self.imageV.layer.transform =trans;
    
    
}
//旋转翻转变换
-(void)rotateAndRevert{

    
    
    CATransform3D trans = CATransform3DMakeRotation(M_PI/4, 0, 0, 1);
    
    trans = CATransform3DInvert(trans);
    
    self.imageV.layer.transform = trans;
    
    
}

//5、CATransform3D与CGAffineTransform的转换
//
//CGAffineTransform是UIKit框架中一个用于变换的矩阵，其作用与CATransform类似，只是其可以直接作用于View，而不用作用于layer，这两个矩阵也可以进行转换，方法如下：


//iOS开发CoreAnimation解读之五——CATransform3D变换的应用
//一、引言
//二、CATransform3D中的属性和方法
//1、平移变换
//2、缩放变换
//3、旋转变换
//4、旋转翻转变换
//5、CATransform3D与CGAffineTransform的转换

//iOS开发CoreAnimation解读——CATransform3D变换的应用
//一、引言
//
//CATransform3D定义了一个变化矩阵，通过对矩阵参数的设置，我们可以改变layer的一些属性，这个属性的改变，可以产生动画的效果。首先，CATransform3D定义了一个4*4的矩阵，如下：
//?
//
//struct CATransform3D
//
//{
//    
//    CGFloat m11, m12, m13, m14;
//    
//    CGFloat m21, m22, m23, m24;
//    
//    CGFloat m31, m32, m33, m34;
//    
//    CGFloat m41, m42, m43, m44;
//    
//};
//
//从m11到m44定义的含义如下：
//
//m11：x轴方向进行缩放
//
//m12：和m21一起决定z轴的旋转
//
//m13:和m31一起决定y轴的旋转
//
//m14:
//
//m21:和m12一起决定z轴的旋转
//
//m22:y轴方向进行缩放
//
//m23:和m32一起决定x轴的旋转
//
//m24:
//
//m31:和m13一起决定y轴的旋转
//
//m32:和m23一起决定x轴的旋转
//
//m33:z轴方向进行缩放
//
//m34:透视效果m34= -1/D，D越小，透视效果越明显，必须在有旋转效果的前提下，才会看到透视效果
//
//m41:x轴方向进行平移
//
//m42:y轴方向进行平移
//
//m43:z轴方向进行平移
//
//m44:初始为1
@end
