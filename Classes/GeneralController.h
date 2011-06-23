//
//  GeneralController.h
//  CashMeetings
//
//  Created by Romain Champourlier on 03/08/10.
//  Copyright 2010 SoftRoch ©. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface GeneralController : NSObject {
	NSDate		*countStartDate;
	NSDate		*countPauseDate;
	
	NSUInteger	cumulatedCost;
	NSUInteger	cumulatedDuration;	// in seconds
	
	NSUInteger	directorsNumber;
	NSUInteger	managersNumber;
	NSUInteger	teamNumber;
	NSUInteger	directorCost;
	NSUInteger	managerCost;
	NSUInteger	teamCost;
	
	BOOL		suspended; // Set by app's delegate to signal app is to be suspended (background, resign active, or terminated). To be observed by other class to determine when they should do suspension related actions.
}

@property (nonatomic, getter=isSuspended)			BOOL		suspended;

@property (nonatomic, retain)	NSDate		*countStartDate;
@property (nonatomic, retain)	NSDate		*countPauseDate;

@property (nonatomic)			NSUInteger	cumulatedCost;
@property (nonatomic)			NSUInteger	cumulatedDuration;

@property (nonatomic)			NSUInteger	directorsNumber;
@property (nonatomic)			NSUInteger	managersNumber;
@property (nonatomic)			NSUInteger	teamNumber;
@property (nonatomic)			NSUInteger	directorCost;
@property (nonatomic)			NSUInteger	managerCost;
@property (nonatomic)			NSUInteger	teamCost;

@end
