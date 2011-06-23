//
//  Controller.h
//  CashMeetings
//
//  Created by Romain Champourlier on 08/08/10.
//  Copyright 2010 SoftRoch. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol Controller

/**
 Request the controller to update all the view it manages.
 */
- (void)update;

@end
