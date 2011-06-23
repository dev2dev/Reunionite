//
//  CalculationViewController.h
//  CashMeetings
//
//  Created by Romain Champourlier on 03/08/10.
//  Copyright SoftRoch © 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CalculationController.h"
#import "Controller.h"

@class CalculationController;

@interface CalculationViewController : UIViewController <Controller> {
	IBOutlet CalculationController	*calculationController;
@private
}

//- (IBAction)startCounting:(id)sender;

@property (readonly) CalculationController *calculationController;

@end
