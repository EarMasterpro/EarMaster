//
//  EMDataContextManager.h
//  EarMaster
//
//  Created by Yun-He-Lee on 15/11/5.
//  Copyright © 2015年 EM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface EMDataContextManager : NSObject
+(EMDataContextManager *)manager;

- (NSManagedObjectContext *)managedObjectContext;
- (void) storeManagedObjectContextForCurrentThread: (NSManagedObjectContext *) context;
- (void) clearAllThreadsManagedObjectContexts;
- (void) reset;
- (void) saveContext;

@end


@interface NSManagedObjectContext (Confinement)
- (NSManagedObjectContext *) newChildManagedObjectContext;
+ (NSManagedObjectContext *) perThreadContext;
@end