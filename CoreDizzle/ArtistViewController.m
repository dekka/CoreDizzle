//
//  ArtistViewController.m
//  CoreDizzle
//
//  Created by Reed Sweeney on 5/7/14.
//  Copyright (c) 2014 Reed Sweeney. All rights reserved.
//

#import "ArtistViewController.h"
#import "Artist.h"
#import "AlbumViewController.h"

@interface ArtistViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *genreField;
@property (strong, nonatomic) NSArray *artists;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation ArtistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)saveArtist:(id)sender
{
    
    NSLog(@"hello");
    Artist *newArtist = [NSEntityDescription insertNewObjectForEntityForName:@"Artist" inManagedObjectContext:self.selectedLabel.managedObjectContext];
    
    newArtist.firstName = self.firstNameField.text;
    newArtist.lastName = self.lastNameField.text;
    newArtist.genre = self.genreField.text;
    newArtist.label = self.selectedLabel;
    
    NSError *error;
    [self.selectedLabel.managedObjectContext save:&error];
    
    self.artists = [self.selectedLabel.artists allObjects];
    [self.tableView reloadData];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.firstNameField.delegate = self;
    self.lastNameField.delegate = self;
    self.genreField.delegate = self;

    self.artists = [self.selectedLabel.artists allObjects];
    [self.tableView reloadData];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.artists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArtistCell"];
    Artist *artist = self.artists[indexPath.row];
    cell.textLabel.text = artist.firstName;
    return cell;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toAlbums"]) {
        AlbumViewController *destinationVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        destinationVC.selectedArtist = self.artists[indexPath.row];
    }
}


@end










