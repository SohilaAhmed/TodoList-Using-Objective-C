//
//  EditDoneViewController.m
//  workshop
//
//  Created by Sohila on 22/01/2023.
//

#import "EditDoneViewController.h"
#import "Task.h"
@interface EditDoneViewController ()

@end

@implementation EditDoneViewController
{
    
}

static NSMutableArray *done_tasks;
static NSUserDefaults *def;


+ (void)initialize{
    done_tasks = [NSMutableArray new];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _tf_name_done.text = _edit_done_task.t_name;
    _tf_des_done.text = _edit_done_task.t_des;
    _l_done.text = _edit_done_task.t_date;

    if([_edit_done_task.t_priority  isEqualToString: @"Low"]){
        self.pri_done.selectedSegmentIndex = 0;
    }else if([_edit_done_task.t_priority  isEqual: @"Medium"]){
        self.pri_done.selectedSegmentIndex = 1;
    }else if([_edit_done_task.t_priority  isEqual: @"High"]){
        self.pri_done.selectedSegmentIndex = 2;
    }
    
    def = [NSUserDefaults standardUserDefaults];
    
    NSDate *data3 = [def objectForKey:@"Done"];
    done_tasks = [NSKeyedUnarchiver unarchiveObjectWithData: data3];
    
}


- (IBAction)editDone:(id)sender {
    if((_tf_name_done.text.length > 0) && !([_tf_des_done.text isEqualToString:@""])){
        Task *d = [Task new];
        d.t_name = _tf_name_done.text;
        d.t_des = _tf_des_done.text;
        d.t_date = _l_done.text;
        
        if(self.pri_done.selectedSegmentIndex == 0){
            d.t_img = @"1";
            d.t_priority = @"Low";
        }else if(self.pri_done.selectedSegmentIndex == 1){
            d.t_img = @"2";
            d.t_priority = @"Medium";
        }else if(self.pri_done.selectedSegmentIndex == 2){
            d.t_img = @"3";
            d.t_priority = @"High";
        }
        
        [done_tasks replaceObjectAtIndex:_index_done withObject:d];
        NSDate *date = [NSKeyedArchiver archivedDataWithRootObject:done_tasks];
        [def setObject:date forKey:@"Done"];
        
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
