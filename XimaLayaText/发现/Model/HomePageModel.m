//
//  HomePageModel.m
//  XimaLayaText
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import "HomePageModel.h"

@implementation HomePageModel

@end




@implementation FocusImageView

+(NSDictionary*)mj_objectClassInArray{
    return @{@"list" : [FocusImageList class]};
}

@end

@implementation FocusImageList

@end




@implementation EditorRA
+(NSDictionary*)mj_objectClassInArray{
    return @{@"list" : [EditorRAList class]};
}
@end

@implementation EditorRAList

@end





@implementation SpecialC

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [SpecialCList class]};
}

@end

@implementation SpecialCList

@end

