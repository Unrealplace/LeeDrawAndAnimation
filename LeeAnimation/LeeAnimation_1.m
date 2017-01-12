//
//  LeeAnimation_1.m
//  LeeAnimation
//
//  Created by LiYang on 17/1/1.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "LeeAnimation_1.h"
#import "LeeView1.h"

@interface LeeAnimation_1 ()
@property (nonatomic,strong)LeeView1 * redView;

@end

@implementation LeeAnimation_1

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    LeeView1 * view = [[LeeView1 alloc] initWithFrame:CGRectMake(0, 0, 200, self.view.frame.size.height)];
    view.backgroundColor = [UIColor whiteColor];
    self.redView =view;
    
    
    
    


}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view addSubview:self.redView];
    
    for (int i = 0; i < 100; i ++) {
      
        self.redView.controlWidth = i;
        
    }

    
}


//如果将路径显示的图案显示到视图上呢？
//有三种方式：1、直接使用UIBezierPath的方法；2、使用CoreGraphics绘制；3、利用CAShapeLayer绘制。


@end
