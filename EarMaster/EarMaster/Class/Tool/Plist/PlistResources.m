//
//  PlistResources.m
//  EarMaster
//
//  Created by Yun-He-Lee on 15/10/9.
//  Copyright (c) 2015年 EM. All rights reserved.
//

#import "PlistResources.h"

@implementation PlistResources

+(instancetype)sharePlist{
    static PlistResources *plist;
    static dispatch_once_t oneceToken;
    dispatch_once(&oneceToken, ^{
        plist = [[PlistResources alloc] init];
    });
    return plist;
}
-(NSString *)resourceForKey:(NSString *)value theNumber:(NSInteger)index {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"CheckPoint" ofType:@"plist"];
    NSDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray *arr =  data[@"checkResources"];
    return [[arr objectAtIndex:index] objectForKey:value];
}
@end
