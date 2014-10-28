//
//  NoteDAO.m
//  NoteBook
//
//  Created by 畅通 on 14-10-14.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import "NoteDAO.h"

@implementation NoteDAO


static NoteDAO *sharedManager = nil;

+ (NoteDAO*)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        

        
        sharedManager = [[self alloc] init];
//        NSString * path = [[NSBundle mainBundle]pathForResource:@"statusinfo" ofType:@"plist"];
//        NSArray * array = [[NSArray alloc] initWithContentsOfFile:path];
        //sharedManager.notes = [[NSMutableArray alloc] init];
        sharedManager.notesCells = [[NSMutableArray alloc] init];
        [sharedManager managedObjectContext];
       // [sharedManager createEditableCopyOfDatabaseIfNeeded];
//        //类似递归数组操作
//        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            [sharedManager.notes addObject:[Note statusWithDictionary:obj]];
//            NoteCellTableViewCell* cell = [[NoteCellTableViewCell alloc]init];
//            [sharedManager.notesCells addObject:cell];
//        }];

        
        
    });
    return sharedManager;
}
/*- (void)createEditableCopyOfDatabaseIfNeeded {
//    
//    NSString *writableDBPath = [self applicationDocumentsDirectoryFile];
//    
//    if (sqlite3_open([writableDBPath UTF8String], &db)!=SQLITE_OK) {
//        sqlite3_close(db);
//        NSAssert(NO, @"数据库打开失败。");
//    }else{
//    
//        char *err;
//        NSString *createSQL=[NSString stringWithFormat:
//                             @"CREATE TABLE IF NOT EXISTS Note(id INTEGER PRIMARY KEY, profileImageUrl TEXT, userName TEXT,mbtype TEXT,createAt TEXT,source TEXT,text TEXT);"];
//        if (sqlite3_exec(db, [createSQL UTF8String],NULL, NULL, &err)!=SQLITE_OK) {
//            sqlite3_close(db);
//            NSAssert(NO, @"创建表失败，%s",err);
//        }
//        sqlite3_close(db);
//    
//    }
//    
//    
//}
//
//- (NSString *)applicationDocumentsDirectoryFile {
//    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *path = [documentDirectory stringByAppendingPathComponent:DBFILE_NAME];
//    
//    return path;
//}*/

//插入Note方法
-(int) create:(Note*)model{
    BOOL flag=YES;
    
  /*  NSString *path=[self applicationDocumentsDirectoryFile];
    
    if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO, @"打开数据库失败。");
    }else{
        NSString *qsql=@"INSERT OR REPLACE INTO Note ( profileImageUrl , userName ,mbtype ,createAt ,source ,text ) VALUES (?,?,?,?,?,?)";
        sqlite3_stmt *statement;
        //执行
        if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL)==SQLITE_OK) {
          
            
            sqlite3_bind_text(statement, 1, [model.profileImageUrl UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [model.userName UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 3, [model.mbtype UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 4, [model.createAt UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 5, [model.source UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 6, [model.text UTF8String], -1, NULL);
            
            if (sqlite3_step(statement)!=SQLITE_DONE) {
                NSAssert(NO, @"插入失败");
                flag=NO;
            }
            
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(db);
    
    }*/
    NSManagedObjectContext *cxt=[self managedObjectContext];
    NSManagedObject *mo=[NSEntityDescription insertNewObjectForEntityForName:@"MyNote" inManagedObjectContext:cxt];
    [mo setValue:model.profileImageUrl forKey:@"profileImageUrl"];
    [mo setValue:model.userName forKey:@"userName"];
    [mo setValue:model.mbtype forKey:@"mbtype"];
    [mo setValue:model.createAt forKey:@"createAt"];
    [mo setValue:model.source forKey:@"source"];
    [mo setValue:model.text forKey:@"text"];
    [mo setValue:[NSNumber numberWithLongLong:model.id ] forKey:@"id"];
    
    NSError *savingError = nil;
    if ([cxt save:&savingError]) {
        NSLog(@"插入数据成功！");
    }else{
        NSLog(@"插入数据失败");
        flag=NO;
    }
    if (flag) {
        return 1;
    }else{
        return 0;
    }
   }

//删除Note方法
-(int) remove:(Note*)model
{
  BOOL flag=YES;
    NSManagedObjectContext *cxt=[self managedObjectContext];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"MyNote" inManagedObjectContext:cxt];
    
    NSFetchRequest *request=[[NSFetchRequest alloc ]init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"id = %lld",model.id];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    if ([listData count] > 0) {
        NoteManagedObject *note = [listData lastObject];
        [cxt  deleteObject:note];
        
        NSError *savingError = nil;
        if ([cxt save:&savingError]){
            NSLog(@"删除数据成功");
        } else {
            NSLog(@"删除数据失败");
            flag=NO;
        }
    }else{
        NSLog(@"数据没有找到，删除失败。");
        flag=NO;
    }

   /* NSString *path=[self applicationDocumentsDirectoryFile];
    
    if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO, @"打开数据库失败。");
    }else{
        NSString *qsql=@"DELETE  from note where id =?";
        sqlite3_stmt *statement;
        //执行
        if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL)==SQLITE_OK) {
            
            
            sqlite3_bind_int(statement, 1, model.id);
            
            if (sqlite3_step(statement)!=SQLITE_DONE) {
                NSAssert(NO, @"删除失败");
                flag=NO;
            }
            
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(db);
        
    }*/
    if (flag) {
        return 1;
    }else{
        return 0;
    }
}

//修改Note方法
-(int) modify:(Note*)model{
    
    BOOL flag=YES;
    
  /*  NSString *path=[self applicationDocumentsDirectoryFile];
    
    if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO, @"打开数据库失败。");
    }else{
        NSString *qsql=@"UPDATE note set  profileImageUrl=?，userName=?，mbtype=?，source=?，text=? where id =?";
        sqlite3_stmt *statement;
        //执行
        if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL)==SQLITE_OK) {
            
            
            sqlite3_bind_text(statement, 1, [model.profileImageUrl UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [model.userName UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 3, [model.mbtype UTF8String], -1, NULL);
             sqlite3_bind_text(statement, 4, [model.source UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 5, [model.text UTF8String], -1, NULL);
            sqlite3_bind_int(statement, 6, model.id);
            
            if (sqlite3_step(statement)!=SQLITE_DONE) {
                NSAssert(NO, @"修改失败");
                flag=NO;
            }
            
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(db);
        
    }*/
    NSManagedObjectContext *cxt=[self managedObjectContext];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"MyNote" inManagedObjectContext:cxt];
    
    NSFetchRequest *request=[[NSFetchRequest alloc ]init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"id = %lld",model.id];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    if ([listData count] > 0) {
        NoteManagedObject *note = [listData lastObject];
       
        note.profileImageUrl=model.profileImageUrl;
           note.userName=model.userName;
           note.mbtype=model.mbtype;
           note.source=model.source;
           note.text=model.text;

        NSError *savingError = nil;
        if ([cxt save:&savingError]){
            NSLog(@"修改数据成功");
        } else {
            NSLog(@"修改数据失败");
            flag=NO;
        }
    }else{
        NSLog(@"数据没有找到，修改失败。");
        flag=NO;
    }
    
    if (flag) {
        return 1;
    }else{
        return 0;
    }
}

//查询所有数据方法
-(NSMutableArray*) findAll{
    //NSString *path=[self applicationDocumentsDirectoryFile];
    NSMutableArray *listData=[[NSMutableArray alloc] init];
    /*if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败");
    }else{
        NSString *qsql=@"SELECT id , profileImageUrl , userName ,mbtype ,createAt ,source ,text  from Note  ";
        
        sqlite3_stmt *statement;
        if(sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL)==SQLITE_OK  ){
            
            while (sqlite3_step(statement)==SQLITE_ROW) {
                long long id = (long long) sqlite3_column_int(statement, 0);
                NSString *profileImageUrl=   [[NSString alloc] initWithUTF8String: (char *) sqlite3_column_text(statement, 1)];//头像
                
                NSString * userName=   [[NSString alloc] initWithUTF8String: (char *) sqlite3_column_text(statement, 2)];//发送用户
                
                NSString * mbtype=   [[NSString alloc] initWithUTF8String: (char *) sqlite3_column_text(statement, 3)];//会员类型
                
                NSString * createAt=   [[NSString alloc] initWithUTF8String: (char *) sqlite3_column_text(statement, 4)];//创建日期
                
                NSString * source=   [[NSString alloc] initWithUTF8String: (char *) sqlite3_column_text(statement, 5)];//设备来源
                
                NSString * text=   [[NSString alloc] initWithUTF8String: (char *) sqlite3_column_text(statement, 6)];//微博内容
                
                Note *returnNote=[[Note alloc] init];
                returnNote.id=id;
                returnNote.profileImageUrl=profileImageUrl;
                returnNote.userName=userName;
                returnNote.mbtype=mbtype;
                returnNote.createAt=createAt;
                returnNote.source=source;
                returnNote.text=text;
                
                [listData addObject:returnNote];
                [self.notesCells addObject: [[NoteCellTableViewCell alloc] init]];
            }
            
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    
    }*/
    
    NSManagedObjectContext *cxt=[self managedObjectContext];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"MyNote" inManagedObjectContext:cxt];
    
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    //设置排序
    NSSortDescriptor *sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"id" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error=nil;
    NSArray *searchDate=[cxt executeFetchRequest:request error:&error];
    
    for(NoteManagedObject *mo in searchDate){
        Note *returnNote=[[Note alloc] init];
        returnNote.id=[mo.id longLongValue];
        returnNote.profileImageUrl=mo.profileImageUrl;
        returnNote.userName=mo.userName;
        returnNote.mbtype=mo.mbtype;
        returnNote.createAt=mo.createAt;
        returnNote.source=mo.source;
        returnNote.text=mo.text;
        [listData addObject:returnNote];
         [self.notesCells addObject: [[NoteCellTableViewCell alloc] init]];
    }
    
    return listData;
}

//按照主键查询数据方法
-(Note*) findById:(Note*)model{
    Note *returnNote=nil;
    /*NSString *path=[self applicationDocumentsDirectoryFile];
    
    if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO, @"打开数据看失败!");
    }else{
        NSString *qsql=@"SELECT id , profileImageUrl , userName ,mbtype ,createAt ,source ,text  from Note where id =?";
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL)==SQLITE_OK) {
            //绑定参数
            sqlite3_bind_int(statement, 1, model.id);
            //执行sql
            if (sqlite3_step(statement)==SQLITE_ROW) {
                long long id = (long long) sqlite3_column_int(statement, 0);
                NSString *profileImageUrl=   [[NSString alloc] initWithUTF8String: (char *) sqlite3_column_text(statement, 1)];//头像
                
               NSString * userName=   [[NSString alloc] initWithUTF8String: (char *) sqlite3_column_text(statement, 2)];//发送用户
                
                NSString * mbtype=   [[NSString alloc] initWithUTF8String: (char *) sqlite3_column_text(statement, 3)];//会员类型
                
                NSString * createAt=   [[NSString alloc] initWithUTF8String: (char *) sqlite3_column_text(statement, 4)];//创建日期
                
                 NSString * source=   [[NSString alloc] initWithUTF8String: (char *) sqlite3_column_text(statement, 5)];//设备来源
                
                 NSString * text=   [[NSString alloc] initWithUTF8String: (char *) sqlite3_column_text(statement, 6)];//微博内容
                
                Note *returnNote=[[Note alloc] init];
                returnNote.id=id;
                returnNote.profileImageUrl=profileImageUrl;
                returnNote.userName=userName;
                returnNote.mbtype=mbtype;
                returnNote.createAt=createAt;
                returnNote.source=source;
                returnNote.text=text;
             
                
                
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    
    }*/
    
    NSManagedObjectContext *cxt=[self managedObjectContext];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"MyNote" inManagedObjectContext:cxt];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"id = %lld",model.id];
    [request setPredicate:predicate];
    
    NSError *error=nil;
    NSArray *resultArray=[cxt executeFetchRequest:request error:&error];
    
    if ([resultArray count]>0) {
        NoteManagedObject *mo =[resultArray lastObject];
        returnNote=[[Note alloc]init];
        returnNote.id=[mo.id longLongValue];
        returnNote.profileImageUrl=mo.profileImageUrl;
        returnNote.userName=mo.userName;
        returnNote.mbtype=mo.mbtype;
        returnNote.createAt=mo.createAt;
        returnNote.source=mo.source;
        returnNote.text=mo.text;
    }
    
    return returnNote;
}



-(NSMutableArray*) findAllCell{
    return self.notesCells;
}

-(int) createCell:(NoteCellTableViewCell *)modelCell{
    [self.notesCells addObject:modelCell];
    return 0;
}

//删除Note方法
-(int) removeCell:(NoteCellTableViewCell*)modelCell
{
    [self.notesCells removeObject:modelCell];
    return 0;
}

-(NSString *)getNowDate{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *createAt=[dateFormatter stringFromDate:[NSDate date] ];
    return createAt;
}
-(long long)getNoteID{
    long long result=0;
    NSManagedObjectContext *cxt=[self managedObjectContext];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"MyNote" inManagedObjectContext:cxt];
    
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    //设置排序
    NSSortDescriptor *sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"id" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error=nil;
    NSArray *searchDate=[cxt executeFetchRequest:request error:&error];
    
    if ([searchDate count]>0) {
        NoteManagedObject *mo =[searchDate lastObject];
        result=[mo.id longLongValue];
    }
    
    return result;
    
}

@end
