//
//  RoundedRectangleView.m
//  CashMeetings
//
//  Created by Romain Champourlier on 24/09/10.
//  Copyright 2010 SoftRoch. All rights reserved.
//

#import "RoundedRectangleView.h"

static CGFloat cornerRadius = 8.0;

@implementation RoundedRectangleView

@synthesize type;


- (id)initWithCoder:(NSCoder *)aDecoder	{
	self = [super initWithCoder:aDecoder];
	if (self) {
		type = LightNoBorder;
		lightColor = CreateDeviceRGBColorWithCompArray(lightColorSeq);
		CGColorRetain(lightColor);
		darkColor = CreateDeviceRGBColorWithCompArray(mediumDarkColorSeq);
		CGColorRetain(darkColor);
		blackColor = CreateDeviceGrayColor(0.0, 1.0);
		CGColorRetain(blackColor);
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	UIBezierPath *roundedRectanglePath = [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius] retain];
	
	if (type == LightNoBorder) {
		CGContextSetFillColorWithColor(ctx, lightColor);
		CGContextAddPath(ctx, roundedRectanglePath.CGPath);
		CGContextFillPath(ctx);
	}
	else {
		CGContextSetFillColorWithColor(ctx, darkColor);
		CGContextAddPath(ctx, roundedRectanglePath.CGPath);
		CGContextFillPath(ctx);
		
		CGContextSetLineWidth(ctx, 2.0);
		CGContextSetStrokeColorWithColor(ctx, blackColor);
		CGContextAddPath(ctx, roundedRectanglePath.CGPath);
		CGContextStrokePath(ctx);
	}
	
	[roundedRectanglePath release];
}


- (void)dealloc {
	CGColorRelease(lightColor);
	CGColorRelease(darkColor);
	CGColorRelease(blackColor);
    [super dealloc];
}


@end
