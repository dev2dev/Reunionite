//
//  CustomButton.m
//  CashMeetings
//
//  Created by Romain Champourlier on 07/09/10.
//  Copyright 2010 SoftRoch. All rights reserved.
//

#import "CustomButton.h"
#import "GeometricFunctions.h"

static CGFloat	cornerRadius = 6.0;
static CGFloat	buttonShadowMargin = 5.0;
static CGFloat	textHorizontalMargin = 5.0;
static CGFloat	textVerticalMargin = 5.0;
static CGFloat	cancelSignWidth = 8;
static char		buttonFontName[10] = "Helvetica";

@implementation CustomButton

@synthesize title;

- (id)initWithCoder:(NSCoder *)decoder {
	//NSLog(@"CustomButton initWithCoder");
	
	self = [super initWithCoder:decoder];
	if (self) {
		type = TypeNormal;
		
		CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
		lightColor = CGColorCreate (colorSpace, lightColorSeq);
		CGColorRetain(lightColor);
		darkColor = CGColorCreate (colorSpace, darkColorSeq);
		CGColorRetain(darkColor);
		CGColorSpaceRelease(colorSpace);
		
		[self addObserver:self forKeyPath:@"highlighted" options:0 context:nil];
	}
	return self;
}

- (void)dealloc {
	CGColorRelease(lightColor);
	CGColorRelease(darkColor);
	[super dealloc];
}

- (void)setTitle:(NSString *)aTitle {
	title = aTitle;
	
	CGRect rect = [self frame];
	CGRect textFrame = CGRectMake (buttonShadowMargin + textHorizontalMargin, textVerticalMargin, rect.size.width - 2 * buttonShadowMargin - 2 * textHorizontalMargin, rect.size.height - buttonShadowMargin - 2 * textVerticalMargin);
	
	UILabel *label = [[[UILabel alloc] initWithFrame:textFrame] autorelease];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor colorWithCGColor:lightColor];
	label.text = aTitle;
	label.font = [label.font fontWithSize:12.0];
	label.textAlignment = UITextAlignmentCenter;
	[self addSubview:label];
	
	//[self setNeedsDisplay];
}

- (void)setButtonType:(CustomButtonType)aType {
	type = aType;
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	
	//NSLog(@"isHighlighted: %@", self.highlighted ? @"yes" : @"no");
	
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	CGContextSaveGState (ctx);
	
	CGFloat shadowBlur = 5.0;
	if (self.highlighted) shadowBlur = 2;
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	static CGFloat	shadowDarkColorSeq[] = {0, 0, 0, 2.0/3.0};
	static CGFloat	shadowLightColorSeq[] = {0, 0, 0, 1.0/3.0};
	CGColorRef shadowColor = CGColorCreate (colorSpace, self.highlighted ? shadowLightColorSeq :shadowDarkColorSeq);
	CGColorSpaceRelease(colorSpace);
	CGContextSetShadowWithColor(ctx, CGSizeMake(0, 0), shadowBlur, shadowColor);
	CGColorRelease(shadowColor);
	
	CGContextSetStrokeColorWithColor(ctx, darkColor);
	
	rect.origin.x += buttonShadowMargin;
	rect.size.width -= 2 * buttonShadowMargin;
	rect.size.height -= buttonShadowMargin;
	
	CGContextBeginPath (ctx);
	CGContextMoveToPoint	(ctx, rect.origin.x, rect.origin.y);
	CGContextAddLineToPoint (ctx, rect.origin.x, rect.origin.y + rect.size.height - cornerRadius);
	CGContextAddArcToPoint	(ctx, rect.origin.x, rect.origin.y + rect.size.height, rect.origin.x + cornerRadius, rect.origin.y + rect.size.height, cornerRadius);
	CGContextAddLineToPoint (ctx, rect.origin.x + rect.size.width - cornerRadius, rect.origin.y + rect.size.height);
	CGContextAddArcToPoint	(ctx, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height - cornerRadius, cornerRadius);
	CGContextAddLineToPoint (ctx, rect.origin.x + rect.size.width, rect.origin.y);
	CGContextClosePath (ctx);
	CGContextFillPath (ctx);
	CGContextStrokePath (ctx);
	
	CGContextRestoreGState (ctx);
	
	if (type != TypeNormal) {
		CGFloat top		= ceil (rect.origin.y + (rect.size.height - cancelSignWidth) / 2);
		CGFloat left	= ceil (rect.origin.x + (rect.size.width - cancelSignWidth) / 2);
		CGFloat right	= ceil (rect.origin.x + (rect.size.width + cancelSignWidth) / 2);
		CGFloat bottom	= ceil (rect.origin.y + (rect.size.height + cancelSignWidth) / 2);
		
		if (type == TypeCancel) {
			CGContextSetStrokeColorWithColor(ctx, lightColor);
			CGContextSetLineCap(ctx, kCGLineCapRound);
			CGContextSetLineWidth(ctx, 2.0);
			
			CGContextBeginPath (ctx);
			CGContextMoveToPoint (ctx, left, top);
			CGContextAddLineToPoint (ctx, right, bottom);
			CGContextClosePath (ctx);
			CGContextStrokePath (ctx);

			CGContextBeginPath (ctx);
			CGContextMoveToPoint (ctx, right, top);
			CGContextAddLineToPoint (ctx, left, bottom);
			CGContextClosePath (ctx);
			CGContextStrokePath (ctx);
		}
		else if (type == TypeValidate) {
			CGFloat horizontalMiddle	= ceil ((left + right) / 2.0);
			CGFloat verticalMiddle		= ceil ((top + bottom) / 2.0);
			
			CGContextSetStrokeColorWithColor(ctx, lightColor);
			CGContextSetLineCap(ctx, kCGLineCapRound);
			CGContextSetLineWidth(ctx, 2.0);
			
			CGContextBeginPath (ctx);
			CGContextMoveToPoint (ctx, left, verticalMiddle);
			CGContextAddLineToPoint (ctx, horizontalMiddle, bottom);
			CGContextAddLineToPoint (ctx, right, top);
			CGContextStrokePath (ctx);
		}
	}
}

/*- (void)drawInContext:(CGContextRef)ctx {
	NSLog(@"drawInContext");
}*/

#pragma mark -
#pragma mark Touch management

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	//NSLog(@"touchesBegan");
	[super touchesBegan:touches withEvent:event];
	[self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	//NSLog(@"touchesCancelled");
	[super touchesCancelled:touches withEvent:event];
	[self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	//NSLog(@"touchesEnded");
	[super touchesEnded:touches withEvent:event];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"highlighted"]) {
		[self setNeedsDisplay];
	}
}

@end
