//
//  CachedAcromineController.h
//  AcronymDictionary
//
//  Created by Thomas Lextrait on 1/25/17.
//  Copyright © 2017 Thomas Lextrait. All rights reserved.
//

@import Foundation;

#import "AcronymDefinitions.h"

@protocol CachedAcromineDelegate

- (void)searchBegan;
- (void)searchEnded:(AcronymDefinitions*)definitions;

@end

@interface CachedAcromineController : NSObject

@property (weak, nonatomic) id<CachedAcromineDelegate> delegate;
@property int maxCachedKeys;

- (void)search:(NSString*)acronym;
- (void)dumpCache;

@end
