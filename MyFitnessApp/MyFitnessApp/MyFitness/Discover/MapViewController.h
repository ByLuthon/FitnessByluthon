//
//  MapViewController.h
//  MyFitnessApp
//
//  Created by macmini on 04/01/17.
//  Copyright © 2017 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"

@interface MapViewController : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate>
{
    MKMapView *mapview;
    
    MyAnnotation *ann[15000];

    CLLocationManager *locationManager;
    CLLocationCoordinate2D coordinate_currentlocation;
    CLLocationCoordinate2D coordinate;
    
    
    int idx;
    NSMutableArray *arrLocation;
}

@end
