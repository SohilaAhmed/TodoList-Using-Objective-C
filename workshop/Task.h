//
//  Task.h
//  workshop
//
//  Created by Sohila on 17/01/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject <NSCoding>

@property NSString *t_name;
@property NSString *t_des;
@property NSString *t_date;
@property NSString *t_priority;
@property NSString *t_state;
@property NSString *t_img;


@end

NS_ASSUME_NONNULL_END
