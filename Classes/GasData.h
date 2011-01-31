//
//  GasData.h
//  GasCalc
//
//  Created by Max Wittek on 1/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface GasData : NSObject {
	NSNumber * price;
	NSNumber * gallons;
	NSDate * date;
	CLLocation * location;
	NSString * citystate;
}

@property (retain) NSNumber * price;
@property (retain) NSNumber * gallons;
@property (retain) NSDate * date;
@property (retain) CLLocation * location;
@property (retain) NSString * citystate;

@end

/*
@interface GasData : NSObject {
	NSMutableArray * data;
}

-(void) add;

@property (retain) NSMutableArray * data;

@end
*/