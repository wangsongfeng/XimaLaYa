//
//  HomePageViewModel.h
//  XimaLayaText
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"

@interface HomePageViewModel : BaseViewModel


//精品听单cell的数量
@property(nonatomic,assign)NSInteger specialCount;
//热门推荐的 分类栏
@property(nonatomic,strong)NSArray*hotRecommendsArr;

//总共多少区
@property(nonatomic,assign)NSInteger section;

#pragma mark 给三个图片的cell设置各个属性

-(NSString*)mainTitleForSection:(NSInteger)section;
- (BOOL)hasMoreForSection:(NSInteger)section;



//图片
-(NSURL*)coverURLForSection:(NSInteger)section index:(NSInteger)index;
//蒙版标题
-(NSString*)titleForSection:(NSInteger)section index:(NSInteger)index;
//详情标题
-(NSString*)trackTitleForSection:(NSInteger)section index:(NSInteger)index;

#pragma mark 头部滚动视图数据
@property(nonatomic,assign)BOOL exitsScrollView;

@property(nonatomic,assign)NSInteger FocusImgNumber;


-(NSURL*)focusImgURLForIndex:(NSInteger)index;


/** 给SpecialCell的属性方法 */
- (NSString *)footNoteForRow:(NSInteger)row;

@end
