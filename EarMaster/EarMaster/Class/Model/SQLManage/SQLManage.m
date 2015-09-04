//
//  SQLManage.m
//  EarMaster
//
//  Created by 徐艺达 on 15/9/4.
//  Copyright (c) 2015年 EM. All rights reserved.
//

#import "SQLManage.h"

static SQLManage *sqlManage = nil;

@implementation SQLManage

#pragma mark - private

- (FMDatabase *)dbOpen
{
    FMDatabase *db = [FMDatabase databaseWithPath:self.path];
    if (![db open]) {
        [db setShouldCacheStatements:YES];
    }
    return db;
}

#pragma mark - common

+ (SQLManage *)shared
{
    if (sqlManage == nil) {
        sqlManage = [[SQLManage alloc] init];
        sqlManage.db = [sqlManage dbOpen];
    }
    return sqlManage;
}

+ (NSMutableArray *)selectWithText:(NSString *)text columns:(NSInteger)columns
{
    FMDatabase *db = [SQLManage shared].db;
    if (![db open]) {
        [db setShouldCacheStatements:YES];
    }
    return [db selectData:text  resultColumns:columns];
}

#pragma mark - getting

- (NSString *)path
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"EarMaster.sqlite"];
}


@end







