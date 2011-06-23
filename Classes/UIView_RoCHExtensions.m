//
//  RoCHUIViewExtensions.m
//  CashMeetings
//
//  Created by Romain Champourlier on 18/08/10.
//  Copyright 2010 SoftRoch. All rights reserved.
//

#import "UIView_RoCHExtensions.h"

@implementation UIView (RoCHExtensions)

- (UIView *)findAndResignFirstResponder {
    if (self.isFirstResponder) {
        [self resignFirstResponder];
		return self;     
    }
	
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findAndResignFirstResponder];
		
        if (firstResponder != nil) {
			[firstResponder resignFirstResponder];
			return firstResponder;
        }
    }
	
    return nil;
}
@end
