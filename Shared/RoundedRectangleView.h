//
//  RoundedRectangleView.h
//  CashMeetings
//
//  Created by Romain Champourlier on 24/09/10.
//  Copyright 2010 SoftRoch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "GraphicFunctions.h"

typedef enum {LightNoBorder, DarkWithBorder} RoundedRectangleType;

@interface RoundedRectangleView : UIView {
	RoundedRectangleType	type;
	CGColorRef				blackColor;
	CGColorRef				darkColor;
	CGColorRef				lightColor;
}

@property RoundedRectangleType type;

@end
