//
//  DetailViewController.h
//  NoteBook
//
//  Created by 畅通 on 14-10-14.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *content;
@property(nonatomic,strong)Note *note;
-(void)setDetailNote:(Note *)newNote;
@end
