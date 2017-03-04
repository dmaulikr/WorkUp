//
//  Workout.h
//  WorkUp
//
//  Created by mac06 on 17/09/2014.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exercise;

@interface Workout : NSManagedObject

@property (nonatomic, retain) NSString * muscleGroups;
@property (nonatomic, retain) NSString * workoutName;
@property (nonatomic, retain) NSOrderedSet *exercises;
@end

@interface Workout (CoreDataGeneratedAccessors)

- (void)insertObject:(Exercise *)value inExercisesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromExercisesAtIndex:(NSUInteger)idx;
- (void)insertExercises:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeExercisesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInExercisesAtIndex:(NSUInteger)idx withObject:(Exercise *)value;
- (void)replaceExercisesAtIndexes:(NSIndexSet *)indexes withExercises:(NSArray *)values;
- (void)addExercisesObject:(Exercise *)value;
- (void)removeExercisesObject:(Exercise *)value;
- (void)addExercises:(NSOrderedSet *)values;
- (void)removeExercises:(NSOrderedSet *)values;

- (void)addSubExerciseObject:(Exercise *)value;
@end
