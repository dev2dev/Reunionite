//
//  CostController.m
//  CashMeetings
//
//  Created by Romain Champourlier on 03/08/10.
//  Copyright 2010 SoftRoch. All rights reserved.
//

#import "CostController.h"

@interface CostController()
- (void)update:(NSString *)key;
- (void)setValueToFieldValue:(UITextField *)field;
@end

@implementation CostController

@synthesize generalController;

- (void)awakeFromNib {
	[self retain];
}

- (void)dealloc {
	[self release];
    [super dealloc];
}

- (IBAction)incrementDirectorCost:(id)sender {
	generalController.directorCost = [directorCostField.text intValue] + 50;
	[self update:DirectorCostKey];
}

- (IBAction)incrementManagerCost:(id)sender {
	generalController.managerCost = [managerCostField.text intValue] + 50;
	[self update:ManagerCostKey];
}

- (IBAction)incrementTeamCost:(id)sender {
	generalController.teamCost = [teamCostField.text intValue] + 50;
	[self update:TeamCostKey];
}

- (IBAction)decrementDirectorCost:(id)sender {
	if (generalController.directorCost > 0) {
		generalController.directorCost = [directorCostField.text intValue] - 50;
		[self update:DirectorCostKey];
	}
}

- (IBAction)decrementManagerCost:(id)sender {
	if (generalController.managerCost > 0) {
		generalController.managerCost = [managerCostField.text intValue] - 50;
		[self update:ManagerCostKey];
	}
}

- (IBAction)decrementTeamCost:(id)sender {
	if (generalController.teamCost > 0) {
		generalController.teamCost = [teamCostField.text intValue] - 50;
		[self update:TeamCostKey];
	}
}

- (void)setValueToFieldValue:(UITextField *)field {
	if (field == directorCostField) {
		generalController.directorCost = [field.text intValue];
	}
	else if (field == managerCostField) {
		generalController.managerCost = [field.text intValue];
	}
	else if (field == teamCostField) {
		generalController.teamCost = [field.text intValue];
	}
}

/**
 Called by the CalculationViewController at the end of the viewDidLoad method.
 */
- (void)update {
	[self update:DirectorCostKey];
	[self update:ManagerCostKey];
	[self update:TeamCostKey];
}

- (void)update:(NSString *)key {
	if ([key isEqualToString:DirectorCostKey]) {
		directorCostField.text = [NSString stringWithFormat:@"%u", generalController.directorCost];
	}
	else if ([key isEqualToString:ManagerCostKey]) {
		managerCostField.text = [NSString stringWithFormat:@"%u", generalController.managerCost];
	}
	else if ([key isEqualToString:TeamCostKey]) {
		teamCostField.text = [NSString stringWithFormat:@"%u", generalController.teamCost];
	}
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	[self setValueToFieldValue:textField];
}


@end
