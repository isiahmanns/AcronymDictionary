//
//  AcronymDefinition.h
//  AcronymDictionary
//
//  Created by Thomas Lextrait (Personal) on 1/24/17.
//  Copyright © 2017 Thomas Lextrait. All rights reserved.
//

@import Foundation;

@interface AcronymDefinition : NSObject

@property (nonatomic, strong) NSString* lf;
@property long freq;
@property long since;

- (instancetype)initWithResponse:(NSDictionary*)dictionary;
- (long)age;

@end
