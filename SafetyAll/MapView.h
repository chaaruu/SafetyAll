//
//  MapView.h
//  SafetyAll
//
//  Created by satish mishra on 26/03/13.
//  Copyright (c) 2013 satish.mshr@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapView : UIViewController
{
    IBOutlet CLLocationManager *locationManager;
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@end
