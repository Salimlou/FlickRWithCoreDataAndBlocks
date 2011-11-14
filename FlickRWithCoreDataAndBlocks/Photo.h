//
//  Photo.h
//  FlickRWithCoreDataAndBlocks
//
//  Created by Salim Benabbou on 13/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photograph, Place;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * imageURl;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * thumbnailUrl;
@property (nonatomic, retain) NSString * imageID;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * farm;
@property (nonatomic, retain) NSString * server;
@property (nonatomic, retain) Photograph *takenBy;
@property (nonatomic, retain) Place *relationship;

@end
