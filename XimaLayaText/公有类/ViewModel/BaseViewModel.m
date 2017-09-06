//
//  BaseViewModel.m
//  XimaLayaText
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

-(void)cancleTask{
    [self.dataTask cancel];
}

-(void)suspendTask{
    [self.dataTask suspend];
}
-(void)resumeTask{
    [self.dataTask resume];
}
@end
