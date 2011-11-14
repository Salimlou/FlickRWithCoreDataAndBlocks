//
//  FlickrTableViewController.h
//  FlickRWithCoreDataAndBlocks
//
//  Created by Salim Benabbou on 13/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrFetcher.h"

typedef NSArray *(^download_operation_block)(NSString * criteria);


@interface FlickrTableViewController : UITableViewController<UIAlertViewDelegate>{
    
    NSArray * listObjects;
    UIActivityIndicatorView * spinner;
    NSManagedObjectContext *managedObjectContext;
    NSArray * listThumbnails;
    NSString *titleKey;
	NSString *subtitleKey;
    NSString * nameOfClass;
    download_operation_block theBlock;
    FlickDataToGet typeOfDataToGet;
    NSString *criteria;
    NSString *keyName;
    NSString *keyNameDb;
    UIImage * thumbnail;
    BOOL hasThumb;
    
}
@property (retain) NSString *titleKey;// key to use when displaying items in the table; defaults to the first sortDescriptor's key
@property (retain) NSString *subtitleKey; // key to use when displaying items in the table for the subtitle; defaults to nil
@property (retain) NSString *nameOfClass;
@property (retain) NSString *criteria;
@property (retain) NSString *keyName;
@property (retain) NSString *keyNameDb;
@property FlickDataToGet typeOfDataToGet;
@property BOOL hasThumb;

- (id)initWithContext:(NSManagedObjectContext *)managedObjectContext;

@end
