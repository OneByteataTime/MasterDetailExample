//
//  JTCMasterViewController.h
//  MasterDetailExample
//
//  Created by Steve Jackson on 2/8/13.
//  Copyright (c) 2013 Steve Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JTCDetailViewController;

#import <CoreData/CoreData.h>

@interface JTCMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) JTCDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
