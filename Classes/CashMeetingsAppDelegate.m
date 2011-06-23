//
//  CashMeetingsAppDelegate.m
//  CashMeetings
//
//  Created by Romain Champourlier on 03/08/10.
//  Copyright SoftRoch © 2010. All rights reserved.
//

#import "CashMeetingsAppDelegate.h"
#import "SHK.h"

@interface CashMeetingsAppDelegate()
- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardDidShow:(NSNotification *)notification;
- (void)doneButton:(id)sender;
@end


@implementation CashMeetingsAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize generalController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    //NSLog(@"didFinishLaunching");
	
	// Override point for customization after application launch.
	generalController = [[[GeneralController alloc] init] retain];

    // Add the tab bar controller's view to the window and display.
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
	
	// Used to override default number pas keyboard to add the "Done" key
	// add observer for the respective notifications (depending on the os version)
	// Code from: http://www.neoos.ch/news/46-development/54-uikeyboardtypenumberpad-and-the-missing-return-key
	
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
		//NSLog(@">=3.2");
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(keyboardDidShow:) 
													 name:UIKeyboardDidShowNotification 
												   object:nil];		
	}
	else {
		//NSLog(@"<3.2");
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(keyboardWillShow:) 
													 name:UIKeyboardWillShowNotification 
												   object:nil];
	}
	
	// Ask ShareKit to resend items shared offline.
	[SHK flushOfflineQueue];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    //NSLog(@"applicationWillResignActive");
	
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
	generalController.suspended = YES;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    //NSLog(@"applicationDidEnterBackground");
	
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
	
	generalController.suspended = YES;
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    //NSLog(@"applicationWillEnterForeground");
	
    /*
     Called as part of transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */

	generalController.suspended = NO;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    //NSLog(@"applicationDidBecomeActive");
	
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
	
	generalController.suspended = NO;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    //NSLog(@"applicationWillTerminate");
	
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
	generalController.suspended = YES;
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark -
#pragma mark UITabBarControllerDelegate methods


// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
	//NSLog(@"[CashMeetingsAppDelegate tabBarController:didSelectViewController]");
	if (viewController == calculationViewController) {
		[calculationViewController update];
	}
	else if (viewController == costViewController) {
		[costViewController update];
	}
	else if (viewController == participantsViewController) {
		[participantsViewController update];
	}
}


/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[generalController release]; 
    [tabBarController release];
    [window release];
    [super dealloc];
}


#pragma mark -
#pragma mark Keyboard number pad override

/*
 Code from: http://www.neoos.ch/news/46-development/54-uikeyboardtypenumberpad-and-the-missing-return-key
 */
- (void)addButtonToKeyboard {
	//NSLog(@"addButton");
	
	// Verify displayed view is not calculation (alphanumeric keyboard will be used for sharing).
	if (tabBarController.selectedViewController != calculationViewController) {
	
		// create custom button
		UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
		doneButton.frame = CGRectMake(0, 163, 106, 53);
		doneButton.adjustsImageWhenHighlighted = NO;
		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.0) {
			[doneButton setImage:[UIImage imageNamed:@"Keyboard-NumberPad-Key-Done-Up-3.png"] forState:UIControlStateNormal];
			[doneButton setImage:[UIImage imageNamed:@"Keyboard-NumberPad-Key-Done-Down-3.png"] forState:UIControlStateHighlighted];
		} else {        
			[doneButton setImage:[UIImage imageNamed:@"Keyboard-NumberPad-Key-Done-Up.png"] forState:UIControlStateNormal];
			[doneButton setImage:[UIImage imageNamed:@"Keyboard-NumberPad-Key-Done-Down.png"] forState:UIControlStateHighlighted];
		}
		[doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
		// locate keyboard view
		UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
		UIView* keyboard;
		for(int i=0; i<[tempWindow.subviews count]; i++) {
			keyboard = [tempWindow.subviews objectAtIndex:i];
			//NSLog(@"%@", [keyboard description]);
			// keyboard found, add the button
			if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
				if([[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES)
					[keyboard addSubview:doneButton];
			} else {
				if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
					[keyboard addSubview:doneButton];
			}
		}
	}
}

- (void)keyboardWillShow:(NSNotification *)note {
	//NSLog(@"keyboardWillShow");
	// if clause is just an additional precaution, you could also dismiss it
	if ([[[UIDevice currentDevice] systemVersion] floatValue] < 3.2) {
		[self addButtonToKeyboard];
	}
}

- (void)keyboardDidShow:(NSNotification *)note {
	//NSLog(@"keyboardDidShow");
	// if clause is just an additional precaution, you could also dismiss it
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
		[self addButtonToKeyboard];
    }
}

- (void)doneButton:(id)sender {
	[self.window findAndResignFirstResponder];
}

@end

