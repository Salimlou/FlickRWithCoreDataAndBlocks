//
//  Place.h
//  FlickRWithCoreDataAndBlocks
//
//  Created by Salim Benabbou on 13/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Place : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * placeType;
@property (nonatomic, retain) NSString * placeTypeId;
@property (nonatomic, retain) NSString * placeID;
@property (nonatomic, retain) NSString * placeUrl;
@property (nonatomic, retain) NSString * timeZone;
@property (nonatomic, retain) NSString * woeid;
@property (nonatomic, retain) NSSet *photosInThatPlace;

@end



@interface Place (CoreDataGeneratedAccessors)

- (void)addPhotosInThatPlaceObject:(Photo *)value;
- (void)removePhotosInThatPlaceObject:(Photo *)value;
- (void)addPhotosInThatPlace:(NSSet *)values;
- (void)removePhotosInThatPlace:(NSSet *)values;

@end
