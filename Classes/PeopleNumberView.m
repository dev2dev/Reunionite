//
//  PeopleNumberView.m
//  CashMeetings
//
//  Created by Romain Champourlier on 22/09/10.
//  Copyright 2010 SoftRoch. All rights reserved.
//

#import "PeopleNumberView.h"

static CGFloat	peopleIconMarginRatio = 10.0/100.0;	// ratio of the icon line size to keep as margin between 2 icons, or between icon and border
static CGFloat	peopleIconWidthHeightRatio = 10.0/18.0;
//static NSTimeInterval WaitTimeInterval = 0.06;
static NSTimeInterval TotalWaitTime = 2.0;
static CGFloat	circleDealiasingMargin = 1.0;

@interface PeopleNumberView (PrivateMethods)

- (void)incrementPeopleNumber;
- (void)decrementPeopleNumber;
- (void)peopleAnimationWithTimeInterval:(NSTimeInterval)interval;
- (void)newDraw;

- (void)findDimensions;
//- (NSUInteger)numberOfLinesFor:(NSUInteger)value;
- (CGRect)frameForIconAtPosition:(NSUInteger)position inTotal:(NSUInteger)total;
- (BOOL)iconVisibleInRect:(CGRect)rect;
- (void)drawIconInContext:(CGContextRef)ctx rect:(CGRect)rect;

- (NSUInteger)findPositionOfFirstIconInRect:(CGRect)rect;

@end

@implementation PeopleNumberView
@synthesize peopleNumber;

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super initWithCoder:decoder])) {
        peopleNumber = 0;
		numberOfLines = 0;
		maxNumberOfIconsPerLine = 0;

		light = CreateDeviceRGBColorWithCompArray(lightColorSeq);
		CGColorRetain(light);
		black = CreateDeviceRGBColor(0, 0, 0, 1.0);
		CGColorRetain(black);

		self.opaque = YES;
    }
    return self;
}

- (void)dealloc {
	CGColorRelease(light);
	CGColorRelease(black);
	[peopleIconsLayer release];
 	[peopleNumberLayer release];
	[super dealloc];
}

/**
 Called by the controller to update the number of people to be displayed by the view.
 
 The method looks at the difference between the old value and the provided one.
	- If the difference is more than 1, set needsDisplay for all the icon frames in the interval.
 */
- (void)setPeopleNumber:(NSUInteger)value {
	//NSLog(@"[PeopleNumberView setPeopleNumber:%u]", value);

	NSUInteger oldValue = peopleNumber;
	peopleNumber = value;
	
	NSUInteger oldNumberOfLines = numberOfLines;
	
	if (oldValue < value) {
		[self findDimensions];
		if (numberOfLines != oldNumberOfLines) {
			// If the required number of lines changed between the old and the new value, the whole frame is set to redraw, and all icons will be drawn.
			[self setNeedsDisplay];
			//NSLog(@"setNeedsDisplay");
		}
		else {
			// If the number of lines did not change, only the icon frames between the old and the new values are set to redraw.
			for (NSUInteger i = oldValue + 1; i <= value; i++) {
				CGRect newIconFrame = [self frameForIconAtPosition:i inTotal:value];
				[self setNeedsDisplayInRect:newIconFrame];
				//NSLog(@"setNeedsDisplayInRect:%@", RectToString(newIconFrame));
			}
		}
	}
	else if (oldValue > value) {
		[self findDimensions];
		if (numberOfLines != oldNumberOfLines) {
			[self setNeedsDisplay];
			//NSLog(@"setNeedsDisplay");
		}
		else {
			/*CGRect newIconFrame = [self frameForIconAtPosition:oldValue inTotal:oldValue];
			[self setNeedsDisplayInRect:newIconFrame];*/
			for (NSUInteger i = value; i <= oldValue; i++) {
				CGRect newIconFrame = [self frameForIconAtPosition:i inTotal:oldValue];
				[self setNeedsDisplayInRect:newIconFrame];
				//NSLog(@"setNeedsDisplayInRect:%@", RectToString(newIconFrame));
			}
		}
	}
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	//NSLog(@"drawRect:%@", RectToString(rect));

	CGContextRef	ctx = UIGraphicsGetCurrentContext();

	if (!CompareRect(rect, self.bounds)) {
		// Drawing rect is not the bounds. We can thus assume the number of lines is unchanged (or the whole frame would have be set for display).
		
		// 1. find first icon in rect position
		NSUInteger position = [self findPositionOfFirstIconInRect:rect];
		
		// 2. clear the rect
		CGContextSetFillColorWithColor(ctx, light);
		CGContextFillRect(ctx, rect);
		
		// 3. redraw all icons from position to peopleNumber
		for (int i = position; i <= peopleNumber; i++) {
			[self drawIconInContext:ctx rect:[self frameForIconAtPosition:i inTotal:peopleNumber]];
		}
		
		/*if ([self iconVisibleInRect:rect]) {
			// Icon is to be drawn.
			[self drawIconInContext:ctx rect:rect];
			
		}
		else {
			// No icon to draw. Clear the space.
			CGContextSetFillColorWithColor(ctx, light);
			CGContextFillRect(ctx, rect);
		}*/
	}
	else {
		//NSLog(@"redraw all");
		CGContextSetFillColorWithColor(ctx, light);
		CGContextFillRect(ctx, rect);
		
		for (int i = 1; i <= peopleNumber; i++) {
			[self drawIconInContext:ctx rect:[self frameForIconAtPosition:i inTotal:peopleNumber]];
		}
	}
}


#pragma mark -
#pragma mark PrivateMethods



#pragma mark -
#pragma mark Dimensions management

/**
 Setup the values for the instance's variables:
 - numberOfLines,
 - numberOfIconsPerLine,
 - lineHeight,
 - iconHeight,
 - iconWidth,
 - margin,
 - minNumberOfIconsPerLines,
 - maxNumberOfIconsPerLines,
 
 basing upon the following instance's variables:
 - displayedPeopleNumber (and not peopleNumber),
 - layerSize.height,
 - layerSize.width,
 - peopleIconMarginRatio,
 - peopleIconWidthHeightRatio.
 */
- (void)findDimensions {
	numberOfLines = 0;
	maxNumberOfIconsPerLine = 0;
	
	do {
		numberOfLines++;
		numberOfIconsPerLine = ceil (peopleNumber / (CGFloat)numberOfLines);
		
		lineHeight	= floor(self.bounds.size.height / numberOfLines);
		iconHeight	= floor(lineHeight * (1.0 - (numberOfLines - 1) * peopleIconMarginRatio / 2.0));
		iconWidth	= floor(iconHeight * peopleIconWidthHeightRatio);
		margin		= floor(lineHeight * peopleIconMarginRatio);
		CGFloat unusedHeight = floor(self.bounds.size.height - (iconHeight * numberOfLines + margin * (numberOfLines - 1)));
		iconHeight += floor(unusedHeight / (CGFloat)numberOfLines);
		
		minNumberOfIconsPerLine = maxNumberOfIconsPerLine + 1;
		maxNumberOfIconsPerLine = floor ((self.bounds.size.width - margin) / (margin + iconWidth));
	}
	while (numberOfIconsPerLine > maxNumberOfIconsPerLine);
	//NSLog(@"lineH=%f, iconH=%f, iconW=%f, margin=%f", lineHeight, iconHeight, iconWidth, margin);
}

/**
 Returns the number of lines required for a given total number of <value> icons to be displayed.
 */
/*- (NSUInteger)numberOfLinesFor:(NSUInteger)value {
	NSUInteger	tempNumberOfLines = 0;
	NSUInteger	tempNumberOfIconsPerLine;
	CGFloat		tempLineHeight, tempMargin, tempIconWidth, tempIconHeight;
	
	do {
		tempNumberOfLines++;
		tempNumberOfIconsPerLine = ceil (value / (CGFloat)tempNumberOfLines);
		//tempLineHeight	= layerSize.height / tempNumberOfLines;
		tempLineHeight	= self.bounds.size.height / tempNumberOfLines;
		tempIconHeight	= tempLineHeight * (1.0 - (tempNumberOfLines - 1) * peopleIconMarginRatio / 2.0);
		tempIconWidth	= tempIconHeight * peopleIconWidthHeightRatio;
		tempMargin		= tempLineHeight * peopleIconMarginRatio;
	}
	//while (tempNumberOfIconsPerLine * (tempMargin + tempIconWidth) + tempMargin > layerSize.width);
	while (tempNumberOfIconsPerLine * (tempMargin + tempIconWidth) + tempMargin > self.bounds.size.width);	

	//NSLog(@"[PeopleNumberView numberOfLinesFor:%u -> %u", value, tempNumberOfLines);
	return tempNumberOfLines;
}*/

/**
 Returns the frame in which to draw the icon at position in a total number of total icons.
 The returned frame is expected to be filled by the icon, it does include no margin.
 */
- (CGRect)frameForIconAtPosition:(NSUInteger)position inTotal:(NSUInteger)total {
	//NSLog(@"[PeopleNumberView frameForIconAtPosition:%u inTotal:%u]", position, total);
	
	//NSUInteger _numberOfLines = [self numberOfLinesFor:total];
	NSUInteger _column = ceil (position / (float)numberOfLines); // column in which the icon will appear
	NSUInteger _line = position % numberOfLines == 0 ? numberOfLines : position % numberOfLines;
	;
	
	//CGFloat currentX = layerSize.width - (iconWidth + margin) * (_column - 1) - iconWidth;
	CGFloat currentX = self.bounds.size.width - (iconWidth + margin) * (_column - 1) - iconWidth;
	CGFloat currentY = (iconHeight + margin) * (_line - 1);
	//NSLog(@"frame (col: %u line:%u)=%@", _column, _line, RectToString(CGRectMake(currentX, currentY, iconWidth, iconHeight)));
	
	return CGRectMake(currentX, currentY, iconWidth, iconHeight);
}

/**
 Returns YES if an icon should be displayed in the provided rectangle by drawRect:.
 Returns NO if not, or if the rect could not be matched with a normal icon position.
 */
- (BOOL)iconVisibleInRect:(CGRect)rect {
	NSUInteger col = 1 - (rect.origin.x + iconWidth - self.bounds.size.width) / (iconWidth + margin);
	NSUInteger line = 1 + rect.origin.y / (iconHeight + margin);
	//NSLog(@"iconVisibleInRect: %@, col=%u line=%u position=%u", RectToString(rect), col, line, (col -1) * numberOfLines + line);
	if (line <= numberOfLines && col <= maxNumberOfIconsPerLine &&
		((col - 1) * numberOfLines + line) <= peopleNumber) return YES;
	//NSLog(@"iconVisibleInRect NO", col, line);
	return NO;
}

/**
 Draws an icon in the provided graphic context and rect. The icon will be designed to fill the provided rect.
 */
- (void)drawIconInContext:(CGContextRef)ctx rect:(CGRect)rect {
	
	CGContextSetFillColorWithColor(ctx, light);
	CGContextFillRect(ctx, rect);
	
	CGContextSetFillColorWithColor(ctx, black);
	
	CGPoint origin  = rect.origin;
	CGSize	size	= rect.size;
	
	CGContextBeginPath		(ctx);
	CGContextMoveToPoint	(ctx, origin.x, origin.y + size.height);
	CGContextAddLineToPoint (ctx, origin.x, origin.y + 92.0 / 180.0 * size.height);
	CGContextAddArcToPoint	(ctx, origin.x, origin.y + 67.0 / 180.0 * size.height,
							 origin.x + 24.0 / 100.0 * size.width, origin.y + 67.0 / 180.0 * size.height,
							 24.0 / 100.0 * size.width);
	CGContextAddLineToPoint (ctx, origin.x + 76.0/100.0 * size.width, origin.y + 67.0 / 180.0 * size.height);
	CGContextAddArcToPoint	(ctx,
							 origin.x + size.width, origin.y + 67.0 / 180.0 * size.height,
							 origin.x + size.width, origin.y + 92.0 / 180.0 * size.height,
							 24.0 / 100.0 * size.width);
	CGContextAddLineToPoint (ctx, origin.x + size.width, origin.y + size.height);
	CGContextClosePath		(ctx);
	CGContextFillPath		(ctx);
	
	CGContextFillEllipseInRect(ctx, CGRectMake(origin.x + 17.0/100.0 * size.width, origin.y + circleDealiasingMargin,
											   66.0/100.0 * size.width, 66.0/100.0 * size.width));
}

/**
 Returns the position of the first icon to be displayed in the provided rect. Returns a value between 1 and peopleNumber. 
 The icons are displayed from left to right, top to bottom so the 1st one is the top-right one.
 
 It only returns the assumed position, wheter or not an icon should be displayed. It does not verify if an icon has to be drawn at the position.
 */
- (NSUInteger)findPositionOfFirstIconInRect:(CGRect)rect {
	NSUInteger col = 1 - (rect.origin.x + iconWidth - self.bounds.size.width) / (iconWidth + margin);
	NSUInteger line = 1 + rect.origin.y / (iconHeight + margin);
	col -= floor(rect.size.width / (iconWidth + margin));
	//NSLog(@"findPositionOfFirstIconInRect: %@, col=%u line=%u position=%u", RectToString(rect), col, line, (col - 1) * numberOfLines + line);
	return (col - 1) * numberOfLines + line;
}


@end