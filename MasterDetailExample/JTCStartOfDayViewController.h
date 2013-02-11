//
//  JTCStartOfDayViewController.h
//  MasterDetailExample
//
//  Created by Steve Jackson on 2/8/13.
//  Copyright (c) 2013 Steve Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTCDetailViewManager.h"

@interface JTCStartOfDayViewController : UIViewController <SubstitutableDetailViewController>

/// Things for IB
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;

/// SubstitutableDetailViewController
@property (nonatomic, retain) UIBarButtonItem *navigationPaneBarButtonItem;


@end
