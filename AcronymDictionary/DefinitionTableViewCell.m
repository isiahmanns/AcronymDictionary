//
//  DefinitionTableViewCell.m
//  AcronymDictionary
//
//  Created by Thomas Lextrait (Personal) on 1/24/17.
//  Copyright © 2017 Thomas Lextrait. All rights reserved.
//

#import "DefinitionTableViewCell.h"

@implementation DefinitionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDefinition:(AcronymDefinition*)definition
{
    self.definitionLabel.text = definition.lf;
    self.ageLabel.text = [NSString stringWithFormat:@"Used for %ld years", [definition age]];
}

@end
