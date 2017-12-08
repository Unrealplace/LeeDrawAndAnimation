//
//  BitmapGraphicsContextVC.m
//  LeeAnimation
//
//  Created by LiYang on 2017/12/7.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "BitmapGraphicsContextVC.h"

@interface BitmapGraphicsContextVC ()

@property (nonatomic, strong)UIImageView * backImageView;

@end

@implementation BitmapGraphicsContextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backImageView];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.backImageView.image = [self addImage:[UIImage imageNamed:@"222"] toSourceImage:[UIImage imageNamed:@"111"]];
    self.backImageView.frame = CGRectMake(100, 100, 200, 200);
    
    
}
- (UIImageView *)backImageView {

    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
    }
    return _backImageView;
    
}
- (UIImage *)addImage:(UIImage *)tagertImage toSourceImage:(UIImage*)sourceImage {
    
    CGSize sourceSize = CGSizeMake(CGImageGetWidth(sourceImage.CGImage), CGImageGetHeight(sourceImage.CGImage));
    
    const size_t bitsPerComponent = 8;
    const size_t bytesPerRow = sourceSize.width * 4; //1byte per pixel
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(
                                                 NULL,
                                                 sourceSize.width,
                                                 sourceSize.height,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst
                                                 );
    
   
    //绘制
    CGContextDrawImage(context, CGRectMake(0, 0, sourceSize.width, sourceSize.height), sourceImage.CGImage);
    
    CGContextTranslateCTM(context, 0, sourceSize.height);
    CGContextScaleCTM(context, 1.0f, -1.0f);
//    CGContextRotateCTM(context, M_PI);
    //绘制
    CGContextDrawImage(context, CGRectMake(0, 0, sourceSize.width*0.3, sourceSize.height*0.3), tagertImage.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
    
}
@end
