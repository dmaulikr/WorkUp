//
//  SecondViewController.h
//  WorkUp
//
//  Created by mac06 on 08/09/2014.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface StopWatchViewController : UIViewController <UITableViewDelegate>

@property (strong, nonatomic) NSTimer *stopWatchTimer;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) IBOutlet UIButton *startStopTimerButton;
@property (strong, nonatomic) IBOutlet UIButton *resetLapTimerButton;
@property (strong, nonatomic) IBOutlet UITableView *lapTimeTableView;

@end
