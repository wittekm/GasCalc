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
	// place global variables here
}
+ (Globals *)sharedInstance;

@property (retain) NSMutableArray * purchases;
@end
