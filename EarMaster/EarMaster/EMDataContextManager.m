//
//  EMDataContextManager.m
//  EarMaster
//
//  Created by Yun-He-Lee on 15/11/5.
//  Copyright © 2015年 EM. All rights reserved.
//

#import "EMDataContextManager.h"

@implementation EMDataContextManager
+(EMDataContextManager *)manager{
    static dispatch_once_t onceToken;
    static EMDataContextManager *obj = nil;
    dispatch_once(&onceToken, ^{
        obj = [[EMDataContextManager alloc]init];
    });
    return obj;
}
-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}
@end
