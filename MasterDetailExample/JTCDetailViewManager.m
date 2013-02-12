//
//  JTCDetailViewManager.m
//  MasterDetailExample
//
//  Created by Steve Jackson on 2/8/13.
//  Copyright (c) 2013 Steve Jackson. All rights reserved.
//

#import "JTCDetailViewManager.h"

@interface JTCDetailViewManager()
@property (weak, nonatomic)UISplitViewController *splitViewController;
@property (strong, nonatomic)NSArray *detailControllers;
@property (weak, nonatomic)UIViewController *currentDetailController;

@property (nonatomic, retain) UIBarButtonItem *navigationPaneButtonItem;
@property (nonatomic, retain) UIPopoverController *navigationPopoverController;

@end

@implementation JTCDetailViewManager

@synthesize splitViewController = _splitViewController;
@synthesize detailControllers = _detailControllers;
@synthesize navigationPaneButtonItem = _navigationPaneButtonItem;
@synthesize navigationPopoverController = _navigationPopoverController;
@synthesize currentDetailController = _currentDetailController;


-(id)initWithSplitViewController:(UISplitViewController *)splitViewController withDetailRootControllers:(NSArray *)detailControllers
{
    self = [super init];
    
    if (self) {
        self.splitViewController = splitViewController;
        _detailControllers = detailControllers;
        UINavigationController *detailRoot = [splitViewController.viewControllers objectAtIndex:1];
        _currentDetailController = detailRoot;
        
        splitViewController.delegate = self;
        UITabBarController *tabBar = [splitViewController.viewControllers objectAtIndex:0];
        tabBar.delegate = self;
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
    barButtonItem.title = NSLocalizedString(@"Menu", @"Menu");
    
    self.navigationPaneButtonItem = barButtonItem;
    self.navigationPopoverController = pc;
    
    [self.currentDetailController.navigationItem setLeftBarButtonItem:self.navigationPaneButtonItem animated:YES];
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
    [self.currentDetailController.navigationItem setLeftBarButtonItem:nil animated:YES];
}

#pragma mark - UITabBarControllerDelegate

// change detail view to reflect the current master controller
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    UINavigationController* detailRootController = [self.detailControllers objectAtIndex:tabBarController.selectedIndex];
    UIViewController* detailController = detailRootController.topViewController;
    
    if(detailController != self.currentDetailController)
    {
        // swap button in detail controller
        [self.currentDetailController.navigationItem setLeftBarButtonItem:nil animated:NO];
        self.currentDetailController = detailController;
        [self.currentDetailController.navigationItem setLeftBarButtonItem:self.navigationPaneButtonItem animated:NO];
        
        // update controllers in splitview
        UIViewController* tabBarController = [self.splitViewController.viewControllers objectAtIndex:0];
        self.splitViewController.viewControllers = [NSArray arrayWithObjects:tabBarController,detailRootController, nil];
        
        // replace the passthrough views with current detail navigationbar
        if([self.navigationPopoverController isPopoverVisible]){
            self.navigationPopoverController.passthroughViews = [NSArray arrayWithObject:detailRootController.navigationBar];
        }
    }
}

@end

