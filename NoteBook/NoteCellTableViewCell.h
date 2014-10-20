//
//  NoteCellTableViewCell.h
//  NoteBook
//
//  Created by 畅通 on 14-10-16.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface NoteCellTableViewCell : UITableViewCell

#pragma mark  笔记对象
@property(nonatomic,strong)Note *note;

#pragma mark 单元格高度
@property(nonatomic,assign)CGFloat cellHeight;


@end
