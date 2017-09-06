//
//  HomePageNetManager.m
//  XimaLayaText
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import "HomePageNetManager.h"
#import "HomePageModel.h"

#define HomePageURLPath @"http://mobile.ximalaya.com/mobile/discovery/v1/recommends"


#define URLChannel @"channel":@"and-f5"
#define URLDevice @"device":@"ios"
#define URLActivity @"includeActivity":@"true"
#define URLSpecial @"includeSpecial":@"true"
#define URLScale @"scale":@2
#define URLVersion @"version":@"6.3.9"
//#define URLVersion @"version":@"4.3.26.2"

@implementation HomePageNetManager

+(id)getHomePageCompletionHanader:(void (^)(id, NSError *))complete{
    return [self GET:HomePageURLPath parameters:@{URLChannel,URLDevice,URLActivity,URLSpecial,URLScale,URLVersion} complationHandle:^(id responseObject, NSError *error) {
        complete([HomePageModel mj_objectWithKeyValues:responseObject],error);
    }];
}
@end
