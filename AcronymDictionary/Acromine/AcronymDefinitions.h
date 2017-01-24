//
//  AcronymDefinitions.h
//  AcronymDictionary
//
//  Created by Thomas Lextrait (Personal) on 1/24/17.
//  Copyright © 2017 Thomas Lextrait. All rights reserved.
//

@import Foundation;

#import "AcronymDefinition.h"

@interface AcronymDefinitions : NSObject

@property (nonatomic, strong) NSString* sf;
@property (nonatomic, strong) NSArray<AcronymDefinition*>* lfs;

- (instancetype)initWithResponse:(NSDictionary*)dictionary;
- (long)definitionCount;

@end
