//
//  VWEditTaskViewController.h
//  Overdue Task List
//
//  Created by Valerino on 7/2/14.
//  Copyright (c) 2014 VW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWTask.h"

@protocol VWEditTaskViewControllerDelegate <NSObject>

-(void)didUpdateTask;

@end

@interface VWEditTaskViewController : UIViewController

@property (weak, nonatomic) id <VWEditTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) VWTask *task;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
