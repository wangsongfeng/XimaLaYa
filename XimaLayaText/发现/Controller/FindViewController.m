//
//  FindViewController.m
//  XimaLayaText
//
//  Created by apple on 2017/4/8.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import "FindViewController.h"
#import "HomePageViewController.h"
#import "CategoryViewController.h"
#import "LiveViewController.h"
#import "RankingViewController.h"
#import "AnchorViewController.h"

@interface FindViewController ()
@property(nonatomic,strong)UIButton*btn;
@end

@implementation FindViewController
+(UINavigationController*)defaultFindNavigationController{
    static UINavigationController * nav=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FindViewController * findVC=[[FindViewController alloc]initWithViewControllerClasses:[self viewControllersClass] andTheirTitles:@[@"推荐",@"分类",@"直播",@"榜单",@"主播"]];
        
        nav=[[UINavigationController alloc]initWithRootViewController:findVC];
    });
    return nav;
}

+(NSArray*)viewControllersClass{
    return @[[HomePageViewController class],[CategoryViewController class],[LiveViewController class],[RankingViewController class],[AnchorViewController class]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blueColor];
  
    
}
@end
