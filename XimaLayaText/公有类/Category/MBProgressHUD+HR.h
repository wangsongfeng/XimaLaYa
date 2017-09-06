//
//  MBProgressHUD+HR.h
//  XimaLayaText
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (HR)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+(MBProgressHUD*)showMessage:(NSString*)message;
+(void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
@end
