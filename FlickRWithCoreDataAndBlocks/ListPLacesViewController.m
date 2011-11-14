//
//  ListPhoto.m
//  FlickingQuery
//
//  Created by Salim Benabbou on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ListPLacesViewController.h"
#import "FlickrFetcher.h"
#import "PhotoViewController.h"
#import "ListPhotoByPlacesController.h"
#import "Place.h"

@interface ListPLacesViewController ()
@property (retain) NSArray * listOfPlaces;
@property (retain) NSArray * photosforPlace ;
@property (retain) UIActivityIndicatorView *spinner;
@property (retain) NSManagedObjectContext *managedObjectContext;
@end
@implementation ListPLacesViewController

@synthesize listOfPlaces,photosforPlace,spinner,managedObjectContext;


- (void)dealloc {
    [spinner release];
    [photosforPlace release];
    [listOfPlaces release];
    [managedObjectContext release];
    [super dealloc];
}


- (id)initWithContext:(NSManagedObjectContext *)_managedObjectContext
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.managedObjectContext = _managedObjectContext;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.frame = [[UIScreen mainScreen] applicationFrame];
    [self.view addSubview:spinner];
    [spinner startAnimating];
    [FlickrFetcher topPlacesWithBlock:^(NSArray * places){
        self.listOfPlaces = places;
        self.view = self.tableView;
        [self.tableView reloadData];
        [spinner stopAnimating];
        NSLog(@"%@",self.listOfPlaces);
    }];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return listOfPlaces.count;
}

-(NSDictionary *)getDicotinnaryForIndexPath:(NSIndexPath *) indexPath
{
    return [self.listOfPlaces objectAtIndex:indexPath.row];
}

-(void)getInfoForIndexPath:(NSIndexPath *)indexPath
{
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSDictionary * placeInfo = [self getDicotinnaryForIndexPath:indexPath];
    
    cell.textLabel.text = [placeInfo objectForKey:@"_content"];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
     
     Place * place = [NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:self.managedObjectContext];
    
    NSDictionary * placeInfo = [self getDicotinnaryForIndexPath:indexPath];

    place.content= [placeInfo objectForKey:@"_content"];
    place.latitude= [placeInfo objectForKey:@"latitude"];
    place.placeType= [placeInfo objectForKey:@"place_type"];
    place.placeTypeId= [placeInfo objectForKey:@"place_type_id"];
    place.placeID= [placeInfo objectForKey:@"place_id"];
    place.placeUrl= [placeInfo objectForKey:@"place_url"];
    place.timeZone= [placeInfo objectForKey:@"timezone"];
    place.woeid= [placeInfo objectForKey:@"woeid"];
     
     NSError *error = nil;
     if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
     NSLog(@"Error! %@, %@", error, [error userInfo]);
     abort(); //generatesacrashlogfordebuggingpurposes 
     }
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Added to Top Places" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
    [alertView show];
     
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    ListPhotoByPlacesController * listPhotoViewController =[[ListPhotoByPlacesController alloc] init];
    NSDictionary * placeInfo = [self getDicotinnaryForIndexPath:indexPath];
    listPhotoViewController.placeId = [placeInfo objectForKey:@"place_id"];
    [self.navigationController pushViewController:listPhotoViewController animated:YES];
    [listPhotoViewController release];
    
}

@end
