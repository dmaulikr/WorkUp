//
//  FirstViewController.m
//  WorkUp
//
//  Created by mac06 on 08/09/2014.
//
//

#import "FirstViewController.h"

@interface FirstViewController () {
    AppDelegate *appDelegate;
}
@end

@implementation FirstViewController

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
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    if (workoutArray == nil) {
        workoutArray = [NSMutableArray array];
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:_context];
        [request setEntity:entDesc];
        
        NSError *err = nil;
        workoutArray = [NSMutableArray arrayWithArray:[_context executeFetchRequest:request error:&err]];
    }
    
    [[self tableView] reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:_context];
    [request setEntity:entDesc];
    
    NSError *err = nil;
    workoutArray = [NSMutableArray arrayWithArray:[_context executeFetchRequest:request error:&err]];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (workoutArray.count > 0) {
        tableView.backgroundView = nil;
        return workoutArray.count;
    } else {
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"Hey!\nLooks like you don't have any workouts.\nTap the '+' to get started.";
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
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"workoutCell" forIndexPath:indexPath];
 
    // Configure the cell...
    UIImageView *imageView;
    imageView = (UIImageView *)[cell viewWithTag:0];
    imageView.image = [UIImage imageNamed:@"DumbbellImage"];
    
    UILabel *label;
    
    label = (UILabel *)[cell viewWithTag:1];
    label.text = [[workoutArray objectAtIndex:indexPath.row] valueForKey:@"workoutName"];
    
    label = (UILabel *)[cell viewWithTag:2];
    label.text = [[workoutArray objectAtIndex:indexPath.row] valueForKey:@"muscleGroups"];
    
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
        long index = indexPath.row;
        [_context deleteObject:[workoutArray objectAtIndex:index]];
        [workoutArray removeObjectAtIndex:index];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [appDelegate saveContext];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

// Use 'didHighlight' to set variables before prepare for segue is called.
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentWorkout = [[workoutArray objectAtIndex:indexPath.row] valueForKey:@"workoutName"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [[segue destinationViewController] setContext:_context];
    if ([[segue identifier] isEqualToString:@"toExercises"]) {
        [[segue destinationViewController] setCurrentWorkout:_currentWorkout];
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

@end
