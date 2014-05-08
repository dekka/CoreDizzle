//
//  ViewController.m
//  CoreDizzle
//
//  Created by Reed Sweeney on 5/7/14.
//  Copyright (c) 2014 Reed Sweeney. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate+CoreDataContext.h"
#import "Label.h"
#import "ArtistViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) NSManagedObjectContext *objectContext;
@property (strong, nonatomic) NSArray *labels;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    [appDelegate createManagedObjectContext:^(NSManagedObjectContext *context) {
        
        self.objectContext = context;
        
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    

    
}

- (IBAction)seedCoreData:(id)sender
{
    Label *rapLabel = [NSEntityDescription insertNewObjectForEntityForName:@"Label" inManagedObjectContext:self.objectContext];
    
    rapLabel.name = @"Bros and Women 4 Lyfe";
    
    Label *countryLabel = [NSEntityDescription insertNewObjectForEntityForName:@"Label" inManagedObjectContext:self.objectContext];
    
    countryLabel.name = @"Pickup Trucks and Farms";
    
    Label *popLabel = [NSEntityDescription insertNewObjectForEntityForName:@"Label" inManagedObjectContext:self.objectContext];
    
    popLabel.name = @"Lolipopcorn";
    
    NSError *error;
    [self.objectContext save:&error];
    
    if (error) {
        NSLog(@"error: %@", error.localizedDescription);
    }
    
}

- (IBAction)fetchResults:(id)sender
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Label"];
//    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"name = %@",@"Lolipopcorn"];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.objectContext sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController.delegate = self;
    NSError *fetchError;
    [self.fetchedResultsController performFetch:&fetchError];
    
//    NSError *error;
    
//    self.labels = [self.objectContext executeFetchRequest:fetchRequest error:&error];
    
    NSLog(@" count: %lu", (unsigned long)self.labels.count);
    
    [self.tableView reloadData];
}

- (IBAction)addLabel:(id)sender
{
    Label *newLabel = [NSEntityDescription insertNewObjectForEntityForName:@"Label" inManagedObjectContext:self.objectContext];
    newLabel.name = @"Walruses";
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections]count];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goToArtist"])
    {
        ArtistViewController *destinationVC = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        destinationVC.selectedLabel = self.labels[indexPath.row];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [object valueForKey:@"name"];
}


@end









