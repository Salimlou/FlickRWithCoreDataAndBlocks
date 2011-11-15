//
//  PhotosByPlaceFlickrViewController.m
//  FlickRWithCoreDataAndBlocks
//
//  Created by Salim Benabbou on 13/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotosByPlaceFlickrViewController.h"
#import "PhotoViewController.h"
#import "Photo.h"
#import "FlickrFetcher.h"
#import "Place.h"
#import "PlaceGetter.h"


@implementation PhotosByPlaceFlickrViewController

-(void)doMoreProcessing
{
    NSLog(@"Do More Processing");
}

-(NSDictionary *) getFlickrInfoForPhoto:(NSDictionary *) dico
{
    
    NSString * idPhoto = [dico objectForKey:@"id"];
    NSString * serverPhoto = [dico objectForKey:@"server"];
    NSString * farmPhoto = [dico objectForKey:@"farm"];
    NSString * secretPhoto = [dico objectForKey:@"secret"];
    
    return [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:idPhoto,serverPhoto,farmPhoto,secretPhoto, nil] forKeys:[NSArray arrayWithObjects:@"id",@"server" ,@"farm",@"secret",nil]];
    
}
-(NSString *) getManagedObjectIdAtIndexPath:(NSIndexPath *)indexPath{
    return [NSString stringWithFormat:@"%@",[self getFlickrInfoForPhoto:[listObjects objectAtIndex:indexPath.row]]];
}
- (void)managedObjectSelected:(NSDictionary *)managedObject
{
    NSLog(@"%@",managedObject);
    PhotoViewController * photoViewController =[[PhotoViewController alloc] init];
    photoViewController.imageURL = [FlickrFetcher urlStringForPhotoWithFlickrInfo:[self getFlickrInfoForPhoto:managedObject] format:FlickrFetcherPhotoFormatLarge];
    [self.navigationController pushViewController:photoViewController animated:NO];
    [photoViewController release];
}

-(void)fillManagedObject:(NSManagedObject *) object withData:(NSDictionary *) data{
    Photo * photo = (Photo *)object;
    photo.imageURl = [NSString stringWithFormat:@"%@",[FlickrFetcher urlStringForPhotoWithFlickrInfo:[self getFlickrInfoForPhoto:data] format:FlickrFetcherPhotoFormatMedium]];
    photo.title= [NSString stringWithFormat:@"%@",[data objectForKey:@"title"]];
    photo.thumbnailUrl= [NSString stringWithFormat:@"%@",[FlickrFetcher urlStringForPhotoWithFlickrInfo:[self getFlickrInfoForPhoto:data] format:FlickrFetcherPhotoFormatThumbnail]];
    photo.imageID= [NSString stringWithFormat:@"%@",[self getFlickrInfoForPhoto:data]];
    photo.latitude= [NSString stringWithFormat:@"%@",[data objectForKey:@"latitude"]];
    photo.longitude= [NSString stringWithFormat:@"%@",[data objectForKey:@"longitude"]];
    photo.farm= [NSString stringWithFormat:@"%@",[data objectForKey:@"farm"]];
    photo.server= [NSString stringWithFormat:@"%@",[data objectForKey:@"server"]];
    
    Place * place =[Place placeById:[data objectForKey:@"place_id"] inContext:managedObjectContext];
    if (place) {
        photo.takenIn = place;
        [place addPhotosInThatPlaceObject:photo];
    }
    
}
@end
