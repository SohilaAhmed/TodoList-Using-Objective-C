//
//  ThirdViewController.h
//  workshop
//
//  Created by Sohila on 17/01/2023.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThirdViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *done_table;
@property (weak, nonatomic) IBOutlet UISegmentedControl *state_done;

//@property NSUserDefaults *def;
@property int index_done;

@end

NS_ASSUME_NONNULL_END
