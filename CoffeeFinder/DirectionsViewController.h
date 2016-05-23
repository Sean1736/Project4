//
//  DirectionsViewController.h
//  CoffeeFinder
//
//  Created by Cindy Barnsdale on 5/22/16.
//  Copyright © 2016 Salar Kohnechi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CoffeeShop.h"
@interface DirectionsViewController : UIViewController


@property CoffeeShop *coffeeShop;
@property CLLocation *userLocation;
@end
