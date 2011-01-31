//
//  Globals.h
//  GasCalc
//
//  Created by Max Kolasinski on 1/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Globals : NSObject {
	NSMutableArray * purchases;
	BOOL doPriceFieldChange;
	// place global variables here
}
+ (Globals *)sharedInstance;
+ (NSString*) formatIntegerToDecimal:(NSString*)orig doDollarSign:(BOOL)dollarSign;

@property BOOL doPriceFieldChange;
@property (retain) NSMutableArray * purchases;
@end
