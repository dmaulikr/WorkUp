//
//  Exercise.h
//  WorkUp
//
//  Created by mac06 on 18/09/2014.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Workout;

@interface Exercise : NSManagedObject

@property (nonatomic, retain) NSNumber * averageSpeed;
@property (nonatomic, retain) NSNumber * exerciseDuration;
@property (nonatomic, retain) NSString * exerciseName;
@property (nonatomic, retain) NSString * exerciseType;
@property (nonatomic, retain) NSNumber * incrementAmount;
@property (nonatomic, retain) NSNumber * numReps;
@property (nonatomic, retain) NSNumber * numSets;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSNumber * restPerSet;
@property (nonatomic, retain) Workout *workouts;

@end
