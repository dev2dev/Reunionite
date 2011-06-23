//
//  GeneralController.m
//  CashMeetings
//
//  Created by Romain Champourlier on 03/08/10.
//  Copyright 2010 SoftRoch ©. All rights reserved.
//

#import "GeneralController.h"

@interface GeneralController ()
- (BOOL)saveToDefaults;
@end

@implementation GeneralController

@synthesize countStartDate;
@synthesize countPauseDate;

@synthesize cumulatedCost;
@synthesize cumulatedDuration;

@synthesize directorsNumber;
@synthesize managersNumber;
@synthesize teamNumber;
@synthesize directorCost;
@synthesize managerCost;
@synthesize teamCost;

@synthesize suspended;

/**
 GeneralController is instantiated by app's delegate when app did finish launching.
 It then loads the following values from user's defaults:
 - countStartDate,
 - directorsNumber,
 - managersNumber,
 - teamNumber,
 - directorCost,
 - managerCost,
 - teamCost.
 */
- (id)init {
	//NSLog(@"IN  [GeneralController init]");
	self = [super init];
	if (self) {
		suspended = NO;
		
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		
		countStartDate = [[defaults valueForKey:CountStartDateKey] retain];
		countPauseDate = [[defaults valueForKey:CountPauseDateKey] retain];
		//NSLog(@"countStartDate=%@", countStartDate);
		//NSLog(@"countPauseDate=%@", countPauseDate);
		
		if ([defaults valueForKey:CumulatedCostKey] == nil) {
			cumulatedCost = 0;
		}
		else {
			cumulatedCost = [[defaults valueForKey:CumulatedCostKey] unsignedIntValue];
		}
		if ([defaults valueForKey:CumulatedDurationKey] == nil) {
			cumulatedDuration = 0;
		}
		else {
			cumulatedDuration = [[defaults valueForKey:CumulatedDurationKey] unsignedIntValue];
		}
		if ([defaults valueForKey:DirectorsNumberKey] == nil) {
			directorsNumber = 0;
		}
		else {
			directorsNumber = [[defaults valueForKey:DirectorsNumberKey] unsignedIntValue];
		}
		if ([defaults valueForKey:ManagersNumberKey] == nil) {
			managersNumber = 0;
		}
		else {
			managersNumber = [[defaults valueForKey:ManagersNumberKey] unsignedIntValue];
		}
		if ([defaults valueForKey:TeamNumberKey] == nil) {
			teamNumber = 0;
		}
		else {
			teamNumber = [[defaults valueForKey:TeamNumberKey] unsignedIntValue];
		}
		if ([defaults valueForKey:DirectorCostKey] == nil) {
			directorCost = 1000;
		}
		else {
			directorCost = [[defaults valueForKey:DirectorCostKey] unsignedIntValue];
		}
		if ([defaults valueForKey:ManagerCostKey] == nil) {
			managerCost = 750;
		}
		else {
			managerCost = [[defaults valueForKey:ManagerCostKey] unsignedIntValue];
		}
		if ([defaults valueForKey:TeamCostKey] == nil) {
			teamCost = 500;
		}
		else {
			teamCost = [[defaults valueForKey:TeamCostKey] unsignedIntValue];
		}		
	}
	return self;
}

- (void)dealloc {	
	[countStartDate release];
	[countPauseDate release];
	[super dealloc];
}	

- (BOOL)saveToDefaults {
	//NSLog(@"IN  [GeneralController saveToDefaults]");
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setValue:countStartDate forKey:CountStartDateKey];
	//NSLog(@"saveToDefaults: countStartDate=%@", countStartDate);
	[defaults setValue:countPauseDate forKey:CountPauseDateKey];
	//NSLog(@"saveToDefaults: countPauseDate=%@", countPauseDate);

	//NSLog(@"RRcountStartDate=%@", [defaults valueForKey:CountStartDateKey]);
	//NSLog(@"RRcountPauseDate=%@", [defaults valueForKey:CountPauseDateKey]);	
	
	[defaults setValue:[NSNumber numberWithUnsignedInt:cumulatedCost] forKey:CumulatedCostKey];
	//NSLog(@"saveToDefaults: cumulatedCost=%@", cumulatedCost);
	[defaults setValue:[NSNumber numberWithUnsignedInt:cumulatedDuration] forKey:CumulatedDurationKey];
	//NSLog(@"saveToDefaults: cumulatedDuration=%@", cumulatedDuration);

	[defaults setValue:[NSNumber numberWithUnsignedInt:directorsNumber] forKey:DirectorsNumberKey];
	//NSLog(@"saveToDefaults: directorsNumber=%u", directorsNumber);
	[defaults setValue:[NSNumber numberWithUnsignedInt:managersNumber] forKey:ManagersNumberKey];
	//NSLog(@"saveToDefaults: managersNumber=%u", managersNumber);
	[defaults setValue:[NSNumber numberWithUnsignedInt:teamNumber] forKey:TeamNumberKey];
	//NSLog(@"saveToDefaults: teamNumber=%u", teamNumber);
	[defaults setValue:[NSNumber numberWithUnsignedInt:directorCost] forKey:DirectorCostKey];
	//NSLog(@"saveToDefaults: directorCost=%u", directorCost);
	[defaults setValue:[NSNumber numberWithUnsignedInt:managerCost] forKey:ManagerCostKey];
	//NSLog(@"saveToDefaults: managerCost=%u", managerCost);
	[defaults setValue:[NSNumber numberWithUnsignedInt:teamCost] forKey:TeamCostKey];
	//NSLog(@"saveToDefaults: teamCost=%u", teamCost);
	
	//NSLog(@"OUT [GeneralController saveToDefaults]");
	
	[defaults synchronize];
	
	return YES;
}

- (void)setSuspended:(BOOL)isSuspended {
	if (isSuspended) {
		[self saveToDefaults];
	}
	suspended = isSuspended;
}

@end
