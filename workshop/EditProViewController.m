//
//  EditProViewController.m
//  workshop
//
//  Created by Sohila on 19/01/2023.
//

#import "EditProViewController.h"

@interface EditProViewController ()

@end

@implementation EditProViewController
{
    
}

static NSMutableArray *inProgress_tasks;
static NSMutableArray *done_tasks;
static NSUserDefaults *def;

+ (void)initialize{
    inProgress_tasks = [NSMutableArray new];
    done_tasks = [NSMutableArray new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _tf_name_pro.text = _edit_pro_task.t_name;
    _tf_des_pro.text = _edit_pro_task.t_des;
    _l_date_pro.text = _edit_pro_task.t_date;
    
    if([_edit_pro_task.t_priority  isEqualToString: @"Low"]){
        self.pri_pro.selectedSegmentIndex = 0;
    }else if([_edit_pro_task.t_priority  isEqual: @"Medium"]){
        self.pri_pro.selectedSegmentIndex = 1;
    }else if([_edit_pro_task.t_priority  isEqual: @"High"]){
        self.pri_pro.selectedSegmentIndex = 2;
    }
    
    def = [NSUserDefaults standardUserDefaults];
    
    NSDate *data2 = [def objectForKey:@"InProgress"];
    inProgress_tasks = [NSKeyedUnarchiver unarchiveObjectWithData: data2];
        
    
    
}

- (IBAction)editPro:(id)sender {
    if((_tf_name_pro.text.length > 0) && !([_tf_des_pro.text isEqualToString:@""])){
        Task *p = [Task new];
        p.t_name = _tf_name_pro.text;
        p.t_des = _tf_des_pro.text;
        p.t_date = _l_date_pro.text;
        
        if(self.pri_pro.selectedSegmentIndex == 0){
            p.t_img = @"1";
            p.t_priority = @"Low";
        }else if(self.pri_pro.selectedSegmentIndex == 1){
            p.t_img = @"2";
            p.t_priority = @"Medium";
        }else if(self.pri_pro.selectedSegmentIndex == 2){
            p.t_img = @"3";
            p.t_priority = @"High";
        }
        
        if(self.state_pro.selectedSegmentIndex == 0){
            p.t_state = @"InProgress";
        }else if (self.state_pro.selectedSegmentIndex == 1){
            p.t_state = @"Done";
        }
        
        if([p.t_state isEqualToString:@"InProgress"]){
            [inProgress_tasks replaceObjectAtIndex:_index_pro withObject:p];
            NSDate *data = [NSKeyedArchiver archivedDataWithRootObject:inProgress_tasks];
            [def setObject:data forKey:@"InProgress"];
            
        }else if ([p.t_state isEqualToString:@"Done"]){
            [inProgress_tasks removeObjectAtIndex:_index_pro];
            NSDate *data = [NSKeyedArchiver archivedDataWithRootObject:inProgress_tasks];
            [def setObject:data forKey:@"InProgress"];
            
            if([def objectForKey:@"Done"] == nil){
                [done_tasks addObject:p];
                NSDate *data4 = [NSKeyedArchiver archivedDataWithRootObject:done_tasks];
                [def setObject:data4 forKey:@"Done"];
            }else if ([def objectForKey:@"Done"] != nil){
                NSDate *data3 = [def objectForKey:@"Done"];
                done_tasks = [NSKeyedUnarchiver unarchiveObjectWithData: data3];
                
                [done_tasks addObject:p];
                NSDate *data2 = [NSKeyedArchiver archivedDataWithRootObject:done_tasks];
                [def setObject:data2 forKey:@"Done"];
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
