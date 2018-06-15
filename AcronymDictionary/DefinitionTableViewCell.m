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
    
    NSMutableAttributedString *ageLabelWithAttrs = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Used for %ld years", [definition age]]];
    
    // Regex to find first occurence of an integer.
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"((\\d+) years)"
                                                                           options:0
                                                                             error:&error];
    
    NSArray<NSTextCheckingResult *> *matches = [regex matchesInString:ageLabelWithAttrs.string
                                                              options:0
                                                                range:NSMakeRange(0, ageLabelWithAttrs.string.length)];
    
    NSRange yearsQuantityRange;
    NSRange yearsStrRange;
    for (NSTextCheckingResult *match in matches) { // 3 total ranges [0-2], capture groups start at index 1
        NSLog(@"%@", [ageLabelWithAttrs.string substringWithRange:[match rangeAtIndex:1]]); // $1
        NSLog(@"%@", [ageLabelWithAttrs.string substringWithRange:[match rangeAtIndex:2]]); // $2
        NSLog(@"%lu", (unsigned long)match.numberOfRanges);
        
        yearsQuantityRange = [match rangeAtIndex:2];
        yearsStrRange = [match rangeAtIndex:1];
    }

    
    NSDictionary *yearsQuantityAttrs = @{
                                 NSFontAttributeName: [UIFont boldSystemFontOfSize: [UIFont systemFontSize]],
                                 NSForegroundColorAttributeName: [UIColor blueColor]
                                 };
    
    
    [ageLabelWithAttrs addAttributes:yearsQuantityAttrs range:yearsQuantityRange];
    [ageLabelWithAttrs addAttribute:NSFontAttributeName
                              value:[UIFont boldSystemFontOfSize:[UIFont systemFontSize]]
                              range:yearsStrRange];
    
    self.ageLabel.attributedText = ageLabelWithAttrs;
}

@end
