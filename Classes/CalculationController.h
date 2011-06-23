//
//  CalculationController.h
//  CashMeetings
//
//  Created by Romain Champourlier on 03/08/10.
//  Copyright 2010 SoftRoch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeneralController.h"
#import "Controller.h"

@class EditTimeUIController;

@interface CalculationController : NSObject <Controller, UIAlertViewDelegate> {
	IBOutlet UILabel		*costLabel;
	IBOutlet UILabel		*countingLabel;
	IBOutlet UILabel		*durationLabel;
	IBOutlet UILabel		*cumulatedCostLabel;
	IBOutlet UILabel		*cumulatedDurationLabel;
	IBOutlet UIButton		*stopCountingButton;
	IBOutlet UIButton		*clearCumulatedValuesButton;
	
	IBOutlet UIButton		*editStartTimeButton;
	IBOutlet UIControl		*cancelEditTimeButton;
	IBOutlet UIControl		*validateEditTimeButton;
	IBOutlet UIControl		*add15MinutesButton;
	IBOutlet UIControl		*add1HourButton;

	IBOutlet EditTimeUIController	*editTimeUIController;
	
	GeneralController		*generalController;
	NSTimer					*timer;
	
	NSTimeInterval			editTimeInterval;
@private
}

- (IBAction)startStop:(id)sender;
- (IBAction)clearCounting:(id)sender;
- (IBAction)clearCumulatedValues:(id)sender;
- (IBAction)share:(id)sender;
- (IBAction)editStartTime:(id)sender;

- (void)scheduleTimer;
- (void)invalidateTimer;
- (void)resetStateAfterLaunch;


@property (nonatomic, assign) GeneralController *generalController;

@end
