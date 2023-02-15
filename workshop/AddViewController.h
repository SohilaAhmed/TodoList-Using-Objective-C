//
//  AddViewController.h
//  workshop
//
//  Created by Sohila on 17/01/2023.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "ViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddViewController : UIViewController
{
//    NSUserDefaults *def;
}
@property (weak, nonatomic) IBOutlet UITextField *tf_dd_name;
@property (weak, nonatomic) IBOutlet UITextView *tf_add_des;
@property (weak, nonatomic) IBOutlet UILabel *l_add_date;
@property (weak, nonatomic) IBOutlet UISegmentedControl *pri_add;

@property Task *task2;
@property NSUserDefaults *def;
@end

NS_ASSUME_NONNULL_END
