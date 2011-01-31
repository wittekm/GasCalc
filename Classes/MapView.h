//
//  MapView.h
//  GasCalc
//
//  Created by Max Wittek on 1/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface MapView : UIViewController <MKMapViewDelegate> {
	IBOutlet MKMapView * map;
}

@property (nonatomic,retain) IBOutlet MKMapView * map;

@end
