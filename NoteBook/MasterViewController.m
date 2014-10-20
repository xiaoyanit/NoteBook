//
//  MasterViewController.m
//  NoteBook
//
//  Created by 畅通 on 14-10-14.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import "MasterViewController.h"


@interface MasterViewController (){
    NSMutableArray * _notes;
    NSMutableArray *_notesCells;//存储cell，用于计算高度
}

@end

@implementation MasterViewController

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
    self.tabelView.delegate=self;
    self.tabelView.dataSource=self;
    //NoteBL *noteBL=[[NoteBL alloc] init];
    //self.listDate=[noteBL findAll];
    [self initData];
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTabView:) name:@"reloadViewNotification" object:nil];
}

#pragma mark 加载数据
- (void)initData{
    //self.navigationItem.leftBarButtonItem=self.editButtonItem;
        NoteBL *noteBL=[[NoteBL alloc]init];
  
        _notes = [noteBL findAll];
        _notesCells = [noteBL findAllCell];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -uitableViewDateSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_notes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"Cell";
    NoteCellTableViewCell * cell;
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NoteCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    Note * note = _notes[[indexPath row]];
    cell.note = note;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoteCellTableViewCell * cell = _notesCells[indexPath.row];
    cell.note = _notes[indexPath.row];
    return cell.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row =[indexPath row];
    Note * note= [_notes objectAtIndex:row];
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"MainStoryboard_IPhone" bundle:nil];
    DetailViewController *detailViewController= [mainStoryboard  instantiateViewControllerWithIdentifier:@"detailViewController"];

    
    [detailViewController setDetailNote:note];
      [self.navigationController pushViewController:detailViewController animated:YES];
    
}

//#pragma mark 重写状态样式方法
//-(UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleDefault;
//}
//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}

//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return  UITableViewCellEditingStyleDelete;
//}

#pragma mark --UITableViewDataSource协议方法,tableView:commitEditingStyle:forRowAtIndexPath 用于实现删除或插入处理,withRowAnimation删除时候的动画
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle ==UITableViewCellEditingStyleDelete) {
        NoteBL *noteBl=[[NoteBL alloc] init];
        Note *note=  [_notes objectAtIndex:  [indexPath row]];
          _notes =[noteBl remove:note];
        _notesCells=[noteBl removeCell:[[NoteCellTableViewCell alloc] init]];
        //删除动画
        [self.tabelView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tabelView reloadData];
    }
    
}
//删除文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}



//-(void) setEditing:(BOOL)editing animated:(BOOL)animated{
//    [super setEditing:editing animated:animated];
//    [self.tabelView setEditing:editing animated:YES];
//   
//}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ( [segue.identifier isEqualToString:@"ForwardDetail"]) {
//        DetailViewController *detailViewController=segue.destinationViewController;
//        NSInteger row=  [[self.tabelView indexPathForSelectedRow] row];//选择的行数
//        Note *selectedNote=   [self.listDate objectAtIndex:row];
//        [detailViewController setDetailNote:selectedNote];
//    }
}

-(void)reloadTabView:(NSNotification *)notefication{
    NSMutableDictionary *list=[notefication object];
    _notes =[list objectForKey:@"notes"] ;
    _notesCells=[list objectForKey:@"notesCell"];
    [self.tabelView reloadData];
    
}


@end
