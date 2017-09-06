//
//  UIButton+block.h
//  CameraDemo
//
//  Created by apple on 2017/3/31.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (block)

- (void)addActionBlock:(void(^)(id sender))block forControlEvents:(UIControlEvents )event;

@end
