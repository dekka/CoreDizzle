//
//  AppDelegate.h
//  CoreDizzle
//
//  Created by Reed Sweeney on 5/7/14.
//  Copyright (c) 2014 Reed Sweeney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIManagedDocument *managedDocument;
@property (strong, nonatomic) NSManagedObjectContext *objectContext;

@end
