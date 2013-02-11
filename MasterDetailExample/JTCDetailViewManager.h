//
//  JTCDetailViewManager.h
//  MasterDetailExample
//
//  Created by Steve Jackson on 2/8/13.
//  Copyright (c) 2013 Steve Jackson. All rights reserved.
//

@protocol SubstitutableDetailViewController
@property (nonatomic, retain) UIBarButtonItem *navigationPaneBarButtonItem;
@end

#import <Foundation/Foundation.h>

@interface JTCDetailViewManager : NSObject <UISplitViewControllerDelegate>

@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;
@property (nonatomic, assign) IBOutlet UIViewController<SubstitutableDetailViewController> *detailViewController;

-(id)initWithSplitViewController:(UISplitViewController*)splitViewController;

@end
