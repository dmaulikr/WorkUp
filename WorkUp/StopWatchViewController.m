//
//  StopWatchViewController.m
//  WorkUp
//
//  Created by mac06 on 08/09/2014.
//
//

#import "StopWatchViewController.h"

#define DEG2RAD(angle) angle*M_PI/180.0

@interface StopWatchViewController () {
    NSDateFormatter *dateFormatter;
    NSMutableArray *lapTimeArray;
    NSTimeInterval pauseTimeInterval;

    bool isPaused;
    int lap;
}

@end

@implementation StopWatchViewController

- (CAShapeLayer *)createCurvedLine {
    CAShapeLayer *cLine = [CAShapeLayer layer];
    cLine.lineWidth = 5.0;
    cLine.strokeColor = [UIColor blackColor].CGColor;
    cLine.fillColor = [UIColor clearColor].CGColor;
    cLine.lineCap = kCALineCapRound;
    
    CGFloat angle = DEG2RAD(-120);
    CGPoint center = CGPointMake(self.view.frame.size.width / 2, 120);
    CGFloat radius = 100.0;
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath addArcWithCenter:center radius:radius startAngle:angle endAngle:DEG2RAD(180.0) clockwise:YES];
    
//    cLine.frame = CGPathGetBoundingBox(cLine.path);

    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.duration = 1.0;
    
    // flip the path
    anim.fromValue = linePath;
    anim.toValue = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:DEG2RAD(180) endAngle:angle clockwise:YES];
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFilterLinear;
    
    [cLine addAnimation:anim forKey:nil];
    
    cLine.path = linePath.CGPath;
    
    return cLine;
}

- (CAGradientLayer *)createGradientWithMask:(CAShapeLayer *)layer {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.startPoint = CGPointMake(0.5, 0.0);
    
    gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    
    gradientLayer.colors = @[(id)[UIColor blackColor].CGColor, (id)[UIColor clearColor].CGColor];
    
    gradientLayer.frame = CGRectMake(0, 0, layer.frame.size.width, layer.frame.size.height);
    
    gradientLayer.mask = layer;
    
    return gradientLayer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    lapTimeArray = [NSMutableArray array];
    isPaused = TRUE;

    CAShapeLayer *curvedLineMask = [self createCurvedLine];
    
    [self.view.layer addSublayer:curvedLineMask];

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
    return lapTimeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"lapTimeCell"];
    
    cell.textLabel.text = [lapTimeArray[indexPath.row] valueForKey:@"LapTime"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%i", [[lapTimeArray[indexPath.row] valueForKey:@"LapCount"] intValue]];

    return cell;
}


- (void)updateTimer {
    if (!isPaused) {
        // Create date from the elapsed time
        NSDate *currentDate = [NSDate date];
        NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.startDate];
        NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        
        // Create a date formatter
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"mm:ss.SS";
        dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0.0];
        

        
        // Format the elapsed time and set it to the label
        NSString *timeString = [dateFormatter stringFromDate:timerDate];
        self.timerLabel.text = timeString;
        
        pauseTimeInterval = timeInterval;
    }
}

- (IBAction)startStopTimer:(id)sender {
    if (isPaused) {
        [self.startStopTimerButton setTitle:@"Stop" forState:UIControlStateNormal];
        [self.resetLapTimerButton setTitle:@"Lap" forState:UIControlStateNormal];

        self.startDate = [NSDate date] ;
        self.startDate = [self.startDate dateByAddingTimeInterval:((-1)*(pauseTimeInterval))];

        
        // Create the stop watch timer that fires every 100 ms
        self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/100.0
                                                               target:self
                                                             selector:@selector(updateTimer)
                                                             userInfo:nil
                                                              repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.stopWatchTimer forMode:NSRunLoopCommonModes];

        isPaused = FALSE;
    } else {
        [self.startStopTimerButton setTitle:@"Start" forState:UIControlStateNormal];
        [self.resetLapTimerButton setTitle:@"Reset" forState:UIControlStateNormal];
        isPaused = TRUE;
        
        [self.stopWatchTimer invalidate];
        self.stopWatchTimer = nil;
        [self updateTimer];
    }
}

- (IBAction)resetTimer:(id)sender {
    if ([self.resetLapTimerButton.titleLabel.text isEqualToString:@"Reset"]) {
        self.timerLabel.text = @"00:00.00";
        lap = 0;
        [lapTimeArray removeAllObjects];
        [self.lapTimeTableView reloadData];
    } else {
        lap++;
        NSMutableDictionary *timeDict = [[NSMutableDictionary alloc] init];
        [timeDict setValue:self.timerLabel.text forKey:@"LapTime"];
        [timeDict setValue:@(lap) forKey:@"LapCount"];
        [lapTimeArray addObject:timeDict];
        [self.lapTimeTableView reloadData];
    }

}

@end
