//
//  User+CoreDataProperties.h
//  EarMaster
//
//  Created by Yun-He-Lee on 15/11/7.
//  Copyright © 2015年 EM. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"
#import "Experience.h"
NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *userId;
@property (nullable, nonatomic, retain) Experience *experience;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *level;
@property (nullable, nonatomic, retain) NSManagedObject *props;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addLevelObject:(NSManagedObject *)value;
- (void)removeLevelObject:(NSManagedObject *)value;
- (void)addLevel:(NSSet<NSManagedObject *> *)values;
- (void)removeLevel:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
