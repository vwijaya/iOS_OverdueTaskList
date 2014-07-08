//
//  VWDetailTaskViewController.h
//  Overdue Task List
//
//  Created by Valerino on 7/2/14.
//  Copyright (c) 2014 VW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWTask.h"
#import "VWEditTaskViewController.h"

@protocol VWDetailTaskViewControllerDelegate <NSObject>

-(void)updateTask;

@end

@interface VWDetailTaskViewController : UIViewController <VWEditTaskViewControllerDelegate>

@property (weak, nonatomic) id <VWDetailTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) VWTask *task;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;

- (IBAction)editBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
