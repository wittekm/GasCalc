//
//  FirstViewController.h
//  GasCalc
//
//  Created by Max Kolasinski on 1/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKReverseGeocoder.h>
#import "NumberPadDone.h"
#import "GasData.h"


@interface FirstViewController : UIViewController <UITextFieldDelegate, CLLocationManagerDelegate, MKReverseGeocoderDelegate> {
	IBOutlet UITextField * price;
	IBOutlet UITextField * gallons;
	
	IBOutlet UIDatePicker * date;
	IBOutlet UIButton * addButton;
	
	MKReverseGeocoder * geocoder;
	
	GasData * data;
	NumberPadDone * doneAdder;
	CLLocationManager * locationManager;
}
@property (retain) IBOutlet UITextField * price;
@property (retain) IBOutlet UITextField * gallons;
@property (retain) IBOutlet UIDatePicker * date;
@property (retain) IBOutlet UIButton * addButton;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) MKReverseGeocoder *geocoder;

- (IBAction)addPurchase;
- (IBAction)textFieldTouched:(id)sender;
- (IBAction)textFieldChanged:(id)sender;

@end
