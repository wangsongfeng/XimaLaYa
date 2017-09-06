//
//  UIImage+JKRImage.m
//  XimaLayaText
//
//  Created by apple on 2017/5/21.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import "UIImage+JKRImage.h"
#import <CoreFoundation/CoreFoundation.h>

/*
 * CG是Core Graphics的缩写，用来处理图形的函数库。
 *
 * CG类型表示一种数据类型，就是当你画图的时候需要将Image类型转换成这种类型，才能够画到屏幕上去。当你调用Quartz库画图时，很多数据都是需要转换成这样的类型
 *
 *
 *
 *
 **/



@implementation UIImage (JKRImage)
+(UIImage *)jkr_imageWithColor:(UIColor *)color {
 
    return [self jkr_imageWithColor:color size:CGSizeMake(1, 1)];

}
+(UIImage *)jkr_imageWithColor:(UIColor *)color size:(CGSize)size {
    
      if (!color || size.width <= 0 || size.height <= 0) return nil;
       CGRect rect = CGRectMake(0.f, 0.f, size.width, size.height);
       UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
       CGContextRef context = UIGraphicsGetCurrentContext();
       CGContextSetFillColorWithColor(context, color.CGColor);
       CGContextFillRect(context, rect);
       UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
       UIGraphicsEndImageContext();
       return image;

}
- (UIImage *)jkr_clipCircleImageWithBorder:(CGFloat)borderWidth withColor:(UIColor *)borderColor {
	    CGFloat dia;
	    if (self.size.width >= self.size.height) {
	        dia = self.size.height;
	    } else {
	        dia = self.size.width;
	    }
	    CGRect mframe = CGRectMake(0, 0, dia + borderWidth * 2, dia + borderWidth * 2);
	    UIGraphicsBeginImageContextWithOptions(mframe.size, NO, 0.0f);
	    UIBezierPath *pathCir = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, mframe.size.width, mframe.size.height)];
	    CGContextRef ctr = UIGraphicsGetCurrentContext();
	    [borderColor setFill];
	    CGContextAddPath(ctr, pathCir.CGPath);
	    CGContextFillPath(ctr);
	    UIBezierPath *pathClip = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, dia, dia)];
	    [pathClip addClip];
	    [self drawAtPoint:CGPointMake(borderWidth, borderWidth)];
	    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	    UIGraphicsEndImageContext();
	    return newImage;
	}

- (UIImage *)jkr_compressWithWidth:(CGFloat)width {
	    if (width <= 0 || [self isKindOfClass:[NSNull class]] || self == nil) return nil;
	    CGSize newSize = CGSizeMake(width, width * (self.size.height / self.size.width));
	    UIGraphicsBeginImageContext(newSize);
	    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
	    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	    UIGraphicsEndImageContext();
	    return newImage;
}

- (void)jkr_compressToDataLength:(NSInteger)length withBlock :(void (^)(NSData *))block {
    if (length <= 0 || [self isKindOfClass:[NSNull class]] || self == nil) block(nil);

	    dispatch_async(dispatch_get_global_queue(0, 0), ^{
	        UIImage *newImage = [self copy];
	        {
	            CGFloat scale = 0.9;
	            NSData *pngData = UIImagePNGRepresentation(self);
	            NSLog(@"Original pnglength %zd", pngData.length);
	            NSData *jpgData = UIImageJPEGRepresentation(self, scale);
	            NSLog(@"Original jpglength %zd", pngData.length);

	            while (jpgData.length > length) {
	                newImage = [newImage jkr_compressWithWidth:newImage.size.width * scale];
	                NSData *newImageData = UIImageJPEGRepresentation(newImage, 0.0);
	                if (newImageData.length < length) {
	                    CGFloat scale = 1.0;
	                    newImageData = UIImageJPEGRepresentation(newImage, scale);
	                    while (newImageData.length > length) {
	                        scale -= 0.1;
	                        newImageData = UIImageJPEGRepresentation(newImage, scale);
	                    }
	                    dispatch_async(dispatch_get_main_queue(), ^{
	                        NSLog(@"Result jpglength %zd", newImageData.length);
	                        block(newImageData);
	                    });
	                    return;
	                }
           }
        }
    });
}

- (void)jkr_tryCompressToDataLength:(NSInteger)length withBlock:(void (^)(NSData *))block {
	    if (length <= 0 || [self isKindOfClass:[NSNull class]] || self == nil) block(nil);
	    dispatch_async(dispatch_get_global_queue(0, 0), ^{
	        CGFloat scale = 0.9;
	        NSData *scaleData = UIImageJPEGRepresentation(self, scale);
	        while (scaleData.length > length) {
	            scale -= 0.1;
            if (scale < 0) {
	                break;
	            }
	            NSLog(@"%f", scale);
	            scaleData = UIImageJPEGRepresentation(self, scale);
	        }
	        dispatch_async(dispatch_get_main_queue(), ^{
	            block(scaleData);
	        });
    });
}

- (void)jkr_fastCompressToDataLength:(NSInteger)length withBlock:(void (^)(NSData *))block {
	    if (length <= 0 || [self isKindOfClass:[NSNull class]] || self == nil) block(nil);
	    CGFloat scale = 1.0;
	    UIImage *newImage = [self copy];
	     NSInteger newImageLength = UIImageJPEGRepresentation(newImage, 1.0).length;
	    while (newImageLength > length) {
	        NSLog(@"Do compress");
	        // 如果限定的大小比当前的尺寸大0.9的平方倍，就用开方求缩放倍数,减少缩放次数
	        if ((double)length / (double)newImageLength < 0.81) {
	            scale = sqrtf((double)length / (double)newImageLength);
	        } else {
	            scale = 0.9;
	        }
	        CGFloat width = newImage.size.width * scale;
	        newImage = [newImage jkr_compressWithWidth:width];
	        newImageLength = UIImageJPEGRepresentation(newImage, 1.0).length;
	    }
	    dispatch_async(dispatch_get_main_queue(), ^{
	        block(UIImageJPEGRepresentation(newImage, 1.0));
	    });
}

- (void)jkr_fliterImageWithFliterBlock:(void (^)(int *, int *, int *))Fliterblock success:(void (^)(UIImage *))success{
	    if ([self isKindOfClass:[NSNull class]] || self == nil) return;
	    dispatch_async(dispatch_get_global_queue(0, 0), ^{
	        CGImageRef imageRef = self.CGImage;
	        size_t width = CGImageGetWidth(imageRef);
	        size_t height = CGImageGetHeight(imageRef);
            size_t bits = CGImageGetBitsPerComponent(imageRef);
	        size_t bitsPerRow = CGImageGetBytesPerRow(imageRef);
	        CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
	        int alphaInfo = CGImageGetAlphaInfo(imageRef);
	        CGDataProviderRef providerRef = CGImageGetDataProvider(imageRef);
	        CFDataRef dataRef = CGDataProviderCopyData(providerRef);
	        int length = (int)CFDataGetLength(dataRef);
	        UInt8 *pixelBuf = (UInt8 *)CFDataGetMutableBytePtr((CFMutableDataRef)dataRef);
        for (int i = 0; i < length; i+=4) {
            //////修改原始像素RGB数据
	            int offsetR = i;
	            int offsetG = i + 1;
	            int offsetB = i + 2;
	            int red = pixelBuf[offsetR];
	            int green = pixelBuf[offsetG];
	            int blue = pixelBuf[offsetB];
	            Fliterblock(&red, &green, &blue);
	            pixelBuf[offsetR] = red;
	            pixelBuf[offsetG] = green;
	            pixelBuf[offsetB] = blue;
	        }
        
	        CGContextRef contextRef = CGBitmapContextCreate(pixelBuf, width, height, bits, bitsPerRow, colorSpace, alphaInfo);
	        CGImageRef backImageRef = CGBitmapContextCreateImage(contextRef);
	        UIImage *backImage = [UIImage imageWithCGImage:backImageRef scale:[UIScreen mainScreen].scale orientation:self.imageOrientation];
	        CFRelease(dataRef);
	        CFRelease(contextRef);
	        CFRelease(backImageRef);
        dispatch_async(dispatch_get_main_queue(), ^{
	            success(backImage);
	        });
	    });
	}



//截取当前image对象rect区域内的图像
+(UIImage*)subimageInRect:(UIImage*)image rect:(CGRect)rect
{
    CGImageRef newImageRef=CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage * img=[UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return img;
}
////UIview转化为UIImage
//+(UIImage*)imageWithView:(UIView*)view
//{
//    
//}
////将两张图片转化为一张图片
//+(UIImage*)mergeImage:(UIImage*)image otherImage:(UIImage*)otherImage
//{
//    
//}
////不变形拉伸
//+(UIImage*)scaleImageKeepingRatio:(UIImage*)image targetSize:(CGSize)targetSize
//{
//    
//}

-(UIImage*)imageWithCornerRadius:(CGFloat)radius
{
    
    // borderWidth 表示边框的宽度
    CGFloat imageW = self.size.width;
    CGFloat imageH = imageW;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // borderColor表示边框的颜色
    
    CGFloat bigRadius = imageW * 0.5;
    CGFloat centerX = bigRadius;
    CGFloat centerY = bigRadius;
    CGContextAddArc(context, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(context);
    CGFloat smallRadius = bigRadius ;
    CGContextAddArc(context, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    CGContextClip(context);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
