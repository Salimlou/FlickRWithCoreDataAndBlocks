//
//  ListPhotoByPlaceCoreDataViewController.m
//  FlickRWithCoreDataAndBlocks
//
//  Created by Salim Benabbou on 13/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ListPhotoByPlaceCoreDataViewController.h"
#import "Photo.h"
#import "PhotoViewController.h"

@implementation ListPhotoByPlaceCoreDataViewController

- (id)initWithPlace:(Place *)placeSelected
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        NSManagedObjectContext *context = placeSelected.managedObjectContext;
        
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		request.entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:context];
		request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
		request.predicate = [NSPredicate predicateWithFormat:@"relationship = %@", placeSelected];
		request.fetchBatchSize = 20;
		
		[NSFetchedResultsController deleteCacheWithName:@"MyPhotoCache"];
		NSFetchedResultsController *frc = [[NSFetchedResultsController alloc]
                                           initWithFetchRequest:request
                                           managedObjectContext:context
                                           sectionNameKeyPath:nil
                                           cacheName:nil];
        
		[request release];
		
		self.fetchedResultsController = frc;
		[frc release];
		
		self.titleKey = @"title";
		self.searchKey = @"title";
    }
    return self;
}

-(void) managedObjectSelected:(NSManagedObject *)managedObject
{
    Photo *photo = (Photo *) managedObject;
    PhotoViewController * photoViewController = [[PhotoViewController alloc] init];
    photoViewController.imageURL =  photo.imageURl;
    [self.navigationController pushViewController:photoViewController animated:YES];
    [photoViewController release];
}
@end
