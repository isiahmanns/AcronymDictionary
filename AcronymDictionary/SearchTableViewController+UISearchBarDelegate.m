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
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //
    // @TODO BAD
    //
    
    [Acromine definitionsFor:searchText completion:^(AcronymDefinitions* def) {
        
        if([searchText isEqualToString:def.sf]){
            [self updateDefinitions:def];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }];
}

@end
