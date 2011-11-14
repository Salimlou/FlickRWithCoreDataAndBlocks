//
//  ListPhoto.h
//  FlickingQuery
//
//  Created by Salim Benabbou on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ListPLacesViewController : UITableViewController<UIAlertViewDelegate>{
    
    NSArray * listOfPlaces;
    UIActivityIndicatorView * spinner;
    NSManagedObjectContext *managedObjectContext;
    
}
- (id)initWithContext:(NSManagedObjectContext *)managedObjectContext;
@end
