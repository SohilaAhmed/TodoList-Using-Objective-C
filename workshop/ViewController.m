//
//  ViewController.m
//  workshop
//
//  Created by Sohila on 17/01/2023.
//

#import "ViewController.h"
#import "AddViewController.h"
#import "Task.h"
#import "EditViewController.h"
@interface ViewController ()

@end

@implementation ViewController
{
//    NSMutableArray *tasks;
}

static NSMutableArray *first_task;
static NSMutableArray *tasks;
static NSUserDefaults *def;

+ (void)initialize{
    first_task = [NSMutableArray new];
    tasks = [NSMutableArray new];
    def = [NSUserDefaults standardUserDefaults];
    
    if([def objectForKey:@"Task"] == nil){
        NSDate *data = [NSKeyedArchiver archivedDataWithRootObject:first_task];
        [def setObject:data forKey:@"Task"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    tasks = [NSMutableArray new];
    _todo_table.translatesAutoresizingMaskIntoConstraints = NO;
    
//    NSDate *date = [NSKeyedArchiver archivedDataWithRootObject:first_task];
//    [def setObject:date forKey:@"Task"];
}

- (void)viewDidAppear:(BOOL)animated{
    [self.todo_table reloadData];
}

- (void)viewWillAppear:(BOOL)animated{

    NSDate *data2 = [def objectForKey:@"Task"];
    tasks = [NSKeyedUnarchiver unarchiveObjectWithData: data2];
    
    if(tasks.count == 0){
        _label.text = @"Add Tasks";
    }else{
        _label.text = @"";
    }
    [_todo_table reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tasks.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if(tasks.count == 0){
//        _label.text = @"Add Tasks";
//    }
    cell.textLabel.text = [[tasks objectAtIndex:indexPath.row ] t_name];
    cell.imageView.image = [UIImage imageNamed:[[tasks objectAtIndex:indexPath.row ] t_img]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (IBAction)add_view1:(id)sender {
    AddViewController *add = [self.storyboard instantiateViewControllerWithIdentifier:@"AddViewController"];
    
    [self presentViewController:add animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"EditViewController"];
    
    edit.edit_task = [tasks objectAtIndex:indexPath.row];
    edit.index = indexPath.row;
    [self.navigationController pushViewController:edit animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete" message:@"Delete Task?" preferredStyle: UIAlertControllerStyleActionSheet];
    
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            [tasks removeObjectAtIndex:indexPath.row];
            
            NSDate *date = [NSKeyedArchiver archivedDataWithRootObject:tasks];
            [def setObject:date forKey:@"Task"];
            // Delete the row from the data source
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        }
        [self.todo_table reloadData];
    }]; //color red
    
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }]; //normal
    
    [alert addAction:yes];
    [alert addAction:no];
    
    [self presentViewController:alert animated:YES completion:^{
        printf("alert done \n");
    }];
    [_todo_table reloadData];
}

@end
