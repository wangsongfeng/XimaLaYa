//
//  TabBarViewController.m
//  XimaLayaText
//
//  Created by apple on 2017/4/8.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UINavigationController * findVc=[FindViewController defaultFindNavigationController];
    [self setUpChildController:findVc imageName:@"tabbar_find_n" selectedImage:@"tabbar_find_h"];
    CustomViewController * customView=[[CustomViewController alloc]init];
    [self setUpChildController:customView imageName:@"tabbar_sound_n" selectedImage:@"tabbar_sound_h"];
    UIViewController * view=[UIViewController new];
    [self setUpChildController:view imageName:nil selectedImage:nil];
    
    DownLoadViewController * downView=[[DownLoadViewController alloc]init];
    [self setUpChildController:downView imageName:@"tabbar_download_n" selectedImage:@"tabbar_download_h"];
    
    MeViewController * meView=[[MeViewController alloc]init];
    [self setUpChildController:meView imageName:@"tabbar_me_n" selectedImage:@"tabbar_me_h"];
    
    self.tabBar.backgroundImage=[UIImage imageNamed:@"tabbar_bg"];
    
  
}

-(void)setUpChildController:(UIViewController*)controller imageName:(NSString*)imageName selectedImage:(NSString*)selectedImageName
{
    controller.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0, -5, 0);
    controller.tabBarItem.image=[UIImage imageNamed:imageName];
    /*
     *  设置UIImage的渲染模式：UIImage.renderingMode
     *  1.UIImageRenderingModeAutomatic  // 根据图片的使用环境和所处的绘图上下文自动调整渲染模式。
        2.UIImageRenderingModeAlwaysOriginal   // 始终绘制图片原始状态，不使用Tint Color。
        3.UIImageRenderingModeAlwaysTemplate   // 始终根据Tint Color绘制图片，忽略图片的颜色信息。
     *
     */
    UIImage * image=[[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    controller.tabBarItem.selectedImage=image;
    [self addChildViewController:controller];
    
}


@end
