//
//  NoteDAO.h
//  NoteBook
//
//  Created by 畅通 on 14-10-14.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "NoteCellTableViewCell.h"
#import <sqlite3.h>

#define  DBFILE_NAME @"NotesList.sqllite3"
@interface NoteDAO : NSObject{
    sqlite3 *db;
}

//保存数据列表
@property (nonatomic,strong) NSMutableArray* notesCells;

+ (NoteDAO*)sharedManager;

- (NSString *)applicationDocumentsDirectoryFile;
- (void)createEditableCopyOfDatabaseIfNeeded;

//插入Note方法
-(int) create:(Note*)model;
//插入Cell方法
-(int) createCell:(NoteCellTableViewCell *)modelCell;
-(int) removeCell:(NoteCellTableViewCell*)modelCell;

//删除Note方法
-(int) remove:(Note*)model;

//修改Note方法
-(int) modify:(Note*)model;

//查询所有数据方法
-(NSMutableArray*) findAll;
//查询所有数据方法
-(NSMutableArray*) findAllCell;

//按照主键查询数据方法
-(Note*) findById:(Note*)model;




-(NSString *)getNowDate;

@end

