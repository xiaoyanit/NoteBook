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
        sharedManager.notes = [[NSMutableArray alloc] init];
        sharedManager.notesCells = [[NSMutableArray alloc] init];
        
//        //类似递归数组操作
//        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            [sharedManager.notes addObject:[Note statusWithDictionary:obj]];
//            NoteCellTableViewCell* cell = [[NoteCellTableViewCell alloc]init];
//            [sharedManager.notesCells addObject:cell];
//        }];

        
        
    });
    return sharedManager;
}

//插入Note方法
-(int) create:(Note*)model
{
    BOOL flag=YES;
     for (Note* note in self.notes) {
         if ( note.id ==model.id){
             flag=NO;
             break;
         }
     }
    if (flag) {
        [self.notes addObject:model];
    }
    
    return 0;
}

//删除Note方法
-(int) remove:(Note*)model
{
    for (Note* note in self.notes) {
        //比较主键是否相等
        if ( note.id ==model.id){
            [self.notes removeObject: note];
            break;
        }
    }
    
    return 0;
}

//修改Note方法
-(int) modify:(Note*)model
{
    for (Note* note in self.notes) {
        //比较日期主键是否相等
        if (note.id ==model.id){
            [self remove:note];
            [self create:model];
            break;
        }
    }
    return 0;
}

//查询所有数据方法
-(NSMutableArray*) findAll
{
    return self.notes;
}

//按照主键查询数据方法
-(Note*) findById:(Note*)model
{
    for (Note* note in self.notes) {
        //比较日期主键是否相等
        if (note.id ==model.id){
            return note;
        }
    }
    return nil;
}

//获得主键的方法
-(long long )findKey{
    
    long long noteId=0;
    for(Note * note in self.notes){
        if (note.id>noteId) {
            noteId=note.id;
        }
    }
    return  noteId;
    
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

@end
