//
//  LevelNum+CoreDataProperties.h
//  EarMaster
//
//  Created by Yun-He-Lee on 15/11/7.
//  Copyright © 2015年 EM. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LevelNum.h"

NS_ASSUME_NONNULL_BEGIN

@interface LevelNum (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *isFristThrough;
@property (nullable, nonatomic, retain) NSNumber *isThrough;
@property (nullable, nonatomic, retain) NSNumber *level;

@end

NS_ASSUME_NONNULL_END
