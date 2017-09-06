//
//  DatabaseManager.m
//  XimaLayaText
//
//  Created by apple on 2017/5/19.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import "DatabaseManager.h"
#import <sqlite3.h>
#import "UserModel.h"
static DatabaseManager * manager=nil;
sqlite3 * sqlite=nil;
@implementation DatabaseManager

+(instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[DatabaseManager alloc]init];
    });
    return manager;
}
//打开数据库
-(BOOL)openSqlite
{
    NSString *fileName = [self path];
    //(1)打开数据库
    int openResult = sqlite3_open([fileName UTF8String], &sqlite);
    if (openResult != SQLITE_OK) {
        
        return NO;
    }
    
    return YES;
    
    
}
//创建表
-(void)creattable
{
    
    if ([self openSqlite]) {
        
        NSLog(@"打开数据库成功");
        char *error;
        
        //    建表格式: create table if not exists 表名 (列名 类型,....)    注: 如需生成默认增加的id: id integer primary key autoincrement
        const char *createSQL = "create table if not exists w_xiaozhu(id integer primary key autoincrement,themeName TEXT,imageName TEXT,leftW int NOT NULL,topH int NOT NULL)";
        
        int tableResult = sqlite3_exec(sqlite, createSQL, NULL, NULL, &error);
        
        if (tableResult != SQLITE_OK) {
            
            NSLog(@"创建表失败:%s",error);
        }else
        {
            NSLog(@"创建表成功");
        }
    }else
    {
        NSLog(@"打开数据库失败");

    }

}

-(void)insertModelwith:(NSString*)themeName andWithImageName:(NSString*)imageName withLeftW:(int)leftW withTopH:(int)topH
{
    [self openSqlite];
    //sql语句
    char * sql="insert into w_xiaozhu(themeName,imageName,leftW,topH) values(?,?,?,?)";
    //存储的内容
    sqlite3_stmt * stmp;
    //执行语句并接受结果
    int result=sqlite3_prepare_v2(sqlite, sql, -1, &stmp, NULL);
    //判断是否成功
    if (result==SQLITE_OK) {
        //绑定数据
        sqlite3_bind_text(stmp, 1, [themeName UTF8String], -1, NULL);
        sqlite3_bind_text(stmp, 2, [imageName UTF8String], -1, NULL);
        sqlite3_bind_int(stmp, 3, leftW);
        sqlite3_bind_int(stmp, 4, topH);
        //执行插入语句
        if (sqlite3_step(stmp)==SQLITE_DONE) {
            NSLog(@"插入成功");
        }else{
            NSLog(@"插入失败");
        }

    }else
    {
        
    }
    sqlite3_finalize(stmp);
    
}
//根据图片名查询
-(NSMutableArray*)searchImageNameWith:(NSString*)imageName
{
    NSMutableArray * imageNameArray=[NSMutableArray array];
    if ([self openSqlite]) {
        //(2)准备SQL语句
        //1> 准备语句
        
        NSString *statement =[NSString stringWithFormat:@"select id,themeName,imageName,leftW,topH from w_xiaozhu where imageName ='%@'",imageName];
        sqlite3_stmt *stmt = nil;
        sqlite3_prepare(sqlite, [statement UTF8String], -1, &stmt, nil);
        
        //2>绑定参数
        
        //(3)执行sql语句
        int stepResult = sqlite3_step(stmt);
        
        while (stepResult == SQLITE_ROW) {
            
            //拿取数据
            const char *themeName = (const char *)sqlite3_column_text(stmt, 0);
            const char *imageName = (const char *)sqlite3_column_text(stmt, 1);
            double leftW = sqlite3_column_double(stmt, 2);
            double topH = sqlite3_column_double(stmt, 3);

            
            UserModel *model =[[UserModel alloc] init];
            model.themeName = [NSString stringWithUTF8String:themeName];
            model.imageName = [NSString stringWithUTF8String:imageName];
            model.leftW = leftW;
            model.topH = topH;

            
            [imageNameArray addObject:model];
            
            stepResult = sqlite3_step(stmt);
        }
        
        //(4)完结语句
        sqlite3_finalize(stmt);
        
        //(5) 关闭数据库
        sqlite3_close(sqlite);

    }
    
    return imageNameArray;
}
//根据主题查询
-(NSMutableArray*)searchThemeNameWith:(NSString*)themeName
{
    NSMutableArray * themeNameArray=[NSMutableArray array];
    if ([self openSqlite]) {
        //(2)准备SQL语句
        //1> 准备语句
        
        NSString *statement =[NSString stringWithFormat:@"select themeName,imageName,leftW,topH from w_xiaozhu where themeName ='%@'",themeName];
        sqlite3_stmt *stmt = nil;
        sqlite3_prepare_v2(sqlite, [statement UTF8String], -1, &stmt, NULL);
        
        //2>绑定参数
        
        //(3)执行sql语句
        int stepResult = sqlite3_step(stmt);
        
        while (stepResult == SQLITE_ROW) {
            
            //拿取数据
            const char *themeName = (const char *)sqlite3_column_text(stmt, 0);
            const char *imageName = (const char *)sqlite3_column_text(stmt, 1);
            int leftW = sqlite3_column_int(stmt, 2);
            int topH = sqlite3_column_int(stmt, 3);
            
            
            UserModel *model =[[UserModel alloc] init];
            model.themeName = [NSString stringWithUTF8String:themeName];
            model.imageName = [NSString stringWithUTF8String:imageName];
            model.leftW = leftW;
            model.topH = topH;
                        
            [themeNameArray addObject:model];
            
            stepResult = sqlite3_step(stmt);
        }
        
        //(4)完结语句
        sqlite3_finalize(stmt);
        
        //(5) 关闭数据库
        sqlite3_close(sqlite);
        
    }
    
    return themeNameArray;

}
-(NSString *)path{
    
    NSArray *documentArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentPath = [documentArr firstObject];
    // crylown.db 为数据库的名字
    NSString *path = [documentPath stringByAppendingString:@"/xiaozhuIpad.sqlite"];
    NSLog(@"%@",path);

    
    return path;
    
}
@end
