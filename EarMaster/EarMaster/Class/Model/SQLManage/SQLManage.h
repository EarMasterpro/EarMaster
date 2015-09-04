//
//  SQLManage.h
//  EarMaster
//
//  Created by 徐艺达 on 15/9/4.
//  Copyright (c) 2015年 EM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface SQLManage : NSObject

@property (strong, nonatomic) FMDatabase *db; //数据库
@property (strong, nonatomic) NSString *path; //数据库路径


//单利模式
+ (SQLManage *)shared;

//查询
+ (NSMutableArray *)selectWithText:(NSString *)text columns:(NSInteger)columns;


@end


