//
//  FirstViewController.m
//  GasCalc
//
//  Created by Max Kolasinski on 1/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "Globals.h"
#import "NumberPadDone.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKReverseGeocoder.h>
#import <MapKit/MKPlacemark.h>



@implementation FirstViewController

@synthesize price;
@synthesize gallons;
@synthesize date;
@synthesize addButton;
@synthesize locationManager;
@synthesize geocoder;

NSString * stripPunctuation(NSString * s) {
	NSString* a=[[[NSString alloc] initWithData:[s dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] encoding:NSASCIIStringEncoding] autorelease];
	
	a = [a stringByReplacingOccurrencesOfString:@"$"withString:@""];
	a = [a stringByReplacingOccurrencesOfString:@"."withString:@""];
	return a;
}

MKPlacemark *myPlacemark;

- (IBAction)addPurchase{
	GasData * addData = [[[GasData alloc] init] autorelease];
	
	[addData setPrice: [[NSNumber alloc] initWithInt:[ stripPunctuation([price text]) integerValue]]];
	[addData setGallons: [[NSNumber alloc] initWithInt:[[gallons text] integerValue]]];
	[addData setDate: [date date]];
	[addData setLocation: [locationManager location]];
	
	if(myPlacemark) {
		NSString * city = [[NSString alloc] initWithString: [myPlacemark locality]];
		NSString * state = [[NSString alloc] initWithString: [myPlacemark administrativeArea]];
		NSString * locationInText = [[NSString alloc] initWithFormat:@"%@, %@", city, state];
		[addData setCitystate:locationInText];
		
	} else
		[addData setCitystate:@"Location Unknown..."];
	
	
	[[[Globals sharedInstance] purchases] addObject:addData];
	NSSortDescriptor *dateSorter = [[[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES] autorelease];
	[[Globals sharedInstance].purchases sortUsingDescriptors:[NSArray arrayWithObject:dateSorter]];
	
	/* hide the keyboards */
	[price resignFirstResponder];
	[gallons resignFirstResponder];
	
	price.text = @"";
	gallons.text = @"";
	[date setDate:[NSDate date]];
	
	/* tell SecondViewController to reloadData */
	// [uitableview reloadData];
}

- (IBAction)textFieldTouched:(id)sender {
	if(sender == price)
		[doneAdder addDoneButtonTo: price];
	else if(sender == gallons)
		[doneAdder addDoneButtonTo: gallons];
}

- (IBAction)textFieldChanged:(id)sender {
	if(sender == price) {
		
		if([Globals sharedInstance].doPriceFieldChange) {
			[Globals sharedInstance].doPriceFieldChange = NO;
			return;
		}
		[Globals sharedInstance].doPriceFieldChange = YES;
		
		price.text = [Globals formatIntegerToDecimal:price.text doDollarSign:YES];
	}
	else if(sender == gallons) {
		if([Globals sharedInstance].doGallonsFieldChange) {
			[Globals sharedInstance].doGallonsFieldChange = NO;
			return;
		}
		[Globals sharedInstance].doGallonsFieldChange = YES;
		
		gallons.text = [Globals formatIntegerToDecimal:gallons.text doDollarSign:NO];
	}
}


- (IBAction)priceTextFieldChanged {
	
	if([Globals sharedInstance].doPriceFieldChange) {
		[Globals sharedInstance].doPriceFieldChange = NO;
		return;
	}
	[Globals sharedInstance].doPriceFieldChange = YES;
	
	price.text = [Globals formatIntegerToDecimal:price.text doDollarSign:YES];
	
	/* 
	NSString* temp = stripPunctuation(price.text);
	NSNumber * priceAsNumber = [[[NSNumber alloc] initWithInt:[temp integerValue]] autorelease];
	
	if([price.text length] < 1) {
		price.text = @"$";
		return;
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
	
	price.text = [NSString stringWithFormat:@"$%d.%@", priceIntVal/100, trailing];
	 */

		
	/*
	 grab price as number, then format to match that */
	
	//gallons.text = temp;
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[date setDate:[NSDate date]]; /* set uidatepicker to today */
	doneAdder = [[NumberPadDone alloc] init];
	self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    locationManager.delegate = self;
	locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
	[locationManager startUpdatingLocation];
	//data = [[[GasData init] alloc] autorelease];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
	NSLog(@"reverseGeocoder didFailWithError:%@", error);
	
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark {
	NSLog(@"Geocoder works yo");
	myPlacemark = placemark;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	NSLog(@"Insie didUpdateToLocation");
	
	if(!self.geocoder){
		self.geocoder = [[[MKReverseGeocoder alloc] initWithCoordinate:newLocation.coordinate] autorelease];
		geocoder.delegate = self;
	}
	if ((newLocation == oldLocation) && (myPlacemark)){
	}
	else{
		[geocoder start];
	}
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error 
{
	NSLog(@"locationManager:%@ didFailWithError:%@", manager, error);
}
@end
