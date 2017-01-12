//
//  ViewController.m
//  LeeAnimation
//
//  Created by LiYang on 16/12/29.
//  Copyright © 2016年 LiYang. All rights reserved.
//

#import "ViewController.h"
#import "LeeBaseAnimationVC.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *showTableView;

@property (nonatomic,strong)NSArray * titleArray;
@property (nonatomic,strong)NSArray * otherArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showTableView.dataSource =self;
    self.showTableView.delegate  = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    self.titleArray = @[@"LeeCABasicAnimation1",@"LeeCAKeyframeAnimation2",@"CATransition",@"CASpringAnimation",@"CAAnimationGroup",@"LeeCATransaction6",@"LeeCAEmitterLayer",@"LeeCAReplicatorLayer",@"UIDynamic",@"LeeCATransform3D",@"LeeCGAffineTransform",@"LeeUiViewAnimation",@"各种绘图比较"];
    
    self.otherArray = @[@"LeeAnimation_1"];
    
    [self.showTableView reloadData];
    
     
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if(section == 0){
        return _titleArray.count;

    }else if (section == 1){
    
        return _otherArray.count;
    }else{
    
        return 4;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * cellid = @"cellid";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        
    }
    
    if(indexPath.section == 0){
        cell.textLabel.text = self.titleArray[indexPath.row];

    }
    
    
    if (indexPath.section == 1) {
        cell.textLabel.text = self.otherArray[indexPath.row];
 
    }
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 44;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        UILabel * titleLabel = [UILabel new];
        titleLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
        titleLabel.text = @"核心动画学习";
        return titleLabel;
    }
   else if (section == 1) {
        UILabel * titleLabel = [UILabel new];
        titleLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
        titleLabel.text = @"动画综合演练";
        return titleLabel;
   }else{
   
       return nil;
   }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        switch (indexPath.row ) {
            case  0:{
                LeeBaseAnimationVC * animationVC =  [[NSClassFromString(@"LeeAnimation1") alloc] init];
                
                [self.navigationController pushViewController:animationVC animated:YES];}
                break;
            case  1:{
                
                LeeBaseAnimationVC * animationVC =  [[NSClassFromString(@"LeeCAKeyframeAnimation2") alloc] init];
                
                [self.navigationController pushViewController:animationVC animated:YES];
            }
                break;
                
            case  2:{
                
                LeeBaseAnimationVC * animationVC =  [[NSClassFromString(@"LeeCATransition3") alloc] init];
                
                [self.navigationController pushViewController:animationVC animated:YES];
            }
                
                break;
            case  3:{
                
                LeeBaseAnimationVC * animationVC =  [[NSClassFromString(@"LeeCASpringAnimation4") alloc] init];
                
                [self.navigationController pushViewController:animationVC animated:YES];
            }
                
                break;
            case  4:{
                
                LeeBaseAnimationVC * animationVC =  [[NSClassFromString(@"LeeCAAnimationGroup5") alloc] init];
                
                [self.navigationController pushViewController:animationVC animated:YES];
            }
                
                break;
                
            case  5:{
                
                LeeBaseAnimationVC * animationVC =  [[NSClassFromString(@"LeeCATransaction6") alloc] init];
                
                [self.navigationController pushViewController:animationVC animated:YES];
            }
                break;
                
            case  6:{
                
                LeeBaseAnimationVC * animationVC =  [[NSClassFromString(@"LeeCAEmitterLayer") alloc] init];
                
                [self.navigationController pushViewController:animationVC animated:YES];
            }
                break;
            case  7:{
                
                LeeBaseAnimationVC * animationVC =  [[NSClassFromString(@"LeeCAReplicatorLayer") alloc] init];
                
                [self.navigationController pushViewController:animationVC animated:YES];
            }
                break;
                
            case  8:{
                
                LeeBaseAnimationVC * animationVC =  [[NSClassFromString(@"LeeUIDynamic") alloc] init];
                
                [self.navigationController pushViewController:animationVC animated:YES];
            }
                break;
            case  9:{
                
                LeeBaseAnimationVC * animationVC =  [[NSClassFromString(@"LeeCATransform3D") alloc] init];
                
                [self.navigationController pushViewController:animationVC animated:YES];
            }
                break;
                
            case  10:{
                
                LeeBaseAnimationVC * animationVC =  [[NSClassFromString(@"LeeCGAffineTransform") alloc] init];
                
                [self.navigationController pushViewController:animationVC animated:YES];
            }
                break;
            case  11:{
                
                LeeBaseAnimationVC * animationVC =  [[NSClassFromString(@"LeeUiViewAnimation") alloc] init];
                
                [self.navigationController pushViewController:animationVC animated:YES];
            }
                break;
            case  12:{
                
                LeeBaseAnimationVC * animationVC =  [[NSClassFromString(@"LeeDrawView") alloc] init];
                
                [self.navigationController pushViewController:animationVC animated:YES];
            }
                break;

            default:
                break;
        }
 
    }else{
    
        switch (indexPath.row) {
            case  0:{
                LeeBaseAnimationVC * animationVC =  [[NSClassFromString(@"LeeAnimation_1") alloc] init];
                
                [self.navigationController pushViewController:animationVC animated:YES];
            }
                
                break;
                
            default:
                break;
        }
        
    }
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
