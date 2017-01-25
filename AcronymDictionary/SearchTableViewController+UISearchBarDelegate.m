//
//  SearchTableViewController+UISearchBarDelegate.m
//  AcronymDictionary
//
//  Created by Thomas Lextrait (Personal) on 1/24/17.
//  Copyright © 2017 Thomas Lextrait. All rights reserved.
//

#import "SearchTableViewController+UISearchBarDelegate.h"
#import "Acromine.h"
#import "MBProgressHUD/MBProgressHUD.h"

@implementation SearchTableViewController (UISearchBarDelegate)

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length == 0){
        return;
    }
    
    [self.cachedAcromine search:searchText];
}

@end
