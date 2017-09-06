//
//  TitleView.h
//  XimaLayaText
//
//  Created by apple on 2017/9/6.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
// 监听更多按钮点击事件协议
@protocol TitleViewDelegate <NSObject>

- (void)titleViewDidClick:(NSInteger)tag;

@end

@interface TitleView : UIView
// 添加代理
@property (nonatomic,weak) id<TitleViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title hasMore:(BOOL)more;

/**  标题 */
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UILabel *titleLb;
@end
