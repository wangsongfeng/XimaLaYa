//
//  DatabaseManager.h
//  XimaLayaText
//
//  Created by apple on 2017/5/19.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseManager : NSObject

+(instancetype)shareManager;
-(void)creattable;
-(void)insertModelwith:(NSString*)themeName andWithImageName:(NSString*)imageName withLeftW:(int)leftW withTopH:(int)topH;
//根据图片名查询
-(NSMutableArray*)searchImageNameWith:(NSString*)imageName;
//根据主题查询
-(NSMutableArray*)searchThemeNameWith:(NSString*)themeName;
@end
