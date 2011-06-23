//
//  ParticipantsController.h
//  CashMeetings
//
//  Created by Romain Champourlier on 08/08/10.
//  Copyright 2010 SoftRoch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeneralController.h"
#import "Controller.h"
#import "PeopleNumberView.h"

@interface ParticipantsController : NSObject <Controller, UITextFieldDelegate> {
	GeneralController		*generalController;
	
	IBOutlet UISlider		*directorsNumberSlider;
	IBOutlet UISlider		*managersNumberSlider;
	IBOutlet UISlider		*teamNumberSlider;

	IBOutlet UILabel		*directorsNumberField;
	IBOutlet UILabel		*managersNumberField;
	IBOutlet UILabel		*teamNumberField;
	
	IBOutlet UILabel		*directorCostLabel;
	IBOutlet UILabel		*managerCostLabel;
	IBOutlet UILabel		*teamCostLabel;
		
	IBOutlet PeopleNumberView	*directorNumberView;
	IBOutlet PeopleNumberView	*managerNumberView;
	IBOutlet PeopleNumberView	*teamNumberView;
}

- (IBAction)incrementDirectorsNumber:(id)sender;
- (IBAction)incrementManagersNumber:(id)sender;
- (IBAction)incrementTeamNumber:(id)sender;
- (IBAction)decrementDirectorsNumber:(id)sender;
- (IBAction)decrementManagersNumber:(id)sender;
- (IBAction)decrementTeamNumber:(id)sender;
- (IBAction)directorSliderChanged:(id)sender;
- (IBAction)managersSliderChanged:(id)sender;
- (IBAction)teamSliderChanged:(id)sender;

@property (nonatomic, assign) GeneralController *generalController;

@end
