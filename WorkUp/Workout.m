//
//  Workout.m
//  WorkUp
//
//  Created by mac06 on 17/09/2014.
//
//

#import "Workout.h"
#import "Exercise.h"


@implementation Workout

@dynamic muscleGroups;
@dynamic workoutName;
@dynamic exercises;

- (void)addSubExerciseObject:(Exercise *)value {
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.exercises];
    [tempSet addObject:value];
    self.exercises = tempSet;
}

@end
