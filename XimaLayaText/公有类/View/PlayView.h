//
//  PlayView.h
//  XimaLayaText
//
//  Created by apple on 2017/4/19.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlayViewDelegate <NSObject>

-(void)playButtonDidClick:(BOOL)selected;

@end
@interface PlayView : UIView

@property (nonatomic,strong) UIImageView *circleIV;
@property (nonatomic,strong) UIImageView *contentIV;
@property (nonatomic,strong) UIButton *playButton;
@property (nonatomic,weak) id<PlayViewDelegate> delegate;

@end
