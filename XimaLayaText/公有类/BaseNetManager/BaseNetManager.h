//
//  BaseNetManager.h
//  XimaLayaText
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseNetManager : NSObject

+(id)GET:(NSString*)path parameters:(NSDictionary*)params complationHandle:(void(^)(id responseObject,NSError * error))completd;
+(id)POST:(NSString*)path parameters:(NSDictionary*)params complationHandle:(void(^)(id responseObject,NSError * error))completd;


@end
