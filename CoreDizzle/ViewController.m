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

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) NSManagedObjectContext *objectContext;
@property (strong, nonatomic) NSArray *labels;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
    
    NSError *error;
    
    self.labels = [self.objectContext executeFetchRequest:fetchRequest error:&error];
    
    NSLog(@" count: %lu", (unsigned long)self.labels.count);
    
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [self.labels[indexPath.row] name];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.labels.count;
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

@end









