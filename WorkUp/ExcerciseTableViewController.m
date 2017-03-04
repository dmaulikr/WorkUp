//
//  ExcerciseTableViewController.m
//  WorkUp
//
//  Created by mac06 on 15/09/2014.
//
//

#import "ExcerciseTableViewController.h"

@interface ExcerciseTableViewController () {
    AppDelegate *appDelegate;
    NSMutableArray *exerciseArray;
    NSMutableArray *weightTrainingExerciseArray;
    NSMutableArray *cardioTrainingExerciseArray;
}

@end

@implementation ExcerciseTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _context = [appDelegate managedObjectContext];
    
    [self setTitle:_currentWorkout];
    
    [[self tableView] reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:_context];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.workoutName == %@", _currentWorkout];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *array = [_context executeFetchRequest:request error:&error];
    if (array != nil) {
        _workoutObject = [array firstObject];
    }
    else {
        // Deal with error.
    }
    
    exerciseArray = [NSMutableArray array];

    if (_workoutObject.exercises.count > 0) {
        for (Exercise *exercise in [_workoutObject exercises]) {
            NSLog(@"Exercise: %@", exercise.exerciseName);
            [exerciseArray addObject:exercise];
        }
    }
    
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (exerciseArray.count == 0) {
        return 1;
    } else {
        return [exerciseArray count];
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (exerciseArray.count > 0) {
        return 1;
    } else {
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"Hey!\nThat's a pretty easy looking workout.\nTap the '+' to add some exercises.";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageLabel sizeToFit];
        
        self.tableView.backgroundView = messageLabel;
        
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if ([[[exerciseArray objectAtIndex:indexPath.section] exerciseType] isEqualToString:@"Weight"]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"weightCell" forIndexPath:indexPath];
        
        UILabel *label;
        
        label = (UILabel *)[cell viewWithTag:1];
        label.text = [[exerciseArray objectAtIndex:indexPath.section] exerciseName];
        
        label = (UILabel *)[cell viewWithTag:2];
        label.text = [NSString stringWithFormat:@"%.0f", [[exerciseArray objectAtIndex:indexPath.section] numSets].floatValue];
        
        label = (UILabel *)[cell viewWithTag:3];
        label.text = [NSString stringWithFormat:@"%.0f", [[exerciseArray objectAtIndex:indexPath.section] numReps].floatValue];

        label = (UILabel *)[cell viewWithTag:4];
        label.text = [NSString stringWithFormat:@"%.2f", [[exerciseArray objectAtIndex:indexPath.section] restPerSet].floatValue];
        
        label = (UILabel *)[cell viewWithTag:5];
        label.text = [NSString stringWithFormat:@"%.2f", [[exerciseArray objectAtIndex:indexPath.section] weight].floatValue];
        
        label = (UILabel *)[cell viewWithTag:6];
        label.text = [NSString stringWithFormat:@"%.2f", [[exerciseArray objectAtIndex:indexPath.section] incrementAmount].floatValue];
        
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cardioCell" forIndexPath:indexPath];
        
        UILabel *label;
        
        label = (UILabel *)[cell viewWithTag:1];
        label.text = [[exerciseArray objectAtIndex:indexPath.section] exerciseName];
        
        label = (UILabel *)[cell viewWithTag:2];
        label.text = [NSString stringWithFormat:@"%.2f", [[exerciseArray objectAtIndex:indexPath.section] exerciseDuration].floatValue];

        label = (UILabel *)[cell viewWithTag:3];
        label.text = [NSString stringWithFormat:@"%.2f", [[exerciseArray objectAtIndex:indexPath.section] averageSpeed].floatValue];
    }    
    
    return cell;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        long index = indexPath.section;
        [_context deleteObject:[exerciseArray objectAtIndex:index]];
        [exerciseArray removeObjectAtIndex:index];
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        [appDelegate saveContext];
        [tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[exerciseArray objectAtIndex:indexPath.section] exerciseType] isEqualToString:@"Weight"]) {
        return 175;
    } else {
        return 100;
    }
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (IBAction)displayExerciseDropDownMenu:(id)sender {
    UIActionSheet *exerciseActionSheet = [[UIActionSheet alloc] initWithTitle:@"Exercise Type" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Weight Training", @"Cardio Training", nil];
    [exerciseActionSheet showFromBarButtonItem:self.exerciseBarButton animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self performSegueWithIdentifier:@"segue1" sender:self];
    } else if (buttonIndex == 1) {
        [self performSegueWithIdentifier:@"segue2" sender:self];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [[segue destinationViewController] setContext:_context];
    [[segue destinationViewController] setWorkoutObject:_workoutObject];
}


@end
