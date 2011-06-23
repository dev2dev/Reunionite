//
//  CustomButton.h
//  CashMeetings
//
//  Created by Romain Champourlier on 07/09/10.
//  Copyright 2010 SoftRoch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

typedef enum {TypeNormal, TypeCancel, TypeValidate} CustomButtonType;

@interface CustomButton : UIControl {
	CustomButtonType	type;
	NSString			*title;
	
@private
	CGColorRef			lightColor;
	CGColorRef			darkColor;
}

- (void)setButtonType:(CustomButtonType)aType;
- (void)setTitle:(NSString *)aTitle;

@property (readonly) NSString *title;

@end
