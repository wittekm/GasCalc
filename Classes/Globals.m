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
@end
