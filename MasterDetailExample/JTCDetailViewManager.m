//
//  JTCDetailViewManager.m
//  MasterDetailExample
//
//  Created by Steve Jackson on 2/8/13.
//  Copyright (c) 2013 Steve Jackson. All rights reserved.
//

#import "JTCDetailViewManager.h"

@interface JTCDetailViewManager()

@property (nonatomic, retain) UIBarButtonItem *navigationPaneButtonItem;
@property (nonatomic, retain) UIPopoverController *navigationPopoverController;

@end

@implementation JTCDetailViewManager

- (void)setDetailViewController:(UIViewController<SubstitutableDetailViewController> *)detailViewController
{
    // Clear any bar button item from the detail view controller that is about to
    // no longer be displayed.
    self.detailViewController.navigationPaneBarButtonItem = nil;
    
    _detailViewController = detailViewController;
    
    // Set the new detailViewController's navigationPaneBarButtonItem to the value of our
    // navigationPaneButtonItem.  If navigationPaneButtonItem is not nil, then the button
    // will be displayed.
    //_detailViewController.navigationPaneBarButtonItem = self.navigationPaneButtonItem;
    
    // Update the split view controller's view controllers array.
    // This causes the new detail view controller to be displayed.
    UIViewController *navigationViewController = [self.splitViewController.viewControllers objectAtIndex:0];
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:navigationViewController, _detailViewController, nil];
    self.splitViewController.viewControllers = viewControllers;
    
    // Dismiss the navigation popover if one was present.  This will
    // only occur if the device is in portrait.
    if (self.navigationPopoverController)
        [self.navigationPopoverController dismissPopoverAnimated:YES];

}

-(id)initWithSplitViewController:(UISplitViewController *)splitViewController
{
    self = [super init];
    
    if (self) {
        self.splitViewController = splitViewController;
    }
    
    return self;
}

#pragma mark UISpitViewDelegate
// -------------------------------------------------------------------------------
//	splitViewController:shouldHideViewController:inOrientation:
// -------------------------------------------------------------------------------
- (BOOL)splitViewController:(UISplitViewController *)svc
shouldHideViewController:(UIViewController *)vc
inOrientation:(UIInterfaceOrientation)orientation
{
    return UIInterfaceOrientationIsPortrait(orientation);
}

// -------------------------------------------------------------------------------
//	splitViewController:willHideViewController:withBarButtonItem:forPopoverController:
// -------------------------------------------------------------------------------
- (void)splitViewController:(UISplitViewController *)svc
willHideViewController:(UIViewController *)aViewController
withBarButtonItem:(UIBarButtonItem *)barButtonItem
forPopoverController:(UIPopoverController *)pc
{
    // If the barButtonItem does not have a title (or image) adding it to a toolbar
    // will do nothing.
    barButtonItem.title = @"Navigation";
    
    self.navigationPaneButtonItem = barButtonItem;
    self.navigationPopoverController = pc;
    
    // Tell the detail view controller to show the navigation button.
    self.detailViewController.navigationPaneBarButtonItem = barButtonItem;
}

// -------------------------------------------------------------------------------
//	splitViewController:willShowViewController:invalidatingBarButtonItem:
// -------------------------------------------------------------------------------
- (void)splitViewController:(UISplitViewController *)svc
willShowViewController:(UIViewController *)aViewController
invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    self.navigationPaneButtonItem = nil;
    self.navigationPopoverController = nil;
    
    // Tell the detail view controller to remove the navigation button.
    self.detailViewController.navigationPaneBarButtonItem = nil;
}

@end

