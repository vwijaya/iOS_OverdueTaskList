//
//  VWViewController.m
//  Overdue Task List
//
//  Created by Valerino on 7/2/14.
//  Copyright (c) 2014 VW. All rights reserved.
//

#import "VWViewController.h"

@interface VWViewController ()

@end

@implementation VWViewController

// Lazy instatiation
-(NSMutableArray *)taskObjects
{
    if (!_taskObjects)
        _taskObjects = [[NSMutableArray alloc] init];
    
    return _taskObjects;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    NSArray *tasksAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY];
    
    for(NSDictionary *dictionary in tasksAsPropertyLists)
    {
        VWTask *taskObject = [self taskObjectForDictionary:dictionary];
        [self.taskObjects addObject:taskObject];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[VWAddTaskViewController class]])
    {
        VWAddTaskViewController *addTaskViewController = segue.destinationViewController;
        
        addTaskViewController.delegate = self;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender {
    
}

- (IBAction)addTaskBarButtonItemPressed:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"toAddTaskViewControllerSegue" sender:nil];
}

#pragma mark - VWAddTaskViewControllerDelegate
-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didAddTask:(VWTask *)task
{
    [self.taskObjects addObject:task];
    
    NSLog(@"%@", task.title);
    
    NSMutableArray *taskObjectsAsPropertyLists =
    [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY] mutableCopy];
    
    if(!taskObjectsAsPropertyLists)
        taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    [taskObjectsAsPropertyLists addObject: [self taskObjectAsAPropertyList:task]];
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData];
    
}

#pragma mark - helper methods
-(NSDictionary *)taskObjectAsAPropertyList:(VWTask *)taskObject
{
    NSDictionary *dictionary = @{TASK_TITLE : taskObject.title,
                                 TASK_DESCRIPTION : taskObject.description,
                                 TASK_DATE : taskObject.date,
                                 TASK_COMPLETION : @(taskObject.isCompleted)
                                 };
    return dictionary;
                                 
}

-(VWTask *)taskObjectForDictionary:(NSDictionary *)dictionary
{
    VWTask *taskObject = [[VWTask alloc] initWithData:dictionary];
    return taskObject;
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.taskObjects count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure cell...
    VWTask *task = self.taskObjects[indexPath.row];
    cell.textLabel.text = task.title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:task.date];
    cell.detailTextLabel.text = stringFromDate;
    
    return cell;
    
}

@end
