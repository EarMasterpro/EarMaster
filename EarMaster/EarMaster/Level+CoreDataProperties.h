//
//  Level+CoreDataProperties.h
//  EarMaster
//
//  Created by Yun-He-Lee on 15/11/7.
//  Copyright © 2015年 EM. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Level.h"

NS_ASSUME_NONNULL_BEGIN

@interface Level (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *isThrough;
@property (nullable, nonatomic, retain) NSString *levelType;
@property (nullable, nonatomic, retain) NSSet<LevelNum *> *levelNum;

@end

@interface Level (CoreDataGeneratedAccessors)

- (void)addLevelNumObject:(LevelNum *)value;
- (void)removeLevelNumObject:(LevelNum *)value;
- (void)addLevelNum:(NSSet<LevelNum *> *)values;
- (void)removeLevelNum:(NSSet<LevelNum *> *)values;

@end

NS_ASSUME_NONNULL_END
