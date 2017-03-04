//
//  ExcerciseTableViewController.h
//  WorkUp
//
//  Created by mac06 on 15/09/2014.
//
//

#import <UIKit/UIKit.h>
#import "Workout.h"
#import "Exercise.h"

@interface ExcerciseTableViewController : UITableViewController <UIActionSheetDelegate>


@property (strong, nonatomic) IBOutlet UIBarButtonItem *exerciseBarButton;
@property (nonatomic, retain)NSManagedObjectContext *context;
@property (nonatomic, retain)NSString *currentWorkout;
@property (nonatomic, retain)Workout *workoutObject;

@end
