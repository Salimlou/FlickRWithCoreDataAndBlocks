//
//  TopPlacesFlickRViewController.m
//  FlickRWithCoreDataAndBlocks
//
//  Created by Salim Benabbou on 13/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TopPlacesFlickRViewController.h"
#import "PhotosByPlaceFlickrViewController.h"
#import "Place.h"
#import "PlaceGetter.h"


@implementation TopPlacesFlickRViewController

-(void)doMoreProcessing
{
    NSLog(@"Do More Processing");
}


- (void)managedObjectSelected:(NSDictionary *)managedObject
{
    PhotosByPlaceFlickrViewController * tabView =[[PhotosByPlaceFlickrViewController alloc] initWithContext:managedObjectContext];
    tabView.titleKey =@"title";
	tabView.subtitleKey =@"place_id";
    tabView.nameOfClass =@"Photo";
    tabView.keyName=@"";
    tabView.keyNameDb =@"imageID";
    tabView.typeOfDataToGet = FlickDataToGetPhotosAtPlace;
    tabView.criteria =[managedObject objectForKey:@"place_id"];
    tabView.hasThumb = YES;
    tabView.title = @"List of photos";

    [self.navigationController pushViewController:tabView animated:NO];
    [tabView release];
}

-(void)fillManagedObject:(NSManagedObject *) object withData:(NSDictionary *) data{

    Place *place = (Place *)object;    
    place.content= [data objectForKey:@"_content"];
    place.latitude= [data objectForKey:@"latitude"];
    place.placeType= [data objectForKey:@"place_type"];
    place.placeTypeId= [NSString stringWithFormat:@"%@",[data objectForKey:@"place_type_id"]];
    place.placeID= [data objectForKey:@"place_id"];
    place.placeUrl= [data objectForKey:@"place_url"];
    place.timeZone= [data objectForKey:@"timezone"];
    place.woeid= [data objectForKey:@"woeid"];

}
@end
