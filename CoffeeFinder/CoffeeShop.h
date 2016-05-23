//
//  CoffeeShop.h
//  CoffeeFinder
//
//  Created by Cindy Barnsdale on 5/20/16.
//  Copyright © 2016 Salar Kohnechi. All rights reserved.
//

#import <Foundation/Foundation.h>
// Add mapkit to CoffeeShop.h
#import <MapKit/Mapkit.h>

@interface CoffeeShop : NSObject
// Create property MKMapItem & for the float we created on ViewController.m
@property MKMapItem *mapItem;
@property float distance;

@end
