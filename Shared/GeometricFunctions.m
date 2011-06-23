/*
 *  GeometricFunctions.c
 *  iTinies
 *
 *  Created by Romain Champourlier on 31/01/10.
 *  Copyright 2010 SoftRoch. All rights reserved.
 *
 */

#include "GeometricFunctions.h"

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180 / M_PI;};

CGPoint CenterOfRect(CGRect rect) {
	return CGPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2);
};

/*
 Returns the 'b-a' point. If p is the returned point, p.x = b.x - a.x, and
 so on with y.
 */
CGPoint DeltaPoint(CGPoint a, CGPoint b) {
	return CGPointMake(b.x - a.x, b.y - a.y);
};

/*
 Returns a new CGRect with:
	- origin.x = sourceRect.origin.x = xChange,
	- ...
 */
CGRect ChangeRect (CGRect sourceRect, CGFloat xChange, CGFloat yChange, CGFloat widthChange, CGFloat heightChange) {
	return CGRectMake (sourceRect.origin.x + xChange, sourceRect.origin.y + yChange, sourceRect.size.width + widthChange, sourceRect.size.height + heightChange);
}

/*
 Returns YES if a and b are the same rects.
 */
BOOL	CompareRect(CGRect a, CGRect b) {
	return a.origin.x == b.origin.x && a.origin.y == b.origin.y && a.size.width == b.size.width && a.size.height == b.size.height;
}

#ifdef DEBUG

NSString *PointToString(CGPoint point) {
	return [NSString stringWithFormat:@"(%.0f, %.0f)", point.x, point.y];
};
NSString *RectToString(CGRect rect) {
	return [NSString stringWithFormat:@"(%.0f, %.0f) %.0fx%.0f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
};

NSString *SizeToString(CGSize size) {
	return [NSString stringWithFormat:@"%.0fx%.0f", size.width, size.height];
}

#endif