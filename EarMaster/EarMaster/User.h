//
//  User.h
//  EarMaster
//
//  Created by Yun-He-Lee on 15/11/7.
//  Copyright © 2015年 EM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSManagedObject
//更新数据
+(User *)updataUserWithDictionary:(NSDictionary *)dictionary inManagedObjectContext:(NSManagedObjectContext*)context;
//查询数据
+(User *)existingBookingWithUserId:(NSNumber *)userId inManagedObjectContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "User+CoreDataProperties.h"
