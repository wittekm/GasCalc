//
//  ThirdViewController.m
//  GasCalc
//
//  Created by Max Kolasinski on 1/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ThirdViewController.h"
#import "Globals.h"
#import "GasData.h"



@implementation ThirdViewController


@synthesize graphHost;
@synthesize control;


-(NSUInteger)numberOfRecords {
	NSLog(@"Record number: %d", [[Globals sharedInstance].purchases count]);
    return [[Globals sharedInstance].purchases count];
}
-(NSUInteger)numberOfRecordsForPlot:(CPPlot *)plot {
	return [self numberOfRecords];
}

-(NSNumber *)numberForPlot:(CPPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
	NSMutableArray *data = [Globals sharedInstance].purchases;
    NSNumber *num = [NSDecimalNumber zero];
    if (fieldEnum == CPScatterPlotFieldX) 
    {
        //num = (NSDecimalNumber *) [NSDecimalNumber numberWithInt:index + 1];
		
		num = (NSDecimalNumber *) [NSDecimalNumber numberWithInt:index];
    }
    else if (fieldEnum == CPScatterPlotFieldY)
    {
        /*
		 NSDictionary *fData = (NSDictionary *)[financialData objectAtIndex:[financialData count] - index - 1];
		 num = [fData objectForKey:@"close"];
		 NSAssert([num isMemberOfClass:[NSDecimalNumber class]], @"grrr");
		 */
		num = [(GasData*)[data objectAtIndex:index] price];
    }
    return num;
}


-(void)reloadData
{
    if(!graph)
    {
		NSLog(@"allocating graph");
    	graph = [[CPXYGraph alloc] initWithFrame:CGRectZero];
        CPTheme *theme = [CPTheme themeNamed:kCPDarkGradientTheme];
        [graph applyTheme:theme];
        graph.paddingTop = 55.0;
        graph.paddingBottom = 10.0;
        graph.paddingLeft = 5.0;
        graph.paddingRight = 5.0;
		
        CPScatterPlot *dataSourceLinePlot = [[[CPScatterPlot alloc] initWithFrame:graph.bounds] autorelease];
        dataSourceLinePlot.identifier = @"Data Source Plot";
		
		
		CPLineStyle *lineStyle = [CPLineStyle lineStyle];
        lineStyle.lineColor = [CPColor colorWithGenericGray:0.8];
        lineStyle.lineWidth = 4.0;
		dataSourceLinePlot.dataLineStyle = lineStyle;
		 
		
        dataSourceLinePlot.dataSource = self;
		
        [graph addPlot:dataSourceLinePlot];
    }
	
	NSDate *refDate = [NSDate dateWithNaturalLanguageString:@"12:00 Oct 29, 2009"];
	NSTimeInterval oneDay = 24 * 60 * 60;
	
	NSLog(@"Index of graph is %d", [[self.graphHost.layer sublayers] indexOfObject:graph]);
    
    if([[self.graphHost.layer sublayers] indexOfObject:graph] == NSNotFound) {
		NSLog(@"yep not found");
        [self.graphHost.layer addSublayer:graph];
	}
    
	
    CPXYPlotSpace *plotSpace = (CPXYPlotSpace *)graph.defaultPlotSpace;
    
	NSLog(@"max is %d", [[[Globals sharedInstance].purchases valueForKeyPath:@"@max.price"] integerValue]);

	
    NSDecimalNumber *high = [NSDecimalNumber decimalNumberWithString:@"40"];
    NSDecimalNumber *low = [NSDecimalNumber decimalNumberWithString:@"-5"];
    NSDecimalNumber *length = [high decimalNumberBySubtracting:low];
    
	NSTimeInterval xLow = 0.0f;
	
	plotSpace.xRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromDouble(-0.6) length:CPDecimalFromInteger([self numberOfRecords])];
    plotSpace.yRange = [CPPlotRange plotRangeWithLocation:[low decimalValue] length:[length decimalValue]];
    
	// Axes
    CPXYAxisSet *axisSet = (CPXYAxisSet *)graph.axisSet;
    
    CPXYAxis *x = axisSet.xAxis;
    x.majorIntervalLength = CPDecimalFromDouble(10.0);
    x.orthogonalCoordinateDecimal = CPDecimalFromInteger(0);
    x.minorTicksPerInterval = 1;
	
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    dateFormatter.dateStyle = kCFDateFormatterShortStyle;
    CPTimeFormatter *timeFormatter = [[[CPTimeFormatter alloc] initWithDateFormatter:dateFormatter] autorelease];
    timeFormatter.referenceDate = refDate;
    x.labelFormatter = timeFormatter;
	x.alternatingBandFills =  [NSArray arrayWithObjects:[[CPColor whiteColor] colorWithAlphaComponent:0.09], [NSNull null], nil];
	
    
    CPXYAxis *y = axisSet.yAxis;
    NSDecimal five = CPDecimalFromInteger(5);
    y.majorIntervalLength = CPDecimalDivide([length decimalValue], five);
	y.majorTickLineStyle = nil;
    y.minorTicksPerInterval = 5;
	y.minorTickLineStyle = nil;
    y.orthogonalCoordinateDecimal = CPDecimalFromInteger(0);
	y.alternatingBandFills = [NSArray arrayWithObjects:[[CPColor whiteColor] colorWithAlphaComponent:0.09], [NSNull null], nil];
	
	NSLog (@"DERP HERP HERP...");
	
    [graph reloadData];
    
    [[self navigationItem] setTitle:@"Gas graph"];
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


 // Implement loadView to create a view hierarchy programmatically, without using a nib.

/*
 - (void)loadView {
	 
 }
*/


- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self reloadData];

	//graph = [[CPXYGraph alloc] initWithFrame: self.view.bounds];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    graph.frame = self.view.bounds;
}
	

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */

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
