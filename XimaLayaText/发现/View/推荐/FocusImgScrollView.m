//
//  FocusImgScrollView.m
//  XimaLayaText
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import "FocusImgScrollView.h"

@implementation FocusImgScrollView
{
    NSTimer * _timer;
}
-(instancetype)initWithFocusImgNumber:(NSInteger)number{
    if (self=[super init]) {
        [_timer invalidate];
        if (!number) return nil;
            
        self.frame=CGRectMake(0, 0,kWindowW, kWindowW/630*310);
        _iC=[iCarousel new];
        [self addSubview:_iC];
        [_iC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _iC.scrollEnabled=number !=1;
        
        _iC.pagingEnabled=YES;
        
        _pageControl=[UIPageControl new];
        _pageControl.numberOfPages=number;
        [_iC addSubview:_pageControl];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(20);
        }];
        
        _pageControl.hidesForSinglePage=YES;
        _pageControl.userInteractionEnabled=NO;
        _pageControl.pageIndicatorTintColor=[UIColor lightTextColor];
        _pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
        
        if (number>1) {
            _timer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(play:) userInfo:nil repeats:YES];
        }
    }
    return self;
}
-(void)play:(NSTimer*)timer{
    [_iC scrollToItemAtIndex:_iC.currentItemIndex+1 animated:YES];
}
@end
