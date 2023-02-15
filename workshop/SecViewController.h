//
//  SecViewController.h
//  workshop
//
//  Created by Sohila on 17/01/2023.
//

#import <UIKit/UIKit.h>
#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@interface SecViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *in_pro_table;
@property (weak, nonatomic) IBOutlet UISegmentedControl *state_inProgress;

@end

NS_ASSUME_NONNULL_END
