//
//  AlbumViewController.h
//  CoreDizzle
//
//  Created by Reed Sweeney on 5/7/14.
//  Copyright (c) 2014 Reed Sweeney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Artist.h"

@interface AlbumViewController : UIViewController

@property (weak, nonatomic) Artist *selectedArtist;

@end
