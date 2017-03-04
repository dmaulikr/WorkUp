//
//  FirstViewController.h
//  WorkUp
//
//  Created by mac06 on 08/09/2014.
//
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UITableViewController {
    NSMutableArray *workoutArray;
}

@property (nonatomic, retain)NSManagedObjectContext *context;
@property (nonatomic, retain)NSString *currentWorkout;

@end
