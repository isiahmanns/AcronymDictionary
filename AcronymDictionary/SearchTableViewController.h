//
//  SearchTableViewController.h
//  AcronymDictionary
//
//  Created by Thomas Lextrait (Personal) on 1/24/17.
//  Copyright © 2017 Thomas Lextrait. All rights reserved.
//

@import UIKit;

#import "AcronymDefinitions.h"
#import "CachedAcromineController.h"

@interface SearchTableViewController : UITableViewController <CachedAcromineDelegate>

@property (strong, nonatomic) CachedAcromineController* cachedAcromine;

@end
