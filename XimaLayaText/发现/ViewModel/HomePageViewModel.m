//
//  HomePageViewModel.m
//  XimaLayaText
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import "HomePageViewModel.h"
#import "HomePageNetManager.h"
#import "HomePageModel.h"
@interface HomePageViewModel()

@property(nonatomic,strong)HomePageModel * model;

@end
@implementation HomePageViewModel


-(void)getDataCompletionHandle:(void (^)(NSError *))completed{
   self.dataTask=[HomePageNetManager getHomePageCompletionHanader:^(HomePageModel * responseObject, NSError *error) {
       
       self.model=responseObject;
       
       self.hotRecommendsArr=responseObject.hotRecommends.list;
       self.section=self.hotRecommendsArr.count+2;

       completed(error);
              
   }];
}

-(NSString*)mainTitleForSection:(NSInteger)section{
    if (section==0) {
        return self.model.editorRecommendAlbums.title;
    }else if (section==1){
        return self.model.specialColumn.title;
    }else{
        return  self.model.hotRecommends.list[section-2].title;
    }
}

- (BOOL)hasMoreForSection:(NSInteger)section {
    if (section == 0) {  // 小编推荐
        return self.model.editorRecommendAlbums.hasMore;
    } else if (section == 1) {  //精品听单
        return self.model.specialColumn.hasMore;
    } else if (section == 2) {  // 发现新奇
        return YES;
    }else{
        return YES;
    }
}
//图片
-(NSURL*)coverURLForSection:(NSInteger)section index:(NSInteger)index{
    NSString*path=nil;
    if (section==0) {
        path=self.model.editorRecommendAlbums.list[index].coverLarge;
    }else if (section==1){
        path=self.model.specialColumn.list[index].coverPath;
    }else{
        path = self.model.hotRecommends.list[section - 2].list[index].coverLarge;
    }
    return [NSURL URLWithString:path];
}
//蒙版标题
-(NSString*)titleForSection:(NSInteger)section index:(NSInteger)index{
    if (section==0) {
        return self.model.editorRecommendAlbums.list[index].title;
    }else if (section==1){
        return self.model.specialColumn.list[index].title;
    }else{
        return self.model.hotRecommends.list[section - 2].list[index].title;
    }

}
//详情标题
-(NSString*)trackTitleForSection:(NSInteger)section index:(NSInteger)index{
    if (section==0) {
        return self.model.editorRecommendAlbums.list[index].trackTitle;
    }else if (section==1){
        return self.model.specialColumn.list[index].subtitle;
    }else{
        return self.model.hotRecommends.list[section - 2].list[index].trackTitle;
    }

}

#pragma mark 头部滚动视图数据
//是否有滚动视图
-(BOOL)isExitsScrollView{
    return self.model.focusImages.list!=nil && self.model.focusImages.list.count!=0 && ![self.model.focusImages.list isKindOfClass:[NSNull class]];
}
//滚动视图图片数量
-(NSInteger)FocusImgNumber{
    return self.model.focusImages.list.count;
}
//图片URL
-(NSURL*)focusImgURLForIndex:(NSInteger)index{
    NSString * path=self.model.focusImages.list[index].pic;
    return [NSURL URLWithString:path];
    
}

/** 给SpecialCell的属性方法 */
- (NSString *)footNoteForRow:(NSInteger)row {
    return self.model.specialColumn.list[row].footnote;
}


//精品听单cell的数量
-(NSInteger)specialCount{
    return self.model.specialColumn.list.count;
}

@end
