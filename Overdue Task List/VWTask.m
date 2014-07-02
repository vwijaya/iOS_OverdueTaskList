//
//  VWTask.m
//  Overdue Task List
//
//  Created by Valerino on 7/2/14.
//  Copyright (c) 2014 VW. All rights reserved.
//

#import "VWTask.h"

@implementation VWTask

-(id)initWithData:(NSDictionary *)data
{
    self = [super init];
    
    if(self) {
        self.title = data[TASK_TITLE];
        self.description = data[TASK_DESCRIPTION];
        self.date = data[TASK_DATE];
        self.isCompleted = [data[TASK_COMPLETION] boolValue];
    }
    
    return self;
}

-(id)init
{
    self = [self initWithData:nil];
    
    return self;
}

@end
