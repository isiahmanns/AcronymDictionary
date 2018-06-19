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
#import "MBProgressHUD/MBProgressHUD.h"

@interface SearchTableViewController ()

@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) AcronymDefinitions* definitions;
@property (strong, nonatomic) MBProgressHUD* hud;

@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.definesPresentationContext = YES;
    
    // Search bar setup
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.searchBar.prompt = @"Enter an acronym, eg. CPU";
    self.searchBar.translucent = NO;
    //[self.searchBar sizeToFit];
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.searchBar.keyboardType = UIKeyboardTypeAlphabet;
    
    CGRect newFrame = self.view.frame;
    newFrame.size.width = self.view.frame.size.width;
    newFrame.size.height = 95;
    [self.searchBar setFrame:newFrame];
    
    self.tableView.tableHeaderView = self.searchBar;
    self.tableView.rowHeight = 60.0;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DefinitionTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"definition-cell"];
    
    self.cachedAcromine = [[CachedAcromineController alloc] init];
    self.cachedAcromine.delegate = self;
    
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"About"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(showAboutAlert)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Clear the cache to make space for memory!
    if(self.cachedAcromine){
        [self.cachedAcromine dumpCache];
    }
}

- (void)showAboutAlert
{
    NSLog(@"'About' button clicked.");
    
    /*[self.navigationController pushViewController:[UIAlertController alertControllerWithTitle:@"About Acromine"
                                                                                      message:@"asdfasdfasf"
                                                                               preferredStyle:UIAlertControllerStyleAlert]
                                         animated:NO];
     */
    
    NSString *blurb = @"Acromine is an app that takes in any sequence of intials and uses the Acromine API to fetch acronyms that your abbreviation could represent from the MEDLINE database.";
    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"About Acromine"
                                                                       message:blurb
                                                                preferredStyle:UIAlertControllerStyleAlert];
    
    [alertView addAction:[UIAlertAction actionWithTitle:@"Close"
                                                  style:UIAlertActionStyleDefault handler:^void (UIAlertAction *action){
                                                      [self dismissViewControllerAnimated:YES
                                                                               completion:NULL];
                                                  }]];
    
    [self presentViewController:alertView
                       animated:YES
                     completion:NULL];
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


#pragma mark - UITableViewDelegate protocol
//inherited from UITableViewController (could put this into a cateogory)
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *data = [(DefinitionTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath] definitionLabel].text;
    NSLog(@"%@", data);
    
    NSString *search_url = [[NSString stringWithFormat:@"http://www.google.com/search?q=%@", data] stringByReplacingOccurrencesOfString:@" " withString:@"+"];

    NSLog(@"%@", search_url);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:search_url]
                                       options:@{}
                             completionHandler:^void(BOOL success) {
                                 NSLog(@"Opened URL?: %d", success);
                             }];
}

#pragma mark - AcromineControllerDelegate protocol implementation

- (void)searchEnded:(AcronymDefinitions *)definitions
{
    self.definitions = definitions;
    [self.tableView reloadData];
    [self.hud hideAnimated:YES];
}

- (void)searchBegan
{
    [self.hud showAnimated:YES];
}


@end
