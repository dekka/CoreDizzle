//
//  AlbumViewController.m
//  CoreDizzle
//
//  Created by Reed Sweeney on 5/7/14.
//  Copyright (c) 2014 Reed Sweeney. All rights reserved.
//

#import "SongViewController.h"
#import "AlbumViewController.h"
#import "Album.h"



@interface AlbumViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *albumNameField;
@property (weak, nonatomic) IBOutlet UITextField *albumReleaseDateField;
@property (strong, nonatomic) NSArray *albums;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation AlbumViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.albumNameField.delegate = self;
    self.albumReleaseDateField.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.albums = [self.selectedArtist.albums allObjects];
    [self.tableView reloadData];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.albums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumCell" forIndexPath:indexPath];
    
    Album *album = self.albums[indexPath.row];
    cell.textLabel.text = album.name;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAlbum:(id)sender
{
    Album *newAlbum = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:self.selectedArtist.managedObjectContext];
    
    newAlbum.name = self.albumNameField.text;
    newAlbum.releaseDate = self.albumReleaseDateField.text;
    newAlbum.artist = self.selectedArtist;
    
    NSError *error;
    
    [self.selectedArtist.managedObjectContext save:&error];
    
    self.albums = [self.selectedArtist.albums allObjects];
    [self.tableView reloadData];
    
    NSLog(@"number of albums: %lu", (unsigned long)self.albums.count);

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toSongs"])
    {
        SongViewController *destinationVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        destinationVC.selectedAlbum = self.albums[indexPath.row];
    }
}





@end
