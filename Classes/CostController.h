//
//  CostController.h
//  CashMeetings
//
//  Created by Romain Champourlier on 03/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeneralController.h"
#import "Controller.h"

@interface CostController : NSObject <Controller, UITextFieldDelegate> {
	GeneralController		*generalController;
	IBOutlet UITextField	*directorCostField;
	IBOutlet UITextField	*managerCostField;
	IBOutlet UITextField	*teamCostField;
}

- (IBAction)incrementDirectorCost:(id)sender;
- (IBAction)incrementManagerCost:(id)sender;
- (IBAction)incrementTeamCost:(id)sender;
- (IBAction)decrementDirectorCost:(id)sender;
- (IBAction)decrementManagerCost:(id)sender;
- (IBAction)decrementTeamCost:(id)sender;

@property (nonatomic, assign) GeneralController *generalController;

@end
