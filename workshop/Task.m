//
//  Task.m
//  workshop
//
//  Created by Sohila on 17/01/2023.
//

#import "Task.h"

@implementation Task

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:_t_name forKey:@"name"];
    [coder encodeObject:_t_des forKey:@"des"];
    [coder encodeObject:_t_date forKey:@"date"];
    [coder encodeObject:_t_priority forKey:@"priority"];
    [coder encodeObject:_t_img forKey:@"img"];
    [coder encodeObject:_t_state forKey:@"state"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self.t_name = [coder decodeObjectForKey:@"name"];
    self.t_des = [coder decodeObjectForKey:@"des"];
    self.t_date = [coder decodeObjectForKey:@"date"];
    self.t_priority = [coder decodeObjectForKey:@"priority"];
    self.t_img = [coder decodeObjectForKey:@"img"];
    self.t_state = [coder decodeObjectForKey:@"state"];
    
    return self;
}

@end
