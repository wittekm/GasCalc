//
//  Globals.m
//  GasCalc
//
//  Created by Max Kolasinski on 1/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Globals.h"
#import <CoreLocation/CoreLocation.h>


@implementation Globals
@synthesize purchases;
@synthesize doPriceFieldChange;

+ (Globals *)sharedInstance
{
	static Globals *myInstance = nil;
	
	if (nil == myInstance){
		myInstance = [[[self class] alloc] init];
		// init var here
	}
	// return the instance of this class
	return myInstance;
}

NSString * stripPunctuationGlobal(NSString * s) {
	NSString* a=[[[NSString alloc] initWithData:[s dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] encoding:NSASCIIStringEncoding] autorelease];
	
	a = [a stringByReplacingOccurrencesOfString:@"$"withString:@""];
	a = [a stringByReplacingOccurrencesOfString:@"."withString:@""];
	return a;
}


+ (NSString*) formatIntegerToDecimal:(NSString*)orig doDollarSign:(BOOL)dollarSign {
	NSString* temp = stripPunctuationGlobal(orig);
	NSNumber * priceAsNumber = [[[NSNumber alloc] initWithInt:[temp integerValue]] autorelease];
	
	if(dollarSign == YES) {
		if([orig length] < 1) {
			orig = @"$";
			@throw(@"DERP");
		}
	}
	
	NSString * trailing;
	int priceIntVal = [priceAsNumber integerValue];
	
	NSString * lastTwoNumbers;
	@try {
		lastTwoNumbers = [temp substringFromIndex:[temp length] - 2];
	} @catch(id e) {
		lastTwoNumbers = [temp substringFromIndex:[temp length] - 1];
	}
	
	if([lastTwoNumbers integerValue] < 10) {
		NSLog(@"%@ less than 10", lastTwoNumbers);
		trailing = [NSString stringWithFormat:@"0%d", [lastTwoNumbers integerValue]];
	} else
		trailing = lastTwoNumbers;
	
	return [NSString stringWithFormat:@"$%d.%@", priceIntVal/100, trailing];
}
@end
