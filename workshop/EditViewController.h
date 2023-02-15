//
//  EditViewController.h
//  workshop
//
//  Created by Sohila on 17/01/2023.
//

#import <UIKit/UIKit.h>
#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@interface EditViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *tf_name_edit;
@property (weak, nonatomic) IBOutlet UITextView *tf_dis_edit;
@property (weak, nonatomic) IBOutlet UILabel *l_date_edit;
@property (weak, nonatomic) IBOutlet UISegmentedControl *pri_edit;
@property (weak, nonatomic) IBOutlet UISegmentedControl *state_edit;
@property Task *edit_task;
@property int index;

@end

NS_ASSUME_NONNULL_END
