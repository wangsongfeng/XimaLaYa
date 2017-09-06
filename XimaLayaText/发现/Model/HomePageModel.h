//
//  HomePageModel.h
//  XimaLayaText
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@class FocusImageView,FocusImageList,EditorRA,EditorRAList,SpecialC,SpecialCList,HotR,HotRList,HotR_List_List;
@interface HomePageModel :BaseModel

@property(nonatomic,strong)FocusImageView*focusImages;
@property(nonatomic,strong)EditorRA * editorRecommendAlbums;
@property(nonatomic,strong)SpecialC * specialColumn;

@property (nonatomic,strong) HotR * hotRecommends;

@end


//小编推荐
@interface EditorRA : BaseModel
@property(nonatomic,assign)NSInteger ret;
@property(nonatomic,copy)NSString*title;
@property(nonatomic,strong)NSArray<EditorRAList *>*list;
@property (nonatomic, assign) BOOL hasMore;

@end

@interface EditorRAList : BaseModel
@property (nonatomic, assign) NSInteger tracks;

@property (nonatomic, assign) NSInteger serialState;

@property (nonatomic, assign) NSInteger albumId;

@property (nonatomic, assign) NSInteger trackId;

@property (nonatomic, assign) NSInteger isFinished;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *trackTitle;

@property (nonatomic, copy) NSString *coverLarge;

@property (nonatomic, copy) NSString *tags;

@property (nonatomic, assign) NSInteger playsCounts;

@end








//循环滚动视图
@interface FocusImageView : BaseModel

@property(nonatomic,assign)NSInteger ret;
@property(nonatomic,copy)NSString*title;
@property(nonatomic,strong)NSArray<FocusImageList *>*list;

@end

@interface FocusImageList : BaseModel
@property(nonatomic,assign)NSInteger specialId;
@property(nonatomic,assign)NSInteger subType;
@property(nonatomic,copy)NSString*shortTitle;
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,copy)NSString*pic;
@property(nonatomic,assign)BOOL isShare;
@property(nonatomic,assign)BOOL is_External_url;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,copy)NSString*longTitle;

@end






//精品听单
@interface SpecialC : BaseModel
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray<SpecialCList *> *list;

@property (nonatomic, assign) BOOL hasMore;

@property (nonatomic, assign) NSInteger ret;

@end

@interface SpecialCList : BaseModel

@property (nonatomic, assign) NSInteger specialId;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, copy) NSString *coverPath;

@property (nonatomic, copy) NSString *contentType;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *footnote;

@property (nonatomic, assign) NSInteger columnType;

@end

//热门推荐
@interface HotR : BaseModel
@property (nonatomic,assign) NSInteger ret;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,strong) NSArray<HotRList*>*list;

@end

@interface HotRList : BaseModel
@property (nonatomic, assign) BOOL hasMore;

@property (nonatomic, copy) NSString *contentType;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL isFinished;

@property (nonatomic, assign) NSInteger categoryId;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSArray<HotR_List_List *> *list;

@end

@interface HotR_List_List : BaseModel

@property (nonatomic, assign) NSInteger tracks;

@property (nonatomic, assign) NSInteger serialState;

@property (nonatomic, assign) NSInteger albumId;

@property (nonatomic, assign) NSInteger trackId;

@property (nonatomic, assign) NSInteger isFinished;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *trackTitle;

@property (nonatomic, copy) NSString *coverLarge;

@property (nonatomic, copy) NSString *tags;

@property (nonatomic, assign) NSInteger playsCounts;

@end
