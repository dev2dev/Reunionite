//
//  CashMeetingsAppDelegate.h
//  CashMeetings
//
//  Created by Romain Champourlier on 03/08/10.
//  Copyright SoftRoch © 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView_RoCHExtensions.h"

#import "GeneralController.h"

#import "CalculationViewController.h"
#import "CostViewController.h"
#import "ParticipantsViewController.h"

@interface CashMeetingsAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;

@private
	GeneralController					*generalController;
	IBOutlet CalculationViewController	*calculationViewController;
	IBOutlet CostViewController			*costViewController;
	IBOutlet ParticipantsViewController *participantsViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (readonly) GeneralController *generalController;

@end
