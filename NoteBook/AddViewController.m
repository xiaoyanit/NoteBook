//
//  AddViewController.m
//  NoteBook
//
//  Created by 畅通 on 14-10-14.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.content.delegate=self;
    //self.content.keyboardType = UIKeyboardTypeDefault;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onclickDone:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onclickSave:(id)sender {
    
    NoteBL *noteBL=[[NoteBL alloc] init];
    Note *note=[[Note alloc] init];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    note.createAt= [dateFormatter stringFromDate:[NSDate date] ];
    note.id=[noteBL getNoteID]+1;
    note.text=self.content.text;
    note.profileImageUrl = @"touxiang1.png";
    note.userName = @"tom_changt";
    note.mbtype =@"vip.png";
    note.source = @"iphone 6";
    NSMutableArray *rList= [noteBL createNote:note];
    NSMutableArray *cList=[noteBL createCell:[[NoteCellTableViewCell alloc] init]];
    
    NSMutableDictionary *map=[[NSMutableDictionary alloc ] init];
    [map setValue:rList forKey:@"notes"];
    [map setValue:cList forKey:@"notesCell"];
    
   [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:map userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return  YES;



}





@end
