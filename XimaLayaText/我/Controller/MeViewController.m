//
//  MeViewController.m
//  XimaLayaText
//
//  Created by apple on 2017/4/8.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import "MeViewController.h"
#import <QuartzCore/QuartzCore.h>
typedef NS_ENUM(NSInteger,ZWViewType){
    ZWViewType_eyes,
    ZWViewType_mouth
};

//设置颜色
#define ZWEyesColor [UIColor blueColor]
#define ZWMouthColor [UIColor greenColor]
//设置图层大小比例
#define ZWEyesScale 0.2
#define ZWMouthScale 0.4

@interface MeViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
   
}
@property(nonatomic,strong)UIImageView * imageView;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
