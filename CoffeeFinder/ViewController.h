//
//  ViewController.h
//  CoffeeFinder
//
//  Created by Cindy Barnsdale on 5/20/16.
//  Copyright © 2016 Salar Kohnechi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/Mapkit.h>
//Once we create the new file CoffeeShop.h we have to use the import feature.
#import "CoffeeShop.h"
@interface ViewController : UIViewController
@property CLLocationManager *locationManager;
@property CLLocation *userLocation;
@property NSArray *coffeeShops;
@end

