//
//  LeeCommonHeader.h
//  demoView
//
//  Created by mac on 17/1/13.
//  Copyright © 2017年 Oliver. All rights reserved.
//

#ifndef LeeCommonHeader_h
#define LeeCommonHeader_h


#pragma mark - Debug日志
#ifdef DEBUG
#    define  LeeLog(...) printf("**%s**\n",[[NSString stringWithFormat:__VA_ARGS__]UTF8String])
#    define FLog(s) NSLog(@"[%@-%@]:\n%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd),s)
#    define TLog(...) NSLog(@"[%@-%@]:\n%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd),[NSString stringWithFormat:__VA_ARGS__])
#else
#    define LeeLog(...) */
#    define FLog(...)
#    define TLog(...)
#endif


#pragma mark - 设备相关（硬件或者软件）

#define IS_IPHONE4S ([UIScreen mainScreen].bounds.size.height == 480)
#define IS_IPHONE5_5S ([UIScreen mainScreen].bounds.size.height == 568)
#define IS_IPHONE6_7 ([UIScreen mainScreen].bounds.size.height == 667)
#define IS_IPHONE6_PLUS_7_PLUS ([UIScreen mainScreen].bounds.size.height ==736)


#pragma mark- 加载资源
#define Nib(ClassName) [UINib nibWithNibName:NSStringFromClass([ClassName class]) bundle:nil]
#define ReuseIdentifier(string) NSStringFromClass([string class])
#define Xib(ClassName) [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ClassName class]) owner:nil options:nil]lastObject]

#pragma mark - 控制器弹出
#define Lee_PUSH(VC)    [self.navigationController pushViewController:VC animated:YES];
#define Lee_POPVC       [self.navigationController popViewControllerAnimated:YES];
#define Lee_POPTOROOT   [self.navigationController popToRootViewControllerAnimated:YES];


#pragma mark - Global Color

// 基础颜色
#define LeeColorClear                [UIColor clearColor]
#define LeeColorWhite                [UIColor whiteColor]
#define LeeColorBlack                [UIColor blackColor]
#define LeeColorGray                 [UIColor grayColor]
#define LeeColorGrayDarken           [UIColor grayDarkenColor]
#define LeeColorGrayLighten          [UIColor grayLightenColor]
#define LeeColorRed                  [UIColor redColor]
#define LeeColorGreen                [UIColor greenColor]
#define LeeColorBlue                 [UIColor blueColor]
#define LeeColorYellow               [UIColor yellowColor]

// UIColor相关创建器
#define LeeColorMake(r, g, b)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define LeeColorMakeWithRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]
#define LeeColorFromHex(rgbValue,a)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a/1.0]


#pragma mark - global font
#define PING_FANG_SC @"PingFang SC"

#define LeeFontWith(fontfloat,namestring) [UIFont fontWithName:namestring size:fontfloat *      (IS_IPHONE6_7?1:(IS_IPHONE5_5S?0.8:(IS_IPHONE6_PLUS_7_PLUS?1.2:0.8)))]

#pragma mark - Uiimage

#define LeeImageNamed(s)  [UIImage imageNamed:s]

#pragma mark- 通知中心
#define LeeNotiCenter     [NSNotificationCenter defaultCenter]

#define LeeUserDefault    [NSUserDefaults standardUserDefaults]




#pragma mark - 视图高度
//屏幕宽度
#define LeeWidth   [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define LeeHeight  [UIScreen mainScreen].bounds.size.height
//状态栏高度
#define StatusbarHeight  [UIApplication sharedApplication].statusBarFrame.size.height
//应用Frame
#define AppFrame         [UIScreen mainScreen].applicationFrame




#endif /* LeeCommonHeader_h */
