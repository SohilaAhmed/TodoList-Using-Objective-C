//
//  EditDoneViewController.h
//  workshop
//
//  Created by Sohila on 22/01/2023.
//

#import <UIKit/UIKit.h>
#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@interface EditDoneViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tf_name_done;
@property (weak, nonatomic) IBOutlet UITextView *tf_des_done;
@property (weak, nonatomic) IBOutlet UILabel *l_done;
@property (weak, nonatomic) IBOutlet UISegmentedControl *pri_done;


@property Task *edit_done_task;
@property int index_done;

@end

NS_ASSUME_NONNULL_END
