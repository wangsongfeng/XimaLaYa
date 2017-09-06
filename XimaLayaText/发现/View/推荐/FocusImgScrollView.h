//
//  FocusImgScrollView.h
//  XimaLayaText
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface FocusImgScrollView : UIView


-(instancetype)initWithFocusImgNumber:(NSInteger)number;

@property(nonatomic,strong)iCarousel*iC;
@property(nonatomic,strong)UIPageControl * pageControl;
@end
