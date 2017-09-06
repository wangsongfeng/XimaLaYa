//
//  BaseViewModel.h
//  XimaLayaText
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseViewModelDelegate <NSObject>

@optional
//获取更多
-(void)getMoreDataCompletionHandle:(void(^)(NSError * error))completed;

//刷新
-(void)refreshDataCompletionHandle:(void(^)(NSError * error))completed;

//获取数据
-(void)getDataCompletionHandle:(void(^)(NSError * error))completed;

//通过indexPath返回cell高
-(CGFloat)cellHeightForIndexPath:(NSIndexPath*)indexPath;

@end

@interface BaseViewModel : NSObject<BaseViewModelDelegate>

@property(nonatomic,strong)NSURLSessionDataTask * dataTask;
//取消任务
-(void)cancleTask;
//暂停任务
-(void)suspendTask;
//继续任务
-(void)resumeTask;

@end
