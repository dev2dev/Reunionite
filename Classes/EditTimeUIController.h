//
//  EditTimeUIController.h
//  CashMeetings
//
//  Created by Romain Champourlier on 08/09/10.
//  Copyright 2010 SoftRoch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomButton.h"

@interface EditTimeUIController : NSObject {
	IBOutlet UIButton		*editStartTimeButton;
	IBOutlet CustomButton	*cancelEditTimeButton;
	IBOutlet CustomButton	*validateEditTimeButton;
	IBOutlet CustomButton	*add15MinutesButton;
	IBOutlet CustomButton	*add1HourButton;
	IBOutlet UIView			*editTimeView;
}

- (void)startEdit;
- (void)cancelEdit;

@end
