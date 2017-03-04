//
//  NewWeightTrainingExerciseViewController.h
//  WorkUp
//
//  Created by mac06 on 15/09/2014.
//
//

#import <UIKit/UIKit.h>
#import "Workout.h"
#import "Exercise.h"

@interface NewWeightTrainingExerciseViewController : UIViewController {
}

@property (nonatomic, retain)NSManagedObjectContext *context;
@property (nonatomic, retain)Workout *workoutObject;

@property (strong, nonatomic) IBOutlet UITextField *exerciseNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *numRepsTextField;
@property (strong, nonatomic) IBOutlet UITextField *numSetsTextField;
@property (strong, nonatomic) IBOutlet UITextField *weightLiftedTextField;
@property (strong, nonatomic) IBOutlet UITextField *weightIncrementTextField;
@property (strong, nonatomic) IBOutlet UITextField *setRestTextField;

@end
