//
//  AppDelegate+CoreDataContext.h
//  CoreDizzle
//
//  Created by Reed Sweeney on 5/7/14.
//  Copyright (c) 2014 Reed Sweeney. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (CoreDataContext)

- (void)createManagedObjectContext:(void (^)(NSManagedObjectContext *context))completion;

@end
