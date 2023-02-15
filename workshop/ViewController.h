//
//  ViewController.h
//  workshop
//
//  Created by Sohila on 17/01/2023.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *todo_table;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

