//
//  ListPhotoByPlacesController.h
//  FlickingQuery
//
//  Created by Salim Benabbou on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListPhotoByPlacesController : UITableViewController{
    NSString * placeId;
    NSArray * photoByPlaces;
    UIActivityIndicatorView * spinner;
}

@property (retain) NSString * placeId;
@end
