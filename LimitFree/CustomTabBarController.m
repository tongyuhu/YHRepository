//
//  CustomTabBarController.m
//  day40_UI爱限免
//
//  Created by qianfeng on 15/7/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CustomTabBarController.h"
#import "ViewController.h"
#import "SpecialViewController.h"
@interface CustomTabBarController ()
{
    
}
@end

@implementation CustomTabBarController

- (void)creatUI
{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *titles = @[@"限免", @"免费", @"降价", @"专题", @"热榜"];
    for (int i = 0; i<5; i++) {
        
        UINavigationController *nav = nil;
        if (i == 3) {
            SpecialViewController *vc = [[SpecialViewController alloc] init];
            nav = [[UINavigationController alloc] initWithRootViewController:vc];
            
        }
        else
        {
            ViewController *vc= [[ViewController alloc] init];
            nav = [[UINavigationController alloc] initWithRootViewController:vc];
        }
        nav.title = titles[i];
        nav.tabBarItem.title = titles[i];
        nav.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%d@2x", i]];
        nav.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%d_press@2x",i]];
        
        [array addObject:nav];
        
    }
    self.viewControllers = array;
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_bg@2x"];
    self.tabBarController.selectedIndex = 0;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
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
