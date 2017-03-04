//
//  NewWorkoutViewController.h
//  WorkUp
//
//  Created by mac06 on 12/09/2014.
//
//

#import <UIKit/UIKit.h>


@interface NewWorkoutViewController : UIViewController <UITextFieldDelegate> {
    
}
@property (nonatomic, retain)NSManagedObjectContext *context;


@property (strong, nonatomic) IBOutlet UITextField *workoutNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *muscleGroupsTextField;

- (IBAction)SaveAndReturn:(id)sender;

@end
