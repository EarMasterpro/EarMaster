//
//  User.m
//  EarMaster
//
//  Created by Yun-He-Lee on 15/11/7.
//  Copyright © 2015年 EM. All rights reserved.
//

#import "User.h"

@implementation User
#pragma 更新数据
+(User *)updataUserWithDictionary:(NSDictionary *)dictionary inManagedObjectContext:(NSManagedObjectContext*)context{
    if (dictionary ==nil) {
        return nil;
    }
    if ([dictionary objectForKey:@"userId"] ==nil) {
        return nil;
    }
    NSNumber *userId = [dictionary objectForKey:@"userId"];
    User *user = [User findOrCreateuserWithID:userId inManagedObjectContext:context];
   
    return user;
}
+ (User *)findOrCreateuserWithID:(NSNumber *)userId inManagedObjectContext: (NSManagedObjectContext *)context {
    if (!userId) {
        return nil;
    }
    
    User *user = [[self class] existingBookingWithUserId:userId inManagedObjectContext:context];
    if (user) {
        return user;
    }
    
    user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    
    return user;
}
+ (User *)existingBookingWithUserId:(NSNumber *)userId inManagedObjectContext:(NSManagedObjectContext *)context {
    if (userId == nil) {
        return nil;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId==%@",userId];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:context]];
    [request setPredicate:predicate];
    [request setFetchLimit:1];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    User *user = [results lastObject];
    if (error != nil) {
        NSLog(@"error fetch %@: %@",userId, error);
    }
    
    return user;
}

@end
