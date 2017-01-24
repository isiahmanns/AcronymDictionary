//
//  SearchTableViewController+UISearchBarDelegate.h
//  AcronymDictionary
//
//  Created by Thomas Lextrait (Personal) on 1/24/17.
//  Copyright © 2017 Thomas Lextrait. All rights reserved.
//

@import UIKit;

#import "SearchTableViewController.h"

@interface SearchTableViewController (UISearchBarDelegate) <UISearchBarDelegate>

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;

@end
