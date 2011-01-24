//
//  NumberPadDone.h
//  NavExample
//
//  Created by Max Wittek on 1/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NumberPadDone : NSObject {
	UITextField * textField;
}
- (void)addDoneButtonTo: (UITextField*)field;

@end
