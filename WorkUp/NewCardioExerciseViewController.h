//
//  NewCardioExerciseViewController.h
//  WorkUp
//
//  Created by mac06 on 15/09/2014.
//
//

#import <UIKit/UIKit.h>
#import "Workout.h"
#import "Exercise.h"

@interface NewCardioExerciseViewController : UIViewController


@property (nonatomic, retain)NSManagedObjectContext *context;
@property (nonatomic, retain)Workout *workoutObject;

@property (strong, nonatomic) IBOutlet UITextField *exerciseNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *durationTextField;
@property (strong, nonatomic) IBOutlet UITextField *averageSpeedTextField;
@end