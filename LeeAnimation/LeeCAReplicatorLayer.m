//
//  LeeCAReplicatorLayer.m
//  LeeAnimation
//
//  Created by LiYang on 17/1/1.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "LeeCAReplicatorLayer.h"
#import "loadLayer.h"

@interface LeeCAReplicatorLayer ()

@property (nonatomic,strong)CALayer * layer;

@end

@implementation LeeCAReplicatorLayer

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);

    loadLayer * view = [[loadLayer alloc] initWithFrame:CGRectMake(100, 100, 120, 120)];
    //view.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:view];
   // [view animation1];
    
   // [view animation2];
    
    [view animation3];
    

    
}



@end
