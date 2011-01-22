//
//  FirstViewController.h
//  GasCalc
//
//  Created by Max Kolasinski on 1/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController {
	IBOutlet UITextField * price;
	IBOutlet UITextField * gallons;
	
	IBOutlet UIDatePicker * date;
	IBOutlet UIButton * addButton;
}
@property (retain) IBOutlet UITextField * price;
@property (retain) IBOutlet UITextField * gallons;
@property (retain) IBOutlet UIDatePicker * date;
@property (retain) IBOutlet UIButton * addButton;

@end
