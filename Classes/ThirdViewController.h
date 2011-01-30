//
//  ThirdViewController.h
//  GasCalc
//
//  Created by Max Kolasinski on 1/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ThirdViewController : UIViewController <CPPlotDataSource> {
	IBOutlet CPGraphHostingView *graphHost;
	IBOutlet UISegmentedControl *control;

@private
	CPXYGraph *graph;
	
}
@property (nonatomic, retain) IBOutlet CPGraphHostingView *graphHost;
@property (nonatomic, retain) IBOutlet UISegmentedControl *control;

-(void)reloadData;

@end
