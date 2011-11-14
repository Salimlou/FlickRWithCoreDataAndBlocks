//
//  PlaceGetter.m
//  FlickRWithCoreDataAndBlocks
//
//  Created by Salim Benabbou on 13/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PlaceGetter.h"

@implementation Place(PlaceGetter)

+(Place *) placeById:(NSString *)_placeId inContext:(NSManagedObjectContext *) context{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:context];
    request.fetchBatchSize = 20;
    request.fetchLimit = 100;
    request.sortDescriptors =
    [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@ "placeID" ascending:YES]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"placeID == %@", _placeId];
    request.predicate = predicate;
    
    NSError * error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if ([results count] ==1) {
        return [results objectAtIndex:0];
    }
    return nil;
}
@end
