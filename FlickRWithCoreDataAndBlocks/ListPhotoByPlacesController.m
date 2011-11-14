//
//  ListPhotoByPlacesController.m
//  FlickingQuery
//
//  Created by Salim Benabbou on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ListPhotoByPlacesController.h"
#import "FlickrFetcher.h"
#import "PhotoViewController.h"
#import "Place.h"

@interface ListPhotoByPlacesController ()
@property (retain) NSArray * photoByPlaces;
@property (retain) UIActivityIndicatorView *spinner;
@end

@implementation ListPhotoByPlacesController
@synthesize placeId,photoByPlaces,spinner ;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
            // Custom initialization
    }
    return self;
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.frame = [[UIScreen mainScreen] applicationFrame];
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    [FlickrFetcher photosAtPlaceWithBlock:^(NSArray * photos){
        self.photoByPlaces = photos;
        [spinner stopAnimating];
        self.view = self.tableView;
         [self.tableView reloadData];
        NSLog(@"%@",self.photoByPlaces);
        
    } alPlace:self.placeId];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.photoByPlaces count] ;
}


-(NSDictionary *) getRowInfoForIndexPath:(NSIndexPath *) indexPath
{
    return [self.photoByPlaces objectAtIndex:indexPath.row];
}

-(NSDictionary *) getFlickrInfoForPhoto:(NSDictionary *) dico
{
    
    NSString * idPhoto = [dico objectForKey:@"id"];
    NSString * serverPhoto = [dico objectForKey:@"server"];
    NSString * farmPhoto = [dico objectForKey:@"farm"];
    NSString * secretPhoto = [dico objectForKey:@"secret"];
    
    return [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:idPhoto,serverPhoto,farmPhoto,secretPhoto, nil] forKeys:[NSArray arrayWithObjects:@"id",@"server" ,@"farm",@"secret",nil]];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
        //id, server, farm, secret
   
    NSDictionary * dico = [self getRowInfoForIndexPath:indexPath];
    cell.textLabel.text = [dico objectForKey:@"title"];
   
    
    cell.imageView.image = [UIImage imageWithData:[FlickrFetcher imageDataForPhotoWithFlickrInfo:[self getFlickrInfoForPhoto:dico] format:FlickrFetcherPhotoFormatThumbnail]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

     PhotoViewController * photoViewController =[[PhotoViewController alloc] init];
     NSDictionary * placeInfo = [self getRowInfoForIndexPath:indexPath];
     photoViewController.imageURL = [FlickrFetcher urlStringForPhotoWithFlickrInfo:[self getFlickrInfoForPhoto:placeInfo] format:FlickrFetcherPhotoFormatLarge];
     [self.navigationController pushViewController:photoViewController animated:YES];
     [photoViewController release];
}


- (void)dealloc {
    [photoByPlaces release];
    [spinner release];
    [super dealloc];
}

@end
