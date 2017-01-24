//
//  SearchTableViewController.h
//  AcronymDictionary
//
//  Created by Thomas Lextrait (Personal) on 1/24/17.
//  Copyright © 2017 Thomas Lextrait. All rights reserved.
//

@import UIKit;

#import "AcronymDefinitions.h"

@interface SearchTableViewController : UITableViewController

- (void)updateDefinitions:(AcronymDefinitions*)definitions;

@end
