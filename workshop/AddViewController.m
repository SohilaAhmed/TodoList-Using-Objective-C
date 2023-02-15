//
//  AddViewController.m
//  workshop
//
//  Created by Sohila on 17/01/2023.
//

#import "AddViewController.h"

@interface AddViewController ()

@end
@implementation AddViewController
{
//    Task *emp_task;
}
static NSMutableArray *todo;

+ (void)initialize{
    todo = [NSMutableArray new];
//    emp_task = [Task new];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _def = [NSUserDefaults standardUserDefaults];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _l_add_date.text =[dateFormatter stringFromDate:[NSDate date]];
}

- (IBAction)addBut:(id)sender {
    
    if((_tf_dd_name.text.length > 0) && !([_tf_add_des.text isEqualToString:@""])){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add" message:@"Add New Task?" preferredStyle: UIAlertControllerStyleActionSheet];
        
        UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            NSData *data2 = [_def objectForKey:@"Task"];
            todo=[NSKeyedUnarchiver unarchiveObjectWithData:data2];
            
            Task *task2 = [Task new];
            task2.t_name = _tf_dd_name.text;
            task2.t_des = _tf_add_des.text;
            task2.t_date = _l_add_date.text;
            
            if(self.pri_add.selectedSegmentIndex == 0){
                task2.t_img = @"1";
                task2.t_priority = @"Low";
            }else if (self.pri_add.selectedSegmentIndex == 1){
                task2.t_img = @"2";
                task2.t_priority = @"Medium";
            }else if(self.pri_add.selectedSegmentIndex == 2){
                task2.t_img = @"3";
                task2.t_priority = @"High";
            }
            
            
            [todo addObject:task2];
            
            NSDate *date = [NSKeyedArchiver archivedDataWithRootObject:todo];
            [_def setObject:date forKey:@"Task"];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }]; //color red
        
        UIAlertAction *no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self dismissViewControllerAnimated:YES completion:nil];
        }]; //normal
        
        [alert addAction:yes];
        [alert addAction:no];
        
        //show alert
        [self presentViewController:alert animated:YES completion:^{
            printf("alert done \n");
        }];
    }
    //present alert if the test empty
    else{
        UIAlertController *empty_alert = [UIAlertController alertControllerWithTitle:@"Empty Task" message:@"Please Add the Title And Description" preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [empty_alert addAction: ok];
        [self presentViewController:empty_alert animated:YES completion:nil];
    }
    
    // ViewController *f = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
}




@end
