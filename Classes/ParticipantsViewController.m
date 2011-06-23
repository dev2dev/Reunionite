//
//  ParticipantsViewController.m
//  CashMeetings
//
//  Created by Romain Champourlier on 08/08/10.
//  Copyright 2010 SoftRoch. All rights reserved.
//

#import "ParticipantsViewController.h"
#define MAX_NUMBER_OF_PARTICIPANTS 50

@implementation ParticipantsViewController

@synthesize participantsController;

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
	participantsController.generalController = [((NSObject *)[[UIApplication sharedApplication] delegate]) valueForKey:@"generalController"];
	[participantsController update];
	
	UIImage *minImage = [[UIImage imageNamed:@"Slider-MinimumTrackImage"] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
	UIImage *maxImage = [[UIImage imageNamed:@"Slider-MaximumTrackImage"] stretchableImageWithLeftCapWidth:2 topCapHeight:0];

	directorsNumberSlider.maximumValue = MAX_NUMBER_OF_PARTICIPANTS;
	managersNumberSlider.maximumValue = MAX_NUMBER_OF_PARTICIPANTS;
	teamNumberSlider.maximumValue = MAX_NUMBER_OF_PARTICIPANTS;

	[directorsNumberSlider setMinimumTrackImage:minImage forState:UIControlStateNormal];
	[directorsNumberSlider setMaximumTrackImage:maxImage forState:UIControlStateNormal];
	[directorsNumberSlider setThumbImage:[UIImage imageNamed:@"Slider-Thumb-Normal"] forState:UIControlStateNormal];
	[directorsNumberSlider setThumbImage:[UIImage imageNamed:@"Slider-Thumb-Normal"] forState:UIControlStateHighlighted];
	[managersNumberSlider setMinimumTrackImage:minImage forState:UIControlStateNormal];
	[managersNumberSlider setMaximumTrackImage:maxImage forState:UIControlStateNormal];
	[managersNumberSlider setThumbImage:[UIImage imageNamed:@"Slider-Thumb-Normal"] forState:UIControlStateNormal];
	[managersNumberSlider setThumbImage:[UIImage imageNamed:@"Slider-Thumb-Normal"] forState:UIControlStateHighlighted];
	[teamNumberSlider setMinimumTrackImage:minImage forState:UIControlStateNormal];
	[teamNumberSlider setMaximumTrackImage:maxImage forState:UIControlStateNormal];
	[teamNumberSlider setThumbImage:[UIImage imageNamed:@"Slider-Thumb-Normal"] forState:UIControlStateNormal];
	[teamNumberSlider setThumbImage:[UIImage imageNamed:@"Slider-Thumb-Normal"] forState:UIControlStateHighlighted];
	
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
	//NSLog(@"[ParticipantsViewController update]");
	[participantsController update];
}

@end
