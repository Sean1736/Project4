//
//  ViewController.m
//  CoffeeFinder
//
//  Created by Cindy Barnsdale on 5/20/16.
//  Copyright © 2016 Salar Kohnechi. All rights reserved.
//

#import "ViewController.h"

//First start out by adding these two imports, then go to CoffeeFinder main menu and add CoreLocations.framework and Mapkit.framework in the linked frameworks and libraries section.
#import <CoreLocation/CoreLocation.h>
#import <MapKit/Mapkit.h>
//Once we create the new file CoffeeShop.h we have to use the import feature.
#import "CoffeeShop.h"
#import "DirectionsViewController.h"

//After we link up our tableView in storyboard, add UITableViewDelegate, and UITableViewDataSource
@interface ViewController () <CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource>
// Next add CLLocationManager property, needed to get location of the user.


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  // When the view loads we want it to execute this code
    // We will get an error because we need to add <CLLocationManagerDelegate> to the ViewController above.
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    //now add privacy location usage description & NSLocationAlwaysUsageDescription in info.plist on the left.
    //After the user allows authorization, start updating location.
    [self.locationManager startUpdatingLocation];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.coffeeShops.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    CoffeeShop *coffeeShop = [self.coffeeShops objectAtIndex:indexPath.row];
    cell.textLabel.text = coffeeShop.mapItem.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f miles away", coffeeShop.distance];
    return cell;
}

//Now that we have the users location we can start using the locationManager delegate method to use that location so when they update their location, didUpdateLocations will make a property of type CLLocation which we insert above.
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    // userLocation from the property above, using the locations area from the LocationManager.
    self.userLocation = locations.firstObject;
    [self.locationManager stopUpdatingLocation];
    [self findCoffeePlaces:self.userLocation];


}

//Make a new method to find coffee places near our location.

-(void)findCoffeePlaces:(CLLocation *)location{
    MKLocalSearchRequest *request = [MKLocalSearchRequest new];
    request.naturalLanguageQuery = @"coffee";
    request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.5, 0.5));
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *mapItems = response.mapItems;
       
        NSMutableArray *tempArray = [NSMutableArray new];
        for (int i = 0; i < 5; i++) {
            MKMapItem *mapItem = [mapItems objectAtIndex:i];
            CLLocationDistance distance = [mapItem.placemark.location distanceFromLocation:self.userLocation];
            float milesDistance = distance / 1609.34;
            CoffeeShop *coffeeShop = [CoffeeShop new];
            coffeeShop.mapItem = mapItem;
            coffeeShop.distance = milesDistance;
            //Add NSMutableArray before the for loop.
            [tempArray addObject:coffeeShop];
        }
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:true];
        NSArray *sortedArray = [tempArray sortedArrayUsingDescriptors:[NSArray arrayWithObject: sortDescriptor]];
        self.coffeeShops = [NSArray arrayWithArray:sortedArray];
        
        for (CoffeeShop *coffeeShop in self.coffeeShops) {
            NSLog(@"%f", coffeeShop.distance);
        }
        [self.tableView reloadData];
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
DirectionsViewController *dvc = segue.destinationViewController;
    dvc.coffeeShop = [self.coffeeShops objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    dvc.userLocation = self.userLocation;
}
@end
