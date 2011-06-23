//
//  EditTimeUIController.m
//  CashMeetings
//
//  Created by Romain Champourlier on 08/09/10.
//  Copyright 2010 SoftRoch. All rights reserved.
//

#import "EditTimeUIController.h"

static CGFloat buttonHeight = 23.0;
static NSString	*Add1HourButtonTitleKey = @"Add1HourButtonTitleKey";
static NSString	*Add15MinutesButtonTitleKey = @"Add15MinutesButtonTitleKey";

@implementation EditTimeUIController

- (void)awakeFromNib {
	[self retain];
}

- (void)dealloc {
	NSLog(@"EditTimeUIController dealloc");
	[self release];
    [super dealloc];
}

- (void)startEdit {

	// TODO: do it first time only
	{
		[cancelEditTimeButton setButtonType:TypeCancel];
		[validateEditTimeButton setButtonType:TypeValidate];
		[add1HourButton setTitle:NSLocalizedString(Add1HourButtonTitleKey, nil)];
		[add15MinutesButton setTitle:NSLocalizedString(Add15MinutesButtonTitleKey, nil)];
	}
		 
	CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -buttonHeight);
	cancelEditTimeButton.transform		= transform;
	validateEditTimeButton.transform	= transform;
	add1HourButton.transform			= transform;
	add15MinutesButton.transform		= transform;
	
	[cancelEditTimeButton setHidden:NO];
	[validateEditTimeButton setHidden:NO];
	[add1HourButton setHidden:NO];
	[add15MinutesButton setHidden:NO];

	void (^animation) (void) = ^(void) {
		editTimeView.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:226.0/255.0 alpha:0.8];
		cancelEditTimeButton.transform		= CGAffineTransformIdentity;
		validateEditTimeButton.transform	= CGAffineTransformIdentity;
		add1HourButton.transform			= CGAffineTransformIdentity;
		add15MinutesButton.transform		= CGAffineTransformIdentity;
		
	};
	[UIView animateWithDuration:0.4 animations:animation];
	
	[editStartTimeButton setEnabled:NO];
}

- (void)cancelEdit {
	CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -buttonHeight);
	
	void (^animation) (void) = ^(void) {
		editTimeView.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:226.0/255.0 alpha:0.0];
		cancelEditTimeButton.transform		= transform;
		validateEditTimeButton.transform	= transform;
		add1HourButton.transform			= transform;
		add15MinutesButton.transform		= transform;
	};
	void (^completion) (BOOL) = ^(BOOL finished) {
		[cancelEditTimeButton setHidden:YES];
		[validateEditTimeButton setHidden:YES];
		[add1HourButton setHidden:YES];
		[add15MinutesButton setHidden:YES];
	};
	[UIView animateWithDuration:0.4 animations:animation completion:completion];
	
	[editStartTimeButton setEnabled:YES];
}

@end
