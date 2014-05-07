//
//  SongViewController.m
//  CoreDizzle
//
//  Created by Reed Sweeney on 5/7/14.
//  Copyright (c) 2014 Reed Sweeney. All rights reserved.
//

#import "SongViewController.h"
#import "Song.h"

@interface SongViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *saveSong;
@property (strong, nonatomic) NSArray *songs;
@property (weak, nonatomic) IBOutlet UITextField *songNameField;
@property (weak, nonatomic) IBOutlet UITextField *songLengthField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SongViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.songNameField.delegate = self;
    self.songLengthField.delegate = self;
    self.songs = [self.selectedAlbum.songs allObjects];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SongCell" forIndexPath:indexPath];
    
    Song *song = self.songs[indexPath.row];
    cell.textLabel.text = song.name;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.songs.count;
}






- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



- (IBAction)saveSong:(id)sender {
    
    Song *newSong = [NSEntityDescription insertNewObjectForEntityForName:@"Song" inManagedObjectContext:self.selectedAlbum.managedObjectContext];
    
    newSong.name = self.songNameField.text;
    newSong.length = self.songLengthField.text;
    newSong.album = self.selectedAlbum;
    
    NSError *error;
    
    [self.selectedAlbum.managedObjectContext save:&error];
    
    self.songs = [self.selectedAlbum.songs allObjects];
    [self.tableView reloadData];
    
}

@end
