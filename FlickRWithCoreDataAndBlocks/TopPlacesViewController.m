//
//  TopPlacesViewController.m
//  FlickRWithCoreDataAndBlocks
//
//  Created by Salim Benabbou on 13/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TopPlacesViewController.h"
#import "ListPhotoByPlaceCoreDataViewController.h"


@implementation TopPlacesViewController

-(id)initWithManagedObjectContext:(NSManagedObjectContext *) context{

    if (self=[self initWithStyle:UITableViewStylePlain]) {
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
		request.entity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:context];
		request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"content"
																						 ascending:YES
																						  selector:@selector(caseInsensitiveCompare:)]];
		request.predicate = nil;
		request.fetchBatchSize = 20;
		
		NSFetchedResultsController *frc = [[NSFetchedResultsController alloc]
                                           initWithFetchRequest:request
                                           managedObjectContext:context
                                           sectionNameKeyPath:@"content"
                                           cacheName:@"MyPhotogCache"];
        
		[request release];
		
		self.fetchedResultsController = frc;
		[frc release];
		
		self.titleKey = @"content";
		self.searchKey = @"content";
        
    }
    return self;
}


-(void) managedObjectSelected:(NSManagedObject *)managedObject{
    Place * placeSelected = (Place *) managedObject;
    ListPhotoByPlaceCoreDataViewController * photoByPlaceController = [[ListPhotoByPlaceCoreDataViewController alloc] initWithPlace:placeSelected];
    [self.navigationController pushViewController:photoByPlaceController animated:YES];
    [photoByPlaceController release];

}
@end
