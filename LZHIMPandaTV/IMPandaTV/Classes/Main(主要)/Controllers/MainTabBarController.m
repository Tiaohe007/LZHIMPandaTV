 //
//  MainTabBarController.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/9/26.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "MainTabBarController.h"
#import "LZHHomeViewController.h"
#import "LZHGameCollectionViewController.h"
#import "LZHEntertaimentViewController.h"
#import "LZHGodViewController.h"
#import "LZHMineTableViewController.h"

#import "LZHTabBar.h"

@interface MainTabBarController ()


@end

@implementation MainTabBarController


- (void)viewDidLoad {

    [super viewDidLoad];

    
    //添加子控制器
    [self setUpChildCT];
    
    //自定义tabBar
//    [self setUpTabBar];
}
#pragma 添加子控制器
-(void)setUpChildCT{
    
    //首页
    LZHHomeViewController *home = [[LZHHomeViewController alloc]init];

    [self setUpOneChildCT:home image:[UIImage imageNamed:@"menu_homepage_24x24_"] selected:[UIImage imageNamed:@"menu_homepage_sel_24x24_"] andTitle:@"首页"];
    
    //游戏
    LZHGameCollectionViewController *game = [[LZHGameCollectionViewController alloc]init];

    [self setUpOneChildCT:game image:[UIImage imageNamed:@"menu_youxi_24x24_"] selected:[UIImage imageNamed:@"menu_youxi_sel_24x24_"] andTitle:@"游戏"];
    //娱乐
    LZHEntertaimentViewController *enter = [[LZHEntertaimentViewController alloc]init];
    [self setUpOneChildCT:enter image:[UIImage imageNamed:@"menu_yule_24x24_"] selected:[UIImage imageNamed:@"menu_yule_sel_24x24_"] andTitle:@"娱乐"];
    
    //女神
    LZHGodViewController *god = [[LZHGodViewController alloc]init];
    [self setUpOneChildCT:god image:[UIImage imageNamed:@"menu_goddess_normal_20x21_"] selected:[UIImage imageNamed:@"menu_goddess_20x21_"] andTitle:@"女神"];
    
    //我的
    LZHMineTableViewController *mine = [[LZHMineTableViewController alloc]init];
    [self setUpOneChildCT:mine image:[UIImage imageNamed:@"menu_mine_24x24_"] selected:[UIImage imageNamed:@"menu_mine_sel_24x24_"] andTitle:@"我的"];
}

#pragma 添加一个子控制器
-(void)setUpOneChildCT:(UIViewController *)vc image:(UIImage *)image selected:(UIImage *)selectedImage andTitle:(NSString *)title{

    
//    vc.view.backgroundColor = [self randomColor];
    
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    vc.tabBarItem.title = title;
    
    //默认的状态
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [vc.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    // 选中
    NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
    attrSelected[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrSelected[NSForegroundColorAttributeName] = [UIColor colorWithRed:82/255.0f green:194/255.0f blue:136/255.0f alpha:1.0];
    [vc.tabBarItem setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
    
    
    //给子控制器包装一个导航控制器
    
    UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:nv];
    
}
//-(UIColor *)randomColor{
//
//    CGFloat r = arc4random_uniform(256)/255.0;
//    CGFloat g = arc4random_uniform(256)/255.0;
//    CGFloat b = arc4random_uniform(256)/255.0;
//
//    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
//}

//-(void)setUpTabBar{
//
//    
//    //开始移除原来系统的tabBar
//    [self.tabBar removeFromSuperview];
//    
//    //然后用我的自定义的tabBar
//    LZHTabBar *tabBar = [[LZHTabBar alloc]init];
//    
//    //设置背景颜色 因为这本身就是一个view
//    tabBar.backgroundColor = [UIColor whiteColor];
//    
//    //位置不变
//    tabBar.frame = self.tabBar.frame;
//    
//    //tabBar的个数 跟子控制器的个数是一样的
////    tabBar.itemCount = (int)self.childViewControllers.count;
//    
//    tabBar.items = self.items;
//    
//    [self.view addSubview:tabBar];
//
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
