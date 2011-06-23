//
//  ParticipantsViewController.h
//  CashMeetings
//
//  Created by Romain Champourlier on 08/08/10.
//  Copyright 2010 SoftRoch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParticipantsController.h"
#import "Controller.h"

@interface ParticipantsViewController : UIViewController <Controller> {
	IBOutlet ParticipantsController	*participantsController;
	//IBOutlet UIView					*peopleNumberView;
	IBOutlet UISlider				*directorsNumberSlider;
	IBOutlet UISlider				*managersNumberSlider;
	IBOutlet UISlider				*teamNumberSlider;
	IBOutlet UIButton				*directorsDecrementButton;
	IBOutlet UIButton				*directorsIncrementButton;
	IBOutlet UIButton				*managersDecrementButton;
	IBOutlet UIButton				*managersIncrementButton;
	IBOutlet UIButton				*teamDecrementButton;
	IBOutlet UIButton				*teamIncrementButton;
}

@property (readonly) ParticipantsController *participantsController;

@end
