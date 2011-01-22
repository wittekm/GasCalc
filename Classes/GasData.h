//
//  GasData.h
//  GasCalc
//
//  Created by Max Wittek on 1/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GasData : NSObject {
	int price;
	int amt;
	NSDate * date;
}

@property int price;
@property int amt;
@property (retain) NSDate * date;

@end

/*
@interface GasData : NSObject {
	NSMutableArray * data;
}

-(void) add;

@property (retain) NSMutableArray * data;

@end
*/