//
//  UIImage+JKRImage.h
//  XimaLayaText
//
//  Created by apple on 2017/5/21.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JKRImage)

/// 通过颜色获取一张宽高都为1px的图片
+ (UIImage *)jkr_imageWithColor:(UIColor *)color;
/// 通过颜色获取一张规定尺寸的图片
+ (UIImage *)jkr_imageWithColor:(UIColor *)color size:(CGSize)size;
/// 将图片裁剪成一张圆形图片
- (UIImage *)jkr_clipCircleImageWithBorder:(CGFloat)borderWidth withColor:(UIColor *)borderColor;
/// 将图片压缩到指定宽度
- (UIImage *)jkr_compressWithWidth:(CGFloat)width;
/// 将图片在子线程中压缩，block在主线层回调，保证压缩到指定文件大小，尽量减少失真
- (void)jkr_compressToDataLength:(NSInteger)length withBlock:(void(^)(NSData *data))block;
/// 尽量将图片压缩到指定大小，不一定满足条件
- (void)jkr_tryCompressToDataLength:(NSInteger)length withBlock:(void(^)(NSData *data))block;
/// 快速将图片压缩到指定大小，失真严重
- (void)jkr_fastCompressToDataLength:(NSInteger)length withBlock:(void(^)(NSData *data))block;
/// 通过修改r.g.b像素点来处理图片
- (void)jkr_fliterImageWithFliterBlock:(void(^)(int *red, int *green, int *blue))Fliterblock success:(void(^)(UIImage *image))success;





//截取当前image对象rect区域内的图像
+(UIImage*)subimageInRect:(UIImage*)image rect:(CGRect)rect;
//UIview转化为UIImage
+(UIImage*)imageWithView:(UIView*)view;
//将两张图片转化为一张图片
+(UIImage*)mergeImage:(UIImage*)image otherImage:(UIImage*)otherImage;
//不变形拉伸
+(UIImage*)scaleImageKeepingRatio:(UIImage*)image targetSize:(CGSize)targetSize;




-(UIImage*)imageWithCornerRadius:(CGFloat)radius;

@end
