//
//  ParticipantsController.m
//  CashMeetings
//
//  Created by Romain Champourlier on 08/08/10.
//  Copyright 2010 SoftRoch. All rights reserved.
//

#import "ParticipantsController.h"

static NSString *CostLabelFormatStringKey = @"CostLabelFormatString";

@interface ParticipantsController ()
- (void)update:(NSString *)key;
//- (void)setValueToFieldValue:(UILabel *)label;
@end

@implementation ParticipantsController
@synthesize generalController;

- (void)awakeFromNib {
	[self retain];
}

- (void)dealloc {
	[self release];
    [super dealloc];
}

- (IBAction)incrementDirectorsNumber:(id)sender {
	generalController.directorsNumber = [directorsNumberField.text intValue] + 1;
	[self update:DirectorsNumberKey];
}

- (IBAction)incrementManagersNumber:(id)sender{
	generalController.managersNumber = [managersNumberField.text intValue] + 1;
	[self update:ManagersNumberKey];
}

- (IBAction)incrementTeamNumber:(id)sender{
	generalController.teamNumber = [teamNumberField.text intValue] + 1;
	[self update:TeamNumberKey];
}

- (IBAction)decrementDirectorsNumber:(id)sender {
	if (generalController.directorsNumber > 0) {
		generalController.directorsNumber = [directorsNumberField.text intValue] - 1;
		[self update:DirectorsNumberKey];
	}
}

- (IBAction)decrementManagersNumber:(id)sender{
	if (generalController.managersNumber > 0) {
		generalController.managersNumber = [managersNumberField.text intValue] - 1;
		[self update:ManagersNumberKey];
	}
}

- (IBAction)decrementTeamNumber:(id)sender{
	if (generalController.teamNumber > 0) {
		generalController.teamNumber = [teamNumberField.text intValue] - 1;
		[self update:TeamNumberKey];
	}	
}

/*- (void)setValueToFieldValue:(UILabel *)label {
	if (label == directorsNumberField) {
		generalController.directorsNumber = [label.text intValue];
		[self update:DirectorsNumberKey];
	}
	else if (label == managersNumberField) {
		generalController.managersNumber = [label.text intValue];
		[self update:ManagersNumberKey];
	}
	else if (label == teamNumberField) {
		generalController.teamNumber = [label.text intValue];
		[self update:TeamNumberKey];
	}
}*/

/**
 Update the view with all data from generalController.
 The following data are updated to the view:
	 - DirectorsNumberKey
	 - ManagersNumberKey
	 - TeamNumberKey
	 - DirectorCostKey
	 - ManagerCostKey
	 - TeamCostKey
 */
- (void)update {
	[self update:DirectorsNumberKey];
	[self update:ManagersNumberKey];
	[self update:TeamNumberKey];
	[self update:DirectorCostKey];
	[self update:ManagerCostKey];
	[self update:TeamCostKey];
}

/**
 Update the view with the generalController's data represented by the provided key.
 The key can be:
	- DirectorsNumberKey
	- ManagersNumberKey
	- TeamNumberKey
	- DirectorCostKey
	- ManagerCostKey
	- TeamCostKey
 */
- (void)update:(NSString *)key {
	if ([key isEqualToString:DirectorsNumberKey]) {
		directorsNumberField.text = [NSString stringWithFormat:@"%u", generalController.directorsNumber];
		directorsNumberSlider.value = (float)generalController.directorsNumber;
		[directorNumberView setPeopleNumber:generalController.directorsNumber];
	}
	else if ([key isEqualToString:ManagersNumberKey]) {
		managersNumberField.text = [NSString stringWithFormat:@"%u", generalController.managersNumber];
		managersNumberSlider.value = (float)generalController.managersNumber;
		[managerNumberView setPeopleNumber:generalController.managersNumber];
	}
	else if ([key isEqualToString:TeamNumberKey]) {
		teamNumberField.text = [NSString stringWithFormat:@"%u", generalController.teamNumber];
		teamNumberSlider.value = (float)generalController.teamNumber;
		[teamNumberView setPeopleNumber:generalController.teamNumber];
	}
	else if ([key isEqualToString:DirectorCostKey]) {
		directorCostLabel.text = [NSString stringWithFormat:NSLocalizedString(CostLabelFormatStringKey, nil), generalController.directorCost];
	}
	else if ([key isEqualToString:ManagerCostKey]) {
		managerCostLabel.text = [NSString stringWithFormat:NSLocalizedString(CostLabelFormatStringKey, nil), generalController.managerCost];
	}
	else if ([key isEqualToString:TeamCostKey]) {
		teamCostLabel.text = [NSString stringWithFormat:NSLocalizedString(CostLabelFormatStringKey, nil), generalController.teamCost];
	}
}

/*- (void)textFieldDidEndEditing:(UITextField *)textField {
	[self setValueToFieldValue:textField];
}*/

- (IBAction)directorSliderChanged:(id)sender {
	//NSLog(@"directorSliderChanged");
	generalController.directorsNumber = (NSUInteger)((UISlider *)sender).value;
	[self update:DirectorsNumberKey];
	//directorsNumberField.text = [NSString stringWithFormat:@"%.0f", ((UISlider *)sender).value];
}

- (IBAction)managersSliderChanged:(id)sender {
	generalController.managersNumber = (NSUInteger)((UISlider *)sender).value;
	[self update:ManagersNumberKey];
	//managersNumberField.text = [NSString stringWithFormat:@"%.0f", ((UISlider *)sender).value];
}

- (IBAction)teamSliderChanged:(id)sender {
	generalController.teamNumber = (NSUInteger)((UISlider *)sender).value;
	[self update:TeamNumberKey];
	//teamNumberField.text = [NSString stringWithFormat:@"%.0f", ((UISlider *)sender).value];
}

@end
