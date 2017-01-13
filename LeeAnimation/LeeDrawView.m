//
//  LeeDrawView.m
//  LeeAnimation
//
//  Created by LiYang on 17/1/4.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "LeeDrawView.h"
#import "LeeDrawView1.h"
#import "LeeDrawView2.h"


@interface LeeDrawView ()

@end

@implementation LeeDrawView

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);


//    LeeDrawView1 * view1 = [[LeeDrawView1 alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [self.view addSubview:view1];
    
   
    LeeDrawView1 * view = [[LeeDrawView1 alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    //[self.view addSubview:view];
    
    
    LeeDrawView2 * view2 = [[LeeDrawView2 alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height - 100)];
    view2.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view2];
    

    
    
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
