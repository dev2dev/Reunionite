//
//  CostViewController.h
//  CashMeetings
//
//  Created by Romain Champourlier on 03/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CostController.h"
#import "Controller.h"
#import "RoundedRectangleView.h"

@interface CostViewController : UIViewController <Controller> {
	IBOutlet CostController			*costController;
	IBOutlet UIButton				*directorsDecrementButton;
	IBOutlet UIButton				*directorsIncrementButton;
	IBOutlet UIButton				*managersDecrementButton;
	IBOutlet UIButton				*managersIncrementButton;
	IBOutlet UIButton				*teamDecrementButton;
	IBOutlet UIButton				*teamIncrementButton;
	IBOutlet RoundedRectangleView	*commentView;
}

@property (readonly) CostController *costController;

@end
