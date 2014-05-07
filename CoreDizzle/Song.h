//
//  Song.h
//  CoreDizzle
//
//  Created by Reed Sweeney on 5/7/14.
//  Copyright (c) 2014 Reed Sweeney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Album;

@interface Song : NSManagedObject

@property (nonatomic, retain) NSString * length;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Album *album;

@end
