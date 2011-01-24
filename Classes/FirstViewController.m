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

@implementation FirstViewController

@synthesize price;
@synthesize gallons;
@synthesize date;
@synthesize addButton;

NSString * stripPunctuation(NSString * s) {
	NSString* a=[[[NSString alloc] initWithData:[s dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] encoding:NSASCIIStringEncoding] autorelease];
	
	a = [a stringByReplacingOccurrencesOfString:@"$"withString:@""];
	a = [a stringByReplacingOccurrencesOfString:@"."withString:@""];
	return a;
}

- (IBAction)addPurchase{
	
	GasData * addData = [[[GasData alloc] init] autorelease];
	[addData setPrice: [[NSNumber alloc] initWithInt:[ stripPunctuation([price text]) integerValue]]];
	[addData setGallons: [[NSNumber alloc] initWithInt:[[gallons text] integerValue]]];
	[addData setDate: [date date]];
	
	[[[Globals sharedInstance] purchases] addObject:addData];
	
	/* hide the keyboards */
	[price resignFirstResponder];
	[gallons resignFirstResponder];
	
	/* tell SecondViewController to reloadData */
	// [uitableview reloadData];
}

- (IBAction)textFieldTouched:(id)sender {
	if(sender == price)
		[doneAdder addDoneButtonTo: price];
	else if(sender == gallons)
		[doneAdder addDoneButtonTo: gallons];
}

- (IBAction)priceTextFieldChanged {
	
	if([Globals sharedInstance].doPriceFieldChange) {
		[Globals sharedInstance].doPriceFieldChange = NO;
		return;
	}
	[Globals sharedInstance].doPriceFieldChange = YES;
	
	NSLog(@"hi");
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

		
	/*
	 grab price as number, then format to match that */
	
	gallons.text = temp;
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

@end
