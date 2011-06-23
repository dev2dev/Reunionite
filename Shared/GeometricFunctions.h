/*
 *  GeometricFunctions.h
 *  iTinies
 *
 *  Created by Romain Champourlier on 31/01/10.
 *  Copyright 2010 SoftRoch. All rights reserved.
 *
 */

#define DEBUG

CGFloat DegreesToRadians(CGFloat degrees);
CGFloat RadiansToDegrees(CGFloat radians);

CGPoint CenterOfRect(CGRect rect);
CGPoint DeltaPoint(CGPoint a, CGPoint b);
CGRect	ChangeRect (CGRect sourceRect, CGFloat xChange, CGFloat yChange, CGFloat widthChange, CGFloat heightChange);
BOOL	CompareRect(CGRect a, CGRect b);

NSString *PointToString(CGPoint point);
NSString *RectToString(CGRect rect);
NSString *SizeToString(CGSize size);
