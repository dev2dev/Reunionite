//
//  CalculationController.m
//  CashMeetings
//
//  Created by Romain Champourlier on 03/08/10.
//  Copyright 2010 SoftRoch. All rights reserved.
//

/**
 self.timer can be used to determine if counting is ongoing or stopped.
	- self.timer = nil, means the counting is stopped.
	- self.timer != nil, means the counting is ongoing.
 */

#import "CalculationController.h"

#import "CashMeetingsAppDelegate.h"
#import "EditTimeUIController.h"

#import "SHKItem.h"
#import "SHKActionSheet.h"


static NSString *AlertTitleClearTimer					= @"AlertTitleClearTimer";
static NSString *AlertTitleClearCumulatedValues			= @"AlertTitleClearCumulatedValues";
static NSString *LocalAlertClearTimerMessage			= @"LocalAlertClearTimerMessage";
static NSString *LocalAlertClearCumulationMessage		= @"LocalAlertClearCumulationMessage";
static NSString *LocalAlertButtonContinue				= @"LocalAlertButtonContinue";
static NSString *LocalAlertButtonCancel					= @"LocalAlertButtonCancel";

static NSString *LocalButtonStopCountingStopTitle		= @"LocalButtonStopCountingStopTitle";
static NSString *LocalButtonStopCountingRestartTitle	= @"LocalButtonStopCountingRestartTitle";
static NSString *LocalButtonStopCountingStartTitle		= @"LocalButtonStopCountingStartTitle";
static NSString *LocalLabelCountingOngoingText			= @"LocalLabelCountingText";
static NSString *LocalLabelCountingPausedText			= @"LocalLabelCountingPausedText";
static NSString *LocalLabelCountingNotStartedText		= @"LocalLabelCountingNotStartedText";

static NSString *LocalHourLabelLong						= @"LocalHourLabelLong";
static NSString *LocalMinuteLabelLong					= @"LocalMinuteLabelLong";
static NSString *LocalSecondLabelLong					= @"LocalSecondLabelLong";
static NSString *LocalHourLabelShort					= @"LocalHourLabelShort";
static NSString *LocalMinuteLabelShort					= @"LocalMinuteLabelShort";

static NSString *ShareMailTextKey						= @"ShareMailText";
static NSString *ShareTwitterTextKey					= @"ShareTwitterText";
static NSString *ShareTwitterTextOngoingKey				= @"ShareTwitterTextOngoing";
static NSString *ShareTwitterTextEndedKey				= @"ShareTwitterTextEnded";

static NSInteger AlertClearTimerTag			= 0;
static NSInteger AlertClearCumulationTag	= 1;

@interface CalculationController (PrivateMethods)
- (void)startCounting;
- (void)pauseCounting;
- (void)stopCounting;
- (void)tick;
- (float)calculateCostWithAccountableTimeInterval:(NSTimeInterval)ti;
- (NSUInteger)calculateCumulatedCostWithCost:(float)cost;
- (NSUInteger)calculateCumulatedDurationWithAccountableTimeInterval:(NSTimeInterval)ti;
- (NSTimeInterval)accountableTimeInterval;
- (NSString *)stringForTimeIntervalToSeconds:(NSTimeInterval)ti;
- (NSString *)stringForTimeIntervalToMinutes:(NSTimeInterval)ti;
@end

@interface CalculationController (UIPickerViewDelegateProtocol)
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component;
@end

@interface CalculationController (UIPickerViewDatasourceProtocol)
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
@end


@implementation CalculationController

@synthesize generalController;

- (id)init {
	//NSLog(@"init");
	self = [super init];
	if (self) {
		timer = nil;
		editTimeInterval = 0.0;
	}
	return self;
}

- (void)awakeFromNib {
	[self retain];
}

- (void)dealloc {
	[self invalidateTimer];
	[self release];
    [super dealloc];
}

- (IBAction)startStop:(id)sender {
	if (generalController.countStartDate && !generalController.countPauseDate) {
		// Counting (started, not paused)
		[self pauseCounting];
	}
	else {
		[self startCounting];
	}
}

- (void)startCounting {
	//NSLog(@"startCounting");
	[self scheduleTimer];
	if (generalController.countStartDate == nil) {
		// Just starting
		generalController.countStartDate = [NSDate date];
	}
	else if (generalController.countPauseDate) {
		// Already started, and paused too. Adding pause time to start date.
		generalController.countStartDate = [NSDate dateWithTimeInterval:-[generalController.countPauseDate timeIntervalSinceNow] sinceDate:generalController.countStartDate];
		generalController.countPauseDate = nil;
	}
	[stopCountingButton setTitle:NSLocalizedString(LocalButtonStopCountingStopTitle, nil) forState:UIControlStateNormal];
	[countingLabel setText:NSLocalizedString(LocalLabelCountingOngoingText, nil)];
}

- (void)pauseCounting {
	//NSLog(@"pauseCounting");
	[self invalidateTimer];

	if (!generalController.countPauseDate) {
		generalController.countPauseDate = [NSDate date];
	}

	[stopCountingButton setTitle:NSLocalizedString(LocalButtonStopCountingRestartTitle, nil) forState:UIControlStateNormal];
	[countingLabel setText:NSLocalizedString(LocalLabelCountingPausedText, nil)];

	[self tick];
}

- (void)stopCounting {
	[self invalidateTimer];
	
	NSTimeInterval ti = [self accountableTimeInterval];

	float cost = ti * (generalController.directorsNumber * generalController.directorCost
					   + generalController.managersNumber * generalController.managerCost
					   + generalController.teamNumber * generalController.teamCost) / 8 / 60 / 60;
	generalController.cumulatedCost += (NSUInteger)cost;
	
	generalController.cumulatedDuration += ti;
	
	generalController.countStartDate = nil;
	generalController.countPauseDate = nil;
	
	[stopCountingButton setTitle:NSLocalizedString(LocalButtonStopCountingStartTitle, nil) forState:UIControlStateNormal];
	[countingLabel setText:NSLocalizedString(LocalLabelCountingNotStartedText, nil)];

	[self tick];
}

- (IBAction)clearCounting:(id)sender {
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(AlertTitleClearTimer, nil) message:NSLocalizedString(LocalAlertClearTimerMessage, nil) delegate:self cancelButtonTitle:NSLocalizedString(LocalAlertButtonCancel, nil) otherButtonTitles:NSLocalizedString(LocalAlertButtonContinue, nil), nil];
	alertView.tag = AlertClearTimerTag;
	[alertView show];
}

- (IBAction)clearCumulatedValues:(id)sender {
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(AlertTitleClearCumulatedValues, nil) message:NSLocalizedString(LocalAlertClearCumulationMessage, nil) delegate:self cancelButtonTitle:NSLocalizedString(LocalAlertButtonCancel, nil) otherButtonTitles:NSLocalizedString(LocalAlertButtonContinue, nil), nil];
	alertView.tag = AlertClearCumulationTag;
	[alertView show];
}

- (IBAction)share:(id)sender {
	NSString *text;
	if (timer == nil) {
		text = [NSString stringWithFormat:NSLocalizedString(ShareTwitterTextEndedKey, nil), [self calculateCostWithAccountableTimeInterval:[self accountableTimeInterval]]];
	}
	else {
		NSString *timeString;
		if ([self accountableTimeInterval] < 60 * 90) {
			// less than 90 minutes
			timeString = [NSString stringWithFormat:@"%.0f min.", [self accountableTimeInterval] / 60];
		}
		else {
			timeString = [NSString stringWithFormat:@"%.1f heures", [self accountableTimeInterval] / 3600];
		}
		text = [NSString stringWithFormat:NSLocalizedString(ShareTwitterTextOngoingKey, nil), timeString, [self calculateCostWithAccountableTimeInterval:[self accountableTimeInterval]]];
	}
	
	SHKItem *item = [SHKItem text:text];
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
	
	[actionSheet showFromTabBar:((CashMeetingsAppDelegate *)[[UIApplication sharedApplication] delegate]).tabBarController.tabBar];
}

/*
 Enable to change the start time by changing the current counted time.
 */
- (IBAction)editStartTime:(id)sender {
	
	if (sender == editStartTimeButton) {
		// Entering edit mode
		[editTimeUIController startEdit];
		//beforeEditStartDate = generalController.countStartDate;
	}
	else if (sender == cancelEditTimeButton || sender == validateEditTimeButton) {
		if (sender == cancelEditTimeButton) {
			generalController.countStartDate = [generalController.countStartDate dateByAddingTimeInterval:-editTimeInterval];
			[self tick];
		}
		[editTimeUIController cancelEdit];
		//beforeEditStartDate = nil;
		editTimeInterval = 0.0;
	}
	else if (sender == add1HourButton || sender == add15MinutesButton) {
		if (timer == nil && generalController.countStartDate == nil) {
			[self startCounting];
		}
		
		NSTimeInterval timeInterval;
		if (sender == add1HourButton) {
			timeInterval = -60 * 60;
		}
		else {
			timeInterval = -60 * 15;
		}
		generalController.countStartDate = [generalController.countStartDate dateByAddingTimeInterval:timeInterval];
		editTimeInterval += timeInterval;
		[self tick];
	}
}


- (void)tick {
	NSTimeInterval ti = [self accountableTimeInterval];
	float cost = [self calculateCostWithAccountableTimeInterval:ti];
	NSUInteger	cumulatedCost = [self calculateCumulatedCostWithCost:cost];
	NSTimeInterval cumulatedDuration = [self calculateCumulatedDurationWithAccountableTimeInterval:ti];
	
	costLabel.text = [NSString stringWithFormat:@"%.2f €", cost >= 0 ? cost : -cost];
	cumulatedCostLabel.text = [NSString stringWithFormat:@"%u €", cumulatedCost];
	durationLabel.text = [self stringForTimeIntervalToSeconds:ti];
	cumulatedDurationLabel.text = [self stringForTimeIntervalToMinutes:cumulatedDuration];
}

- (float)calculateCostWithAccountableTimeInterval:(NSTimeInterval)ti {
	float		cost;
		
	if (generalController.countStartDate) {
		// Count is not null.
		
		cost = ti * (generalController.directorsNumber * generalController.directorCost
					 + generalController.managersNumber * generalController.managerCost
					 + generalController.teamNumber * generalController.teamCost) / 8 / 60 / 60;
	}
	else {
		cost = 0;
	}
	return cost;
}

- (NSUInteger)calculateCumulatedCostWithCost:(float)cost {
	NSUInteger	cumulatedCost = generalController.cumulatedCost;
	cumulatedCost += cost;
	return cumulatedCost;
}

- (NSUInteger)calculateCumulatedDurationWithAccountableTimeInterval:(NSTimeInterval)ti {
	NSTimeInterval cumulatedDuration = generalController.cumulatedDuration;
	cumulatedDuration += ti;
	return cumulatedDuration;
}

- (void)update {
}

#pragma mark -
#pragma mark Timer work

- (void)scheduleTimer {
	if (!timer) {
		timer = [[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(tick) userInfo:nil repeats:YES] retain];
	}
}

- (void)invalidateTimer {
	if (timer) {
		[timer invalidate];
		[timer release];
		timer = nil;
	}
}

- (void)resetStateAfterLaunch {
	if (generalController.countStartDate) {
		if (!generalController.countPauseDate) {
			[self startCounting];
		}
		else {
			[self pauseCounting];
		}
	}
	else [self tick];
}

#pragma mark -
#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	//NSLog(@"observe");
	if (generalController.suspended) {
		[self invalidateTimer];
	}
	else {
		[self scheduleTimer];
	}
}

#pragma mark -
#pragma mark Time interval manipulation

/**
 If no counting (no start date), returns 0.
 If counting is paused, returns the time interval from start date to pause date.
 If counting is ongoing, returns the time interval from start date to now.
 */
- (NSTimeInterval)accountableTimeInterval {
	if (!generalController.countStartDate) {
		return 0;
	}
	else if (generalController.countPauseDate) {
		return [generalController.countPauseDate timeIntervalSinceDate:generalController.countStartDate];
	}
	else {
		return -[generalController.countStartDate timeIntervalSinceNow];
	}
	
}

- (NSString *)stringForTimeIntervalToSeconds:(NSTimeInterval)ti {
	NSUInteger hours = trunc( ((double)ti) / (60 * 60) );
	NSUInteger minutes = trunc( ((double) (ti - 60 * 60 * hours) / 60) );
	NSUInteger seconds = ti - (60 * 60 * hours) - (60 * minutes);
	return [NSString stringWithFormat:@"%u %@%@ %u %@%@ %u %@%@",
			hours, NSLocalizedString(LocalHourLabelLong, nil), hours > 1 ? @"s" : @"",
			minutes, NSLocalizedString(LocalMinuteLabelLong, nil), minutes > 1 ? @"s" : @"",
			seconds, NSLocalizedString(LocalSecondLabelLong, nil), seconds > 1 ? @"s" : @""];
}

- (NSString *)stringForTimeIntervalToMinutes:(NSTimeInterval)ti {
	NSUInteger hours = trunc( ((double)ti) / (60 * 60) );
	NSUInteger minutes = trunc( ((double) (ti - 60 * 60 * hours) / 60) );
	return [NSString stringWithFormat:@"%u%@ %u%@",
			hours, NSLocalizedString(LocalHourLabelShort, nil), 
			minutes, NSLocalizedString(LocalMinuteLabelShort, nil)];
}

#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (buttonIndex) {
		case 1:
			// Continue button clicked
			if (alertView.tag == AlertClearTimerTag) {
				// Clear current timer
				[self stopCounting];
			}
			else if (alertView.tag == AlertClearCumulationTag) {
				// Clear cumulated values
				generalController.cumulatedCost = 0;
				generalController.cumulatedDuration = 0;
				
				[self tick];
			}
			break;
			
		default:
			// Cancel button clicked
			break;
	}
	[alertView release];
}


@end
