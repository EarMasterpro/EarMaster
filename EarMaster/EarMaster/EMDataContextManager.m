//
//  EMDataContextManager.m
//  EarMaster
//
//  Created by Yun-He-Lee on 15/11/5.
//  Copyright © 2015年 EM. All rights reserved.
//

#import "EMDataContextManager.h"
static NSString * const PerThreadManagedObjectContext = @"PerThreadManagedObjectContext";
@interface EMDataContextManager()
@property(nonatomic,strong)NSManagedObjectContext *managerContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSMutableSet *threadsManagedObjectContexts;
@end
@implementation EMDataContextManager
+(EMDataContextManager *)manager{
    static dispatch_once_t onceToken;
    static EMDataContextManager *obj = nil;
    dispatch_once(&onceToken, ^{
        obj = [[EMDataContextManager alloc]init];
    });
    return obj;
}
-(instancetype)init{
    if (self = [super init]) {
        [self managerContext];
    }
    return self;
}
#pragma 上下文
-(NSManagedObjectContext *)managerContext{
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        dispatch_block_t createContext = ^{
            _managerContext = [[NSManagedObjectContext alloc] initWithConcurrencyType: NSConfinementConcurrencyType];
            
            [_managerContext setMergePolicy: NSMergeByPropertyObjectTrumpMergePolicy];
            [_managerContext setPersistentStoreCoordinator: coordinator];
            
            [self storeManagedObjectContextForCurrentThread:_managerContext];  // store in thread dictionary
        };
        
        if ( [NSThread isMainThread] )
        {
            createContext();
        }
        else
        {
            dispatch_sync(dispatch_get_main_queue(), createContext);
        }
    } else {
        NSLog( @"DANGER !! No NSPersistentStoreCoordinator created !!" );
    }
    
    return _managerContext;

    
}
#pragma 数据模型
-(NSManagedObjectModel *)managedObjectModel{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    NSURL *modelURL =[[NSBundle mainBundle]URLForResource:@"EarMaster" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
    return _managedObjectModel;
    
}
#pragma 数据协调器重新定义
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (_persistentStoreCoordinator!=nil) {
        return _persistentStoreCoordinator;
    }
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"EarMaster.sqlite"];
    NSError *error = nil;
    NSString *errorLog = @"有创建或加载应用程序的存储数据的错误";
    if (! [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"无法初始化应用程序的保存数据";
        dict[NSLocalizedFailureReasonErrorKey] = errorLog;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();//停止程序
        
    }
    
    return _persistentStoreCoordinator;
}
#pragma 文件路径
- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.11bnb.YiYiBnb" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
- (void) storeManagedObjectContextForCurrentThread: (NSManagedObjectContext *) context{
    if (self.threadsManagedObjectContexts == nil) {
        self.threadsManagedObjectContexts = [NSMutableSet new];
    }
    NSThread *currentThread = [NSThread currentThread];
    if (context ==nil) {
        [[currentThread threadDictionary] removeObjectForKey:PerThreadManagedObjectContext];
        @synchronized(self.threadsManagedObjectContexts) {
            [self.threadsManagedObjectContexts removeObject:self.threadsManagedObjectContexts];
        }
        
    }else {
        [[currentThread threadDictionary] setObject: context forKey: PerThreadManagedObjectContext];
        @synchronized(self.threadsManagedObjectContexts) {
            [self.threadsManagedObjectContexts addObject:currentThread];
        }
    }
}
- (void) clearAllThreadsManagedObjectContexts  {
    @synchronized(self.threadsManagedObjectContexts) {
        for (NSThread *thread in self.threadsManagedObjectContexts) {
            [[thread threadDictionary] removeObjectForKey:PerThreadManagedObjectContext];
        }
        [self.threadsManagedObjectContexts removeAllObjects];
    }
}
- (NSManagedObjectContext *) perThreadManagedObjectContext
{
    NSManagedObjectContext * result = [[[NSThread currentThread] threadDictionary] objectForKey: PerThreadManagedObjectContext];
    if ( result != nil )
        return ( result );
    NSManagedObjectContext * moc = [self.managerContext newChildManagedObjectContext];
    [moc setMergePolicy: NSMergeByPropertyObjectTrumpMergePolicy];
    [self storeManagedObjectContextForCurrentThread: moc];
    
    return ( moc );
}
- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managerContext != nil) {
        return _managerContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        dispatch_block_t createContext = ^{
            _managerContext = [[NSManagedObjectContext alloc] initWithConcurrencyType: NSConfinementConcurrencyType];
            
            [_managerContext setMergePolicy: NSMergeByPropertyObjectTrumpMergePolicy];
            [_managerContext setPersistentStoreCoordinator: coordinator];
            
            [self storeManagedObjectContextForCurrentThread:_managerContext];  // store in thread dictionary
        };
        
        if ( [NSThread isMainThread] )
        {
            createContext();
        }
        else
        {
            dispatch_sync(dispatch_get_main_queue(), createContext);
        }
    } else {
        NSLog( @"DANGER !! No NSPersistentStoreCoordinator created !!" );
    }
    
    return _managerContext;
}

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
- (void) dealloc {
    [self reset];
}


- (void) reset {
    _managerContext = nil;
    _persistentStoreCoordinator = nil;
    _managedObjectModel = nil;
}
@end


#pragma mark - NSManagedObjectContext Convienance

@implementation NSManagedObjectContext (Confinement)

- (NSManagedObjectContext *) newChildManagedObjectContext
{
    NSManagedObjectContext * child = [NSManagedObjectContext new];
#if 0
    if ( [self respondsToSelector: @selector(concurrencyType)] && [self concurrencyType] != NSConfinementConcurrencyType )
    {
        [child setParentContext: self];
    }
    else
#endif
    {
        [child setPersistentStoreCoordinator: [self persistentStoreCoordinator]];
    }
    
    return ( child );
}

+ (NSManagedObjectContext*) perThreadContext {
    return [[EMDataContextManager manager] perThreadManagedObjectContext];
}
@end

