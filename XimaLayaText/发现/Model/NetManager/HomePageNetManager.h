//
//  HomePageNetManager.h
//  XimaLayaText
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNetManager.h"
@interface HomePageNetManager : BaseNetManager


+(id)getHomePageCompletionHanader:(void(^)(id responseObject,NSError*error))complete;

@end
