//
//  PlaceGetter.h
//  FlickRWithCoreDataAndBlocks
//
//  Created by Salim Benabbou on 13/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Place.h"

@interface Place (PlaceGetter)

+(Place *) placeById:(NSString *)_placeId inContext:(NSManagedObjectContext *) context;

@end
