//
//  NewCardioExerciseViewController.m
//  WorkUp
//
//  Created by mac06 on 15/09/2014.
//
//

#import "NewCardioExerciseViewController.h"

@interface NewCardioExerciseViewController ()

@end

@implementation NewCardioExerciseViewController

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
    [self.exerciseNameTextField resignFirstResponder];
    [self.durationTextField resignFirstResponder];
    [self.averageSpeedTextField resignFirstResponder];

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    self.exerciseNameTextField.text = nil;
    self.durationTextField.text = nil;
    self.averageSpeedTextField.text = nil;
    
    [[[segue destinationViewController] tableView] reloadData];
}

#pragma mark - Custom Methods

- (IBAction)SaveAndReturn:(id)sender {
    Exercise *exerciseObject = [[Exercise alloc] initWithEntity:[NSEntityDescription entityForName:@"Exercise" inManagedObjectContext:_context] insertIntoManagedObjectContext:_context];
    [exerciseObject setValue:self.exerciseNameTextField.text forKey:@"exerciseName"];
    [exerciseObject setValue:@"Cardio" forKey:@"exerciseType"];
    [exerciseObject setValue:[NSNumber numberWithInt:self.durationTextField.text.intValue] forKey:@"exerciseDuration"];
    [exerciseObject setValue:[NSNumber numberWithInt:self.averageSpeedTextField.text.intValue] forKey:@"averageSpeed"];
    
    [_workoutObject addSubExerciseObject:exerciseObject];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate saveContext];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
