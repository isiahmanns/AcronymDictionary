//
//  AcronymDefinitions.m
//  AcronymDictionary
//
//  Created by Thomas Lextrait (Personal) on 1/24/17.
//  Copyright © 2017 Thomas Lextrait. All rights reserved.
//

#import "AcronymDefinitions.h"
#import "AcronymDefinition.h"

@implementation AcronymDefinitions

- (instancetype)init
{
    self = [super init];
    if(self){
        self.sf = @"";
        self.lfs = @[];
    }
    return self;
}

- (instancetype)initWithResponse:(NSDictionary*)dictionary
{
    self = [self init];
    if(self){
        self.sf = dictionary[@"sf"];
        
        NSArray<NSDictionary*>* definitionDicts = dictionary[@"lfs"];
        NSMutableArray<AcronymDefinition*>* definitions = [NSMutableArray array];
        
        if(definitionDicts){
            for (NSDictionary* def in definitionDicts) {
                AcronymDefinition* definition = [[AcronymDefinition alloc] initWithResponse:def];
                if(definition){
                    [definitions addObject:definition];
                }
            }
        }
        
        // Sort definition by # of years, descending
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"age"
                                                     ascending:NO];
        NSArray *sortedDefinitions = [definitions sortedArrayUsingDescriptors:@[sortDescriptor]];
        
        self.lfs = sortedDefinitions;
    }
    return self;
}

/**
 * @brief Returns the number of acronym definitions found for this acronym
 * @return: definition count
 */
- (long)definitionCount
{
    return self.lfs ? self.lfs.count : 0;
}

@end
