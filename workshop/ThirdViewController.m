//
//  ThirdViewController.m
//  workshop
//
//  Created by Sohila on 17/01/2023.
//

#import "ThirdViewController.h"
#import "Task.h"
#import "EditDoneViewController.h"
@interface ThirdViewController ()

@end

@implementation ThirdViewController
{
    Task *task_d;
    NSMutableArray *low_done;
    NSMutableArray *medium_done;
    NSMutableArray *high_done;
    
}
static NSMutableArray *done;
static NSUserDefaults *def;

static NSDate *data;

+ (void)initialize{
    done = [NSMutableArray new];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    def = [NSUserDefaults standardUserDefaults];
    [self.done_table reloadData];
}
- (void)viewWillAppear:(BOOL)animated{
    self.state_done.selectedSegmentIndex = UISegmentedControlNoSegment;
    NSDate *done_data = [def objectForKey:@"Done"];
    done = [NSKeyedUnarchiver unarchiveObjectWithData: done_data];
    
    
    [self.done_table reloadData];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    low_done = [NSMutableArray new];
    medium_done = [NSMutableArray new];
    high_done = [NSMutableArray new];
    task_d = [Task new];
    for (int i = 0; i < done.count; i++){
        task_d = [done objectAtIndex:i];
        if([[[done objectAtIndex:i] t_priority] isEqualToString:@"Low"]){
            [low_done addObject:task_d];
        }
        else if ([[[done objectAtIndex:i] t_priority] isEqualToString:@"Medium"]){
            [medium_done addObject:task_d];
        }
        else if ([[[done objectAtIndex:i] t_priority] isEqualToString:@"High"]){
            [high_done addObject:task_d];
        }
    }
    
    [self.done_table reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger numberOfRows = 0;
    
    if(self.state_done.selectedSegmentIndex == 0){
        switch(section){
            case 0: //low
                numberOfRows = low_done.count;
                break;
            case 1: // medium
                numberOfRows = 0;
                break;
            case 2: //high
                numberOfRows = 0;
        }
    }else if(self.state_done.selectedSegmentIndex == 1){
        switch(section){
            case 0: //low
                numberOfRows = 0;
                break;
            case 1: // medium
                numberOfRows = medium_done.count;
                break;
            case 2: //high
                numberOfRows = 0;
        }
    }else if(self.state_done.selectedSegmentIndex == 2){
        switch(section){
            case 0: //low
                numberOfRows = 0;
                break;
            case 1: // medium
                numberOfRows = 0;
                break;
            case 2: //high
                numberOfRows = high_done.count;
        }
    }else{
        switch(section){
            case 0: //low
                numberOfRows = low_done.count;
                break;
            case 1: // medium
                numberOfRows = medium_done.count;
                break;
            case 2: //high
                numberOfRows = high_done.count;
        }
    }
    return numberOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];

    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [[low_done objectAtIndex:indexPath.row] t_name];
            cell.imageView.image = [UIImage imageNamed:[[low_done objectAtIndex:indexPath.row] t_img]];
            cell.detailTextLabel.text = @"low";
            break;
        case 1:
            cell.textLabel.text = [[medium_done objectAtIndex:indexPath.row] t_name];
            cell.imageView.image = [UIImage imageNamed:[[medium_done objectAtIndex:indexPath.row] t_img]];
            cell.detailTextLabel.text = @"medium";
            break;
        case 2:
            cell.textLabel.text = [[high_done objectAtIndex:indexPath.row] t_name];
            cell.imageView.image = [UIImage imageNamed:[[high_done objectAtIndex:indexPath.row] t_img]];
            cell.detailTextLabel.text = @"high";
            break;
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *str = @" ";

    switch(section){
        case 0: //low
            str = @"low";
            break;
        case 1: //medium
            str = @"medium";
            break;
        case 2: //high
            str = @"high";
            break;
    }
    return str;
}

- (IBAction)state_done_action:(id)sender {
    [self.done_table reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete" message:@"Delete Task?" preferredStyle: UIAlertControllerStyleActionSheet];
    
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NSMutableArray *new_done = [NSMutableArray new];
        
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            
            switch(indexPath.section){
                case 0:
                    [low_done removeObjectAtIndex:indexPath.row];
                    break;
                case 1 :
                    [medium_done removeObjectAtIndex:indexPath.row];
                    break;
                case 2:
                    [high_done removeObjectAtIndex:indexPath.row];
                    break;
            }
            done = new_done;
            [done addObjectsFromArray:low_done];
            [done addObjectsFromArray:medium_done];
            [done addObjectsFromArray:high_done];
            NSDate *date22 = [NSKeyedArchiver archivedDataWithRootObject:done];
            [def setObject:date22 forKey:@"Done"];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [self.done_table reloadData];
            
            
        } else if (editingStyle == UITableViewCellEditingStyleInsert) {
            
        }
        
        [self.done_table reloadData];
    }];
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }]; //normal
    
    [alert addAction:yes];
    [alert addAction:no];
    
    [self presentViewController:alert animated:YES completion:^{
        printf("alert done \n");
    }];
    [self.done_table reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditDoneViewController *edit_done = [self.storyboard instantiateViewControllerWithIdentifier:@"EditDoneViewController"];
    edit_done.edit_done_task = [done objectAtIndex:indexPath.row];
    edit_done.index_done = indexPath.row;
    [self.navigationController pushViewController:edit_done animated:YES];
}


@end
