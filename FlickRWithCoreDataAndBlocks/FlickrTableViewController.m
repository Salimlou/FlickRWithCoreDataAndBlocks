//
//  FlickrTableViewController.m
//  FlickRWithCoreDataAndBlocks
//
//  Created by Salim Benabbou on 13/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FlickrTableViewController.h"
#import "FlickrFetcher.h"



@interface FlickrTableViewController ()
@property (retain) NSArray * listObjects;
@property (retain) NSArray * listThumbnails ;
@property (retain) UIActivityIndicatorView *spinner;
@property (retain) NSManagedObjectContext *managedObjectContext;
@property (retain) UIImage * thumbnail;

@property (retain) download_operation_block theBlock;

@end
@implementation FlickrTableViewController

@synthesize listObjects,listThumbnails,spinner,managedObjectContext,title,titleKey,subtitleKey,nameOfClass,theBlock,typeOfDataToGet,criteria,keyName,keyNameDb,thumbnail,hasThumb;

- (id)initWithContext:(NSManagedObjectContext *)_managedObjectContext
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.managedObjectContext = _managedObjectContext;
        
    }
    return self;
}

-(void)doMoreProcessing
{
}


#pragma mark - View lifecycle
-(void)viewDidLoad{
    [super viewDidLoad];
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.frame = [[UIScreen mainScreen] applicationFrame];
    [self.view addSubview:spinner];
    [spinner startAnimating];
    [FlickrFetcher getData:self.typeOfDataToGet withCriteria:criteria withBlock:^(NSArray * dataBack){
        self.listObjects = dataBack;
        NSLog(@"%@", dataBack);
        [self doMoreProcessing];
        self.view = self.tableView;
        [self.tableView reloadData];
        [spinner stopAnimating];
    }];
    

}


- (NSManagedObject *) entityById:(NSString *)_placeId {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:self.nameOfClass inManagedObjectContext:self.managedObjectContext];
    request.fetchBatchSize = 20;
    request.fetchLimit = 100;
    request.sortDescriptors =
    [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:self.keyNameDb ascending:YES]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[self.keyNameDb stringByAppendingString:@" == %@"], _placeId];
    request.predicate = predicate;
    
    NSError * error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if ([results count] ==1) {
        return [results objectAtIndex:0];
    }
    return nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}



- (UITableViewCellAccessoryType)accessoryTypeForManagedObject:(NSDictionary *)managedObject
{
	return UITableViewCellAccessoryDetailDisclosureButton;
}

- (UIImage *)thumbnailImageForManagedObject:(NSDictionary *)managedObject forCell:(UITableViewCell *)cell
{
    return [FlickrFetcher getData:FlickDataToGetPhotoByUrl withCriteria:[FlickrFetcher urlStringForPhotoWithFlickrInfo:managedObject format:FlickrFetcherPhotoFormatSquare] withBlock:^(NSData * dataBack){
        thumbnail = [[UIImage alloc] initWithData:dataBack];
        if (thumbnail) {
          cell.imageView.image = thumbnail; 
            [self.tableView reloadData];

        } 
        }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listObjects.count;
}

-(NSDictionary *)getDicotinnaryForIndexPath:(NSIndexPath *) indexPath
{
    return [self.listObjects objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSDictionary * objectInfo = [self getDicotinnaryForIndexPath:indexPath];
    
    if (self.titleKey) cell.textLabel.text = [objectInfo valueForKey:self.titleKey];
	if (self.subtitleKey) cell.detailTextLabel.text = [objectInfo valueForKey:self.subtitleKey];
	cell.accessoryType = [self accessoryTypeForManagedObject:objectInfo];
    if (self.hasThumb) {
        [self thumbnailImageForManagedObject:objectInfo forCell:cell];
    }	  
    return cell;
}

- (void)managedObjectSelected:(NSDictionary *)managedObject
{
        // Navigation logic may go here. Create and push another view controller.
        // AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
        // [self.navigationController pushViewController:anotherViewController];
        // [anotherViewController release];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self managedObjectSelected:[listObjects objectAtIndex:indexPath.row]];
}


-(void)fillManagedObject:(NSManagedObject *) object withData:(NSDictionary *) data{


}
-(NSString *) getManagedObjectIdAtIndexPath:(NSIndexPath *)indexPath{
       return [[listObjects objectAtIndex:indexPath.row] valueForKey:self.keyName];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Added to Top Places" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
    if (![self entityById:[self getManagedObjectIdAtIndexPath:indexPath]]) {
        NSManagedObject * obj = [NSEntityDescription insertNewObjectForEntityForName:self.nameOfClass inManagedObjectContext:self.managedObjectContext];
        
        NSDictionary * objInfo = [self getDicotinnaryForIndexPath:indexPath];
        [self fillManagedObject:obj withData:objInfo];
        
        NSError *error = nil;
        if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
            [alertView release];
            alertView = nil;
            alertView = [[UIAlertView alloc] initWithTitle:@"failure" message:[NSString stringWithFormat:@"Error! %@, %@", error, [error userInfo]] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        }
        
    }else{
                  alertView = [[UIAlertView alloc] initWithTitle:@"failure" message:@"Alrday Existing" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
    }
  [alertView show];
    
    
}



- (void)dealloc {
    [listObjects release];
    [managedObjectContext release];
    [listThumbnails release];
    [spinner release];
    [super dealloc];
}
@end
