//
//  NewWorkoutViewController.m
//  WorkUp
//
//  Created by mac06 on 12/09/2014.
//
//

#import "NewWorkoutViewController.h"

@interface NewWorkoutViewController ()

@end

@implementation NewWorkoutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gestures

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.workoutNameTextField resignFirstResponder];
    [self.muscleGroupsTextField resignFirstResponder];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    self.workoutNameTextField.text = nil;
    self.muscleGroupsTextField.text = nil;
    
    [[[segue destinationViewController] tableView] reloadData];
}

#pragma mark - Custom Methods

- (IBAction)SaveAndReturn:(id)sender {
    NSManagedObject *workoutObject = [NSEntityDescription
                              insertNewObjectForEntityForName:@"Workout"
                              inManagedObjectContext:_context];
    [workoutObject setValue:self.workoutNameTextField.text forKey:@"workoutName"];
    [workoutObject setValue:self.muscleGroupsTextField.text forKey:@"muscleGroups"];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate saveContext];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
