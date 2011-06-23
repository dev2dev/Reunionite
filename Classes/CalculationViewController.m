//
//  CalculationViewController.m
//  CashMeetings
//
//  Created by Romain Champourlier on 03/08/10.
//  Copyright SoftRoch © 2010. All rights reserved.
//

#import "CalculationViewController.h"
#import "CalculationController.h"

@implementation CalculationViewController

@synthesize calculationController;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
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

/*- (void)awakeFromNib {
	[adViewController retain];
}*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	calculationController.generalController = [((NSObject *)[[UIApplication sharedApplication] delegate]) valueForKey:@"generalController"];
	[calculationController.generalController addObserver:calculationController forKeyPath:@"suspended" options:0 context:nil];
	
	[calculationController resetStateAfterLaunch];
}

/*- (IBAction)startCounting:(id)sender {
	[self displayCountingView];
	[calculationController startCounting];
}*/

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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (void)update {
	[calculationController update];
}

@end
