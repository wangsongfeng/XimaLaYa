//
//  FindPutViewCell.h
//  XimaLayaText
//
//  Created by apple on 2017/8/16.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentShowView.h"
@interface FindPutViewCell : UITableViewCell

/**  跳转按钮0 */
@property (nonatomic,strong) ContentShowView *clickBtn0;
/**  跳转按钮1 */
@property (nonatomic,strong) ContentShowView *clickBtn1;
/**  跳转按钮2 */
@property (nonatomic,strong) ContentShowView *clickBtn2;
/**  跳转按钮介绍0 */
@property (nonatomic,strong) UILabel *detailLb0;
/**  跳转按钮介绍1 */
@property (nonatomic,strong) UILabel *detailLb1;
/**  跳转按钮介绍2 */
@property (nonatomic,strong) UILabel *detailLb2;

/**  返回本类计算行高 */
@property (nonatomic,assign) CGFloat cellHeight;

@end
