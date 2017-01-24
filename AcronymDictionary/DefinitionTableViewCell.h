//
//  DefinitionTableViewCell.h
//  AcronymDictionary
//
//  Created by Thomas Lextrait (Personal) on 1/24/17.
//  Copyright © 2017 Thomas Lextrait. All rights reserved.
//

@import UIKit;

#import "AcronymDefinition.h"

@interface DefinitionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *definitionLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

- (void)setDefinition:(AcronymDefinition*)definition;

@end
