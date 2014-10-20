//
//  AddViewController.h
//  NoteBook
//
//  Created by 畅通 on 14-10-14.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "NoteBL.h"

@interface AddViewController : UIViewController<UITextViewDelegate>
- (IBAction)onclickDone:(id)sender;
- (IBAction)onclickSave:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *content;

@end
