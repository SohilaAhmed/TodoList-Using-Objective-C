//
//  EditViewController.m
//  workshop
//
//  Created by Sohila on 17/01/2023.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController
{
    
}

static NSMutableArray *todo_tasks;
static NSMutableArray *inProgress_tasks;
static NSMutableArray *done_tasks;
static NSUserDefaults *def;


+ (void)initialize{
    todo_tasks = [NSMutableArray new];
    inProgress_tasks = [NSMutableArray new];
    done_tasks = [NSMutableArray new];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //put the data in a text feild when you open edit
    _tf_name_edit.text = _edit_task.t_name;
    _tf_dis_edit.text = _edit_task.t_des;
    _l_date_edit.text = _edit_task.t_date;
     
    if([_edit_task.t_priority  isEqualToString: @"Low"]){
        self.pri_edit.selectedSegmentIndex = 0;
    }else if([_edit_task.t_priority  isEqual: @"Medium"]){
        self.pri_edit.selectedSegmentIndex = 1;
    }else if([_edit_task.t_priority  isEqual: @"High"]){
        self.pri_edit.selectedSegmentIndex = 2;
    }
    
    def = [NSUserDefaults standardUserDefaults];
    
    NSDate *data2 = [def objectForKey:@"Task"];
    todo_tasks = [NSKeyedUnarchiver unarchiveObjectWithData: data2];
    
}
- (IBAction)editBut:(id)sender {
    if((_tf_name_edit.text.length > 0) && !([_tf_dis_edit.text isEqualToString:@""])){
        //creat new obj and put updates in it
        Task *t = [Task new];
        t.t_name = _tf_name_edit.text;
        t.t_des = _tf_dis_edit.text;
        t.t_date =_l_date_edit.text;
        
        if(self.pri_edit.selectedSegmentIndex == 0){
            t.t_img = @"1";
            t.t_priority = @"Low";
        }else if (self.pri_edit.selectedSegmentIndex == 1){
            t.t_img = @"2";
            t.t_priority = @"Medium";
        }else if(self.pri_edit.selectedSegmentIndex == 2){
            t.t_img = @"3";
            t.t_priority = @"High";
        }
        
        if(self.state_edit.selectedSegmentIndex == 0){
            t.t_state = @"Todo";
        }else if (self.state_edit.selectedSegmentIndex == 1){
            t.t_state = @"InProgress";
        }else if(self.state_edit.selectedSegmentIndex == 2){
            t.t_state = @"Done";
        }
        
        //if you want to edit the task in todo
        if([t.t_state isEqualToString:@"Todo"]){
            //get old array from def in did load
            //update
            [todo_tasks replaceObjectAtIndex:_index withObject:t];
            //add in def
            NSDate *date = [NSKeyedArchiver archivedDataWithRootObject:todo_tasks];
            [def setObject:date forKey:@"Task"];
            
        }
        //if you want to move obj to inprogress
        else if([t.t_state isEqualToString:@"InProgress"]){
            //remove obj fron todo
            [todo_tasks removeObjectAtIndex:_index];
            //archive updates
            NSDate *date1 = [NSKeyedArchiver archivedDataWithRootObject:todo_tasks];
            [def setObject:date1 forKey:@"Task"];
            
            NSUserDefaults *defa2 = [NSUserDefaults standardUserDefaults];
            
            //cheak if inprogress or not
            if([def objectForKey:@"InProgress"] == nil){
                //if inprogress empty archive
                [inProgress_tasks addObject:t];
                NSDate *date = [NSKeyedArchiver archivedDataWithRootObject:inProgress_tasks];
                [defa2 setObject:date forKey:@"InProgress"];
            }
            else if ([def objectForKey:@"InProgress"] != nil){
                //if it not empty unarchive it first to get to get old objests
                NSData *data4 = [defa2 objectForKey:@"InProgress"];
                inProgress_tasks = [NSKeyedUnarchiver unarchiveObjectWithData:data4];
                
                //add new obj then archive updates
                [inProgress_tasks addObject:t];
                NSDate *date = [NSKeyedArchiver archivedDataWithRootObject:inProgress_tasks];
                [defa2 setObject:date forKey:@"InProgress"];
            }
            
        }
        //if you want to move obj to done
        else if([t.t_state isEqualToString:@"Done"]){
            //remove obj from todo and archive updates
            [todo_tasks removeObjectAtIndex:_index];
            NSDate *date1 = [NSKeyedArchiver archivedDataWithRootObject:todo_tasks];
            [def setObject:date1 forKey:@"Task"];
            NSUserDefaults *defa = [NSUserDefaults standardUserDefaults];
            
            //cheak if done empty or not
            if([def objectForKey:@"Done"] == nil){
                //if it emoty add obj to array the archive it in done
                [done_tasks addObject:t];
                NSDate *data3 = [NSKeyedArchiver archivedDataWithRootObject:done_tasks];
                [defa setObject:data3 forKey:@"Done"];
            }else if([def objectForKey:@"Done"] != nil){
                //if it not empty unarchive to get old objects
                NSData *data4 = [defa objectForKey:@"Done"];
                done_tasks = [NSKeyedUnarchiver unarchiveObjectWithData:data4];
                
                //add obj the archive the updates
                [done_tasks addObject:t];
                NSDate *data_done = [NSKeyedArchiver archivedDataWithRootObject:done_tasks];
                [defa setObject:data_done forKey:@"Done"];
            }
            
            
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    //present alert if the test empty
    else{
        UIAlertController *empty_alert = [UIAlertController alertControllerWithTitle:@"Empty Task" message:@"Please Add the Title And Description" preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [empty_alert addAction: ok];
        [self presentViewController:empty_alert animated:YES completion:nil];
    }
}



@end
