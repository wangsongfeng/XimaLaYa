//
//  PlayView.m
//  XimaLayaText
//
//  Created by apple on 2017/4/19.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import "PlayView.h"
//宏定义   角度转弧度
@interface PlayView()

// 设置一个私有的定时器
@property (nonatomic,strong) CADisplayLink *link;

@end
#define angleToRadian(x) (x/180.0*M_PI)
@implementation PlayView

-(instancetype)init
{
    if (self=[super init]) {
        //布局
        UIImageView * background=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar_np_normal"]];
        [self addSubview:background];
        [background mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.edges.mas_equalTo(0);
        }];
        
        _circleIV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar_np_loop"]];
        [background addSubview:_circleIV];
        [_circleIV mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.top.mas_equalTo(2);
            make.right.mas_equalTo(-2);
            make.bottom.mas_equalTo(-8);
            
        }];
        background.userInteractionEnabled=YES;
        _circleIV.userInteractionEnabled=YES;
        
        // 按钮被点击前
        [self.playButton setImage:[UIImage imageNamed:@"tabbar_np_play"] forState:UIControlStateNormal];
    }
    return self;
}

-(UIButton*)playButton{
    if (!_playButton) {
        _playButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setHighlighted:NO];
        // 被点击后 "avatar_bg" 透明
        [_playButton setBackgroundImage:[UIImage imageNamed:@"avatar_bg"] forState:UIControlStateSelected];
        [_playButton setImage:[UIImage imageNamed:@"toolbar_pause_h_p"] forState:UIControlStateSelected];
        [self  addSubview:_playButton];

        [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(2);
            make.right.mas_equalTo(-2);
            make.bottom.mas_equalTo(-7);
        }];
        WS(weak);
        [_playButton addActionBlock:^(id sender) {
           
            // 点击图和不点击图交换
            if ([weak.delegate respondsToSelector:@selector(playButtonDidClick:)]) {
                weak.playButton.selected = !weak.playButton.selected;
                weak.link.paused = !weak.playButton.selected;
                [weak.delegate playButtonDidClick:weak.playButton.selected];
            }

            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

-(UIImageView*)contentIV
{
    if (!_contentIV) {
        _contentIV=[[UIImageView alloc]init];
        [self addSubview:_contentIV];
        [_contentIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(8, 8, 8, 8));
        }];
        [_contentIV addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        // 作圆内容视图背景
        _contentIV.layer.cornerRadius = 22;
        _contentIV.clipsToBounds = YES;
        
    }
    return _contentIV;
}
-(void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    if([keyPath isEqualToString:@"image"])
    {
        // 启动定时器
        self.link.paused = NO;
        self.playButton.selected = YES;
        
    }
}
- (CADisplayLink *)link {
    if (!_link) {
        // 创建定时器, 一秒钟调用rotation方法60次
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(rotation)];
        // 手动将定时器加入到事件循环中
        // NSRunLoopCommonModes会使得RunLoop会随着界面切换扔继续使用, 不然如果使用Default的话UI交互没问题, 但滑动TableView就会出现不转问题, 因为RunLoop模式改变会影响定时器调度
        [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _link;
}
/**  背景图rotation滚动 */
- (void)rotation {
    self.circleIV.layer.transform = CATransform3DRotate(self.circleIV.layer.transform, angleToRadian(72/60.0), 0, 0, 1);
}
@end
