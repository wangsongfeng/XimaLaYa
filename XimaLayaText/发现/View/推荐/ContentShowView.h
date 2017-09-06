//
//  ContentShowView.h
//  XimaLayaText
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ContentShowViewDelegate <NSObject>

-(void)contentShowViewClick:(NSInteger)tag;

@end

@interface ContentShowView : UIView

@property (nonatomic, assign) id<ContentShowViewDelegate> delegate;

//View的背景视图框
@property(nonatomic,strong)UIImageView * bgImageView;
//头上的三横线
@property(nonatomic,strong)UIImageView * lineImageView;
//内容图片
@property(nonatomic,strong)UIImageView * contentImageView;

//点击按钮
@property(nonatomic,strong)UIButton*button;
//透明蒙版
@property(nonatomic,strong)UIView*coverView;

//图片下方的文字
@property(nonatomic,strong)UILabel * titleLable;
@end
