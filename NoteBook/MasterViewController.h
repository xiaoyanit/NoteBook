//
//  MasterViewController.h
//  NoteBook
//
//  Created by 畅通 on 14-10-14.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "NoteBL.h"
#import "NoteDAO.h"
#import "DetailViewController.h"
#import "NoteCellTableViewCell.h"

@interface MasterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tabelView;

@property(nonatomic,strong)NSMutableArray *listDate;

@end
