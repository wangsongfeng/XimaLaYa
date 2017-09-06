//
//  ContentShowView.m
//  XimaLayaText
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import "ContentShowView.h"

@implementation ContentShowView
-(instancetype)init{
    if (self=[super init]) {
        self.coverView.alpha=0.4;
        self.lineImageView.hidden=NO;
        self.button.hidden=NO;
    }
    return self;
}


-(UIImageView*)lineImageView{
    if (_lineImageView==nil) {
        _lineImageView=[UIImageView new];
        [self addSubview:_lineImageView];
        [_lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.mas_equalTo(0);
            make.height.mas_equalTo(4);
            make.width.mas_equalTo(kWindowW/4);
        }];
        _lineImageView.image=[UIImage imageNamed:@"find_albumtop"];
    }
    return _lineImageView;
}

-(UIImageView*)bgImageView{
    if (_bgImageView==nil) {
        _bgImageView=[UIImageView new];
        [self addSubview:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.lineImageView.mas_bottom).mas_equalTo(0);
            make.bottom.left.right.mas_equalTo(0);
        }];
        _bgImageView.image=[UIImage imageNamed:@"findradio_bg"];
    }
    return _bgImageView;
}

-(UIImageView*)contentImageView{
    if (_contentImageView==nil) {
        _contentImageView=[UIImageView new];
        [self.bgImageView addSubview:_contentImageView];
        [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.mas_equalTo(-1);
            make.top.left.mas_equalTo(1);
        }];
    }
    return _contentImageView;
}


-(UIButton*)button{
    if (_button==nil) {
        _button=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

-(UIView*)coverView{
    if (_coverView==nil) {
        _coverView=[UIView new];
        [self.contentImageView addSubview:_coverView];
        [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(20);
        }];
        _coverView.backgroundColor=[UIColor blackColor];
    }
    return _coverView;
}

-(UILabel*)titleLable{
    if (_titleLable==nil) {
        _titleLable=[UILabel new];
        [self.contentImageView addSubview:_titleLable];
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(20);
        }];
        _titleLable.textColor=[UIColor whiteColor];
        _titleLable.textAlignment=NSTextAlignmentCenter;
        _titleLable.font=[UIFont systemFontOfSize:12];
    }
    return _titleLable;
}


-(void)buttonClick{
    if ([self.delegate respondsToSelector:@selector(contentShowViewClick:)]) {
        [self.delegate contentShowViewClick:self.tag];
    }
}
@end
