//
//  MapViewController.m
//  MyFitnessApp
//
//  Created by macmini on 04/01/17.
//  Copyright © 2017 rlogical-dev-21. All rights reserved.
//

#import "MapViewController.h"
#import "MyAnnotation.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden = TRUE;
    
    // Map View
    mapview = [[MKMapView alloc] initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT-60)];
    mapview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    mapview.delegate = self;
    mapview.showsUserLocation = YES;
    mapview.mapType = MKMapTypeStandard;
    [self.view addSubview:mapview];

    [self initParam];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = TRUE;

    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    locationManager = nil;
    [locationManager stopUpdatingLocation];
    
    [super viewWillDisappear:animated];
}

#pragma mark - Init
-(void)initParam
{
    //Location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLLocationAccuracyKilometer;
    [locationManager startUpdatingLocation];
    
    CLLocation *location = [locationManager location];
    coordinate_currentlocation = [location coordinate];
    
    
    arrLocation = [[NSMutableArray alloc] init];
    [self fillupArr];
    
    
    [mapview removeAnnotations:mapview.annotations];
    
    for (int i=0; i < [arrLocation count]; i++)
    {
        coordinate.latitude = [[[arrLocation objectAtIndex:i] objectForKey:@"lat"] floatValue];
        coordinate.longitude = [[[arrLocation objectAtIndex:i]  objectForKey:@"lon"] floatValue];
        
        ann[i] = [[MyAnnotation alloc] init];
        ann[i].coordinate = coordinate;
        ann[i].tag=[NSNumber numberWithInt:i];
        

        ann[i].title = [NSString stringWithFormat:@"%@",[[arrLocation objectAtIndex:i] objectForKey:@"name"]];
        ann[i].title = [NSString stringWithFormat:@"%@",[[arrLocation objectAtIndex:i] objectForKey:@"username"]];

        [mapview addAnnotation:ann[i]];
        //[ann[i] release];
    }
    mapview.region = MKCoordinateRegionMakeWithDistance(coordinate_currentlocation, 100, 100);
    
    //[mapview addAnnotation:mapview.userLocation];
    [mapview setCenterCoordinate:coordinate_currentlocation];
    mapview.showsUserLocation = YES;
    
    NSArray *anno_Arrr = mapview.annotations;
    [mapview showAnnotations:anno_Arrr animated:YES];

}
-(void)fillupArr
{
    NSMutableDictionary *dict_1 = [[NSMutableDictionary alloc]init];
    [dict_1 setObject:@"Sam" forKey:@"name"];
    [dict_1 setObject:@"Sam1548" forKey:@"username"];
    [dict_1 setObject:@"23.033625" forKey:@"lat"];
    [dict_1 setObject:@"72.571832" forKey:@"lon"];
    [arrLocation addObject:dict_1];
    
    NSMutableDictionary *dict_2 = [[NSMutableDictionary alloc]init];
    [dict_2 setObject:@"Cory" forKey:@"name"];
    [dict_2 setObject:@"CoryAndorson" forKey:@"username"];
    [dict_2 setObject:@"23.035343" forKey:@"lat"];
    [dict_2 setObject:@"72.557648" forKey:@"lon"];
    [arrLocation addObject:dict_2];

    
    NSMutableDictionary *dict_3 = [[NSMutableDictionary alloc]init];
    [dict_3 setObject:@"Amanda" forKey:@"name"];
    [dict_3 setObject:@"AMANDA@ET" forKey:@"username"];
    [dict_3 setObject:@"23.035343" forKey:@"lat"];
    [dict_3 setObject:@"72.555782" forKey:@"lon"];
    [arrLocation addObject:dict_3];

    
    NSMutableDictionary *dict_4 = [[NSMutableDictionary alloc]init];
    [dict_4 setObject:@"Ethan" forKey:@"name"];
    [dict_4 setObject:@"Ethan_SAMA" forKey:@"username"];
    [dict_4 setObject:@"23.038167" forKey:@"lat"];
    [dict_4 setObject:@"72.567540" forKey:@"lon"];
    [arrLocation addObject:dict_4];

    
    NSMutableDictionary *dict_5 = [[NSMutableDictionary alloc]init];
    [dict_5 setObject:@"Eunice" forKey:@"name"];
    [dict_5 setObject:@"EU@together" forKey:@"username"];
    [dict_5 setObject:@"23.033309" forKey:@"lat"];
    [dict_5 setObject:@"72.563571" forKey:@"lon"];
    [arrLocation addObject:dict_5];

    
    NSMutableDictionary *dict_6 = [[NSMutableDictionary alloc]init];
    [dict_6 setObject:@"Jeffery" forKey:@"name"];
    [dict_6 setObject:@"Jeff" forKey:@"username"];
    [dict_6 setObject:@"23.031670" forKey:@"lat"];
    [dict_6 setObject:@"72.561768" forKey:@"lon"];
    [arrLocation addObject:dict_6];

    
    NSMutableDictionary *dict_7 = [[NSMutableDictionary alloc]init];
    [dict_7 setObject:@"Lula" forKey:@"name"];
    [dict_7 setObject:@"1548" forKey:@"username"];
    [dict_7 setObject:@"23.033309" forKey:@"lat"];
    [dict_7 setObject:@"72.559966" forKey:@"lon"];
    [arrLocation addObject:dict_7];

    
    NSMutableDictionary *dict_8 = [[NSMutableDictionary alloc]init];
    [dict_8 setObject:@"Alex" forKey:@"name"];
    [dict_8 setObject:@"AlexDOCOMO" forKey:@"username"];
    [dict_8 setObject:@"23.034691" forKey:@"lat"];
    [dict_8 setObject:@"72.567669" forKey:@"lon"];
    [arrLocation addObject:dict_8];

    
    NSMutableDictionary *dict_9 = [[NSMutableDictionary alloc]init];
    [dict_9 setObject:@"Florence" forKey:@"name"];
    [dict_9 setObject:@"Flo_121" forKey:@"username"];
    [dict_9 setObject:@"23.035145" forKey:@"lat"];
    [dict_9 setObject:@"72.564429" forKey:@"lon"];
    [arrLocation addObject:dict_9];

    
    NSMutableDictionary *dict_10 = [[NSMutableDictionary alloc]init];
    [dict_10 setObject:@"Williams" forKey:@"name"];
    [dict_10 setObject:@"Willoams11" forKey:@"username"];
    [dict_10 setObject:@"23.031887" forKey:@"lat"];
    [dict_10 setObject:@"72.563957" forKey:@"lon"];
    [arrLocation addObject:dict_10];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - MKAnnotationView
/*
- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(MyAnnotation*) annotation
{
    MKAnnotationView *a = [[ [ MKAnnotationView alloc ] initWithAnnotation:annotation reuseIdentifier:@"currentloc"]autorelease];
    if ( a == nil )
        a = [ [ MKAnnotationView alloc ] initWithAnnotation:annotation reuseIdentifier: @"currentloc" ];
    
    MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:a reuseIdentifier:@"currentloc"];
    
    if(a.annotation.coordinate.longitude == mapView.userLocation.coordinate.longitude ||  a.annotation.coordinate.latitude == mapView.userLocation.coordinate.latitude  )
    {
        if ([annotation isKindOfClass:MKUserLocation.class])
        {
            return nil;
        }
    }
    else
    {
        annView.image = [UIImage imageNamed:@"marker_pin.png"];
        annView.annotation = annotation;
        annView.tag = idx;
        annView.canShowCallout = YES;
        UIButton *button1 =	[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        button1.tag=[annotation.tag intValue];
        [button1 addTarget:self action:@selector(annotationTapped:) forControlEvents:UIControlEventTouchUpInside];
        annView.rightCalloutAccessoryView =  button1;
        idx++;
    }
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"marker.png"]];
    annView.leftCalloutAccessoryView = imgView;
    return annView;
}
*/
 
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    else if ([annotation isKindOfClass:[MyAnnotation class]]) // use whatever annotation class you used when creating the annotation
    {
        static NSString * const identifier = @"currentloc";
        
        MKAnnotationView* annView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annView)
        {
            annView.annotation = annotation;
        }
        else
        {
            annView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:identifier];
            
            annView.image = [UIImage imageNamed:@"marker_pin.png"];
            annView.annotation = annotation;
            annView.tag = idx;
            annView.canShowCallout = YES;
            UIButton *button1 =	[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            
            button1.tag = idx;
            [button1 addTarget:self action:@selector(annotationTapped:) forControlEvents:UIControlEventTouchUpInside];
            annView.rightCalloutAccessoryView =  button1;
            idx++;

        }
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"marker.png"]];
        annView.leftCalloutAccessoryView = imgView;
        return annView;

    }
    return nil;

}

-(void)annotationTapped:(id)sender
{
    ActivityDetailsViewController *move = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivityDetailsViewController"];
    [self.navigationController pushViewController:move animated:YES];
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    // NSLog(@"%d",view.tag);
}

#pragma mark - Location update

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    coordinate_currentlocation =  newLocation.coordinate;
    // NSLog(@"%f  %f ", coordinate_currentlocation.latitude, coordinate_currentlocation.longitude);
}

@end
