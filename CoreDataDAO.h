//
//  CoreDataDAO.h
//  NoteBook
//
//  Created by 畅通 on 14/10/26.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataDAO : NSObject

@property(readonly,strong,nonatomic)NSManagedObjectContext *managedObjectContext;
@property(readonly,strong,nonatomic)NSManagedObjectModel *managedObjectModel;
@property(readonly,strong,nonatomic)NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
@end
