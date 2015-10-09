//
//  PlistResources.h
//  EarMaster
//
//  Created by Yun-He-Lee on 15/10/9.
//  Copyright (c) 2015年 EM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlistResources : NSObject
+(instancetype)sharePlist;
-(NSString *)resourceForKey:(NSString *)value theNumber:(NSInteger)index;
@end
