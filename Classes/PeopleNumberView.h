//
//  PeopleNumberView.h
//  CashMeetings
//
//  Created by Romain Champourlier on 22/09/10.
//  Copyright 2010 SoftRoch. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PeopleNumberLayerDelegate.h"
//#import "PeopleIconView.h"
#import "GeometricFunctions.h"
#import "GraphicFunctions.h"
#import "Constants.h"

@interface PeopleNumberView : UIView {
	NSUInteger				peopleNumber;
	NSUInteger				displayedPeopleNumber;
	IBOutlet UITextField	*peopleNumberField;
	
@private
	NSUInteger	numberOfLines, numberOfIconsPerLine, minNumberOfIconsPerLine, maxNumberOfIconsPerLine;
	CGFloat		iconHeight, iconWidth, lineHeight, margin;
	CALayer		*peopleIconsLayer;
	CALayer		*peopleNumberLayer;
	
	CGColorRef	light;
	CGColorRef	black;
}

@property NSUInteger peopleNumber;

@end
