//
//  LeeBaseAnimationVC.m
//  LeeAnimation
//
//  Created by LiYang on 16/12/29.
//  Copyright © 2016年 LiYang. All rights reserved.
//

#import "LeeBaseAnimationVC.h"

@interface LeeBaseAnimationVC ()

@end

@implementation LeeBaseAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
