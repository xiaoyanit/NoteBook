//
//  NoteBL.h
//  NoteBook
//
//  Created by 畅通 on 14-10-15.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "NoteDAO.h"
#import "NoteCellTableViewCell.h"

@interface NoteBL : NSObject
//插入Note方法
-(NSMutableArray*) createNote:(Note*)model;

//删除Note方法
-(NSMutableArray*) remove:(Note*)model;

//查询所用数据方法
-(NSMutableArray*) findAll;


-(NSMutableArray*) findAllCell;

//插入Cell方法
-(NSMutableArray*) createCell:(NoteCellTableViewCell*)modelCell;

//删除Note方法
-(NSMutableArray*) removeCell:(NoteCellTableViewCell*)modelCell;

-(long long)getNoteID;
@end
