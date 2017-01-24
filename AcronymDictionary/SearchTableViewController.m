//
//  SearchTableViewController.m
//  AcronymDictionary
//
//  Created by Thomas Lextrait (Personal) on 1/24/17.
//  Copyright © 2017 Thomas Lextrait. All rights reserved.
//

#import "SearchTableViewController.h"
#import "AcronymDefinitions.h"
#import "DefinitionTableViewCell.h"

@interface SearchTableViewController ()

@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, atomic) AcronymDefinitions* definitions;

@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.definesPresentationContext = YES;
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.searchBar.prompt = @"Enter an acronym, eg. CPU";
    self.searchBar.translucent = NO;
    [self.searchBar sizeToFit];
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.searchBar.keyboardType = UIKeyboardTypeAlphabet;
    
    //self.tableView.tableHeaderView = self.searchController.searchBar;
    self.tableView.tableHeaderView = self.searchBar;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DefinitionTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"definition-cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.definitions != nil ? [self.definitions definitionCount] : 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DefinitionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"definition-cell"
                                                                    forIndexPath:indexPath];
    
    if(cell){
        [cell setDefinition:self.definitions.lfs[indexPath.row]];
    }
    
    return cell;
}

- (void)updateDefinitions:(AcronymDefinitions*)definitions
{
    self.definitions = definitions;
}

@end
