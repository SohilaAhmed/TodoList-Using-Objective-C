//
//  EditProViewController.h
//  workshop
//
//  Created by Sohila on 19/01/2023.
//

#import <UIKit/UIKit.h>
#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@interface EditProViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tf_name_pro;
@property (weak, nonatomic) IBOutlet UITextView *tf_des_pro;
@property (weak, nonatomic) IBOutlet UISegmentedControl *pri_pro;
@property (weak, nonatomic) IBOutlet UILabel *l_date_pro;
@property (weak, nonatomic) IBOutlet UISegmentedControl *state_pro;


@property Task *edit_pro_task;
@property int index_pro;

@end

NS_ASSUME_NONNULL_END
