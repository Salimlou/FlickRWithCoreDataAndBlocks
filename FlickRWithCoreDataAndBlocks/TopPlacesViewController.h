//
//  TopPlacesViewController.h
//  FlickRWithCoreDataAndBlocks
//
//  Created by Salim Benabbou on 13/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "Place.h"

@interface TopPlacesViewController : CoreDataTableViewController{
    
  

}

-(id)initWithManagedObjectContext:(NSManagedObjectContext *) context;



@end
