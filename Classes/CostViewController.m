    //
//  CostViewController.m
//  CashMeetings
//
//  Created by Romain Champourlier on 03/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CostViewController.h"


@implementation CostViewController

@synthesize costController;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	costController.generalController = [((NSObject *)[[UIApplication sharedApplication] delegate]) valueForKey:@"generalController"];
	[(<Controller>)costController update];
	
	[directorsIncrementButton setImage:[UIImage imageNamed:@"Button-Increment.gif"] forState:UIControlStateNormal];
	[managersIncrementButton setImage:[UIImage imageNamed:@"Button-Increment.gif"] forState:UIControlStateNormal];
	[teamIncrementButton setImage:[UIImage imageNamed:@"Button-Increment.gif"] forState:UIControlStateNormal];
	[directorsDecrementButton setImage:[UIImage imageNamed:@"Button-Decrement.gif"] forState:UIControlStateNormal];
	[managersDecrementButton setImage:[UIImage imageNamed:@"Button-Decrement.gif"] forState:UIControlStateNormal];
	[teamDecrementButton setImage:[UIImage imageNamed:@"Button-Decrement.gif"] forState:UIControlStateNormal];
	[directorsIncrementButton setImage:[UIImage imageNamed:@"Button-Increment.gif"] forState:UIControlStateHighlighted];
	[managersIncrementButton setImage:[UIImage imageNamed:@"Button-Increment.gif"] forState:UIControlStateHighlighted];
	[teamIncrementButton setImage:[UIImage imageNamed:@"Button-Increment.gif"] forState:UIControlStateHighlighted];
	[directorsDecrementButton setImage:[UIImage imageNamed:@"Button-Decrement.gif"] forState:UIControlStateHighlighted];
	[managersDecrementButton setImage:[UIImage imageNamed:@"Button-Decrement.gif"] forState:UIControlStateHighlighted];
	[teamDecrementButton setImage:[UIImage imageNamed:@"Button-Decrement.gif"] forState:UIControlStateHighlighted];	
	
	commentView.type = DarkWithBorder;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (void)update {
	[costController update];
}


@end
