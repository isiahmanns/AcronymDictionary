//
//  AcronymDefinition.m
//  AcronymDictionary
//
//  Created by Thomas Lextrait (Personal) on 1/24/17.
//  Copyright © 2017 Thomas Lextrait. All rights reserved.
//

#import "AcronymDefinition.h"

@implementation AcronymDefinition

- (instancetype)init
{
    self = [super init];
    if(self){
        self.lf = @"";
        self.freq = -1;
        self.since = -1;
    }
    return self;
}

- (instancetype)initWithResponse:(NSDictionary*)dictionary
{
    self = [self init];
    if(self){
        self.lf = dictionary[@"lf"] ? dictionary[@"lf"] : @"";
        self.freq = dictionary[@"freq"] ? [dictionary[@"freq"] longValue] : -1;
        self.since = dictionary[@"since"] ? [dictionary[@"since"] longValue] : -1;
    }
    return self;
}

/**
 * @brief Returns the age in years of this definition of an acronym
 * @return: age in years
 */
- (long)age
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear
                                                                   fromDate:[NSDate date]];
    NSInteger year = [components year];
    return year - self.since;
}

@end
