//
//  CachedAcromineController.m
//  AcronymDictionary
//
//  Created by Thomas Lextrait on 1/25/17.
//  Copyright © 2017 Thomas Lextrait. All rights reserved.
//

#import "CachedAcromineController.h"
#import "Acromine.h"

@interface CachedAcromineController()

// Stores the last search task so that it may be canceled if a new one is initiated before this one finishes
@property (nonatomic, strong) NSURLSessionDataTask* lastSearchTask;

@property (atomic, strong) NSMutableDictionary<NSString*, AcronymDefinitions*> *cache;

@end

@implementation CachedAcromineController

- (instancetype)init
{
    self = [super init];
    if(self) {
        self.maxCachedKeys = 200;
        self.cache = [NSMutableDictionary dictionary];
    }
    return self;
}

- (instancetype)initWithMaxCachedKeys:(int)maxCachedKeys
{
    self = [self init];
    if(self){
        self.maxCachedKeys = maxCachedKeys > 0 ? maxCachedKeys : 200;
    }
    return self;
}

- (void)search:(NSString*)acronym
{
    if(!acronym || !self.delegate){
        return;
    }
    
    // Cancel any pending task
    if(self.lastSearchTask){
        [self.lastSearchTask cancel];
    }
    
    // Check the cache
    if(self.cache[acronym]){
        [self.delegate searchEnded:self.cache[acronym]];
        return;
    }
    
    [self.delegate searchBegan];
    
    self.lastSearchTask = [Acromine definitionsFor:acronym completion:^(AcronymDefinitions* definitions) {
        
        if(definitions && [definitions.sf isEqualToString:acronym]) {
            self.cache[acronym] = definitions;
            
            // Ensure we're not going over the cache limit
            if(self.cache.count > self.maxCachedKeys){
                NSString* firstKey = self.cache.allKeys.firstObject;
                [self.cache removeObjectForKey:firstKey];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate searchEnded:definitions];
        });
        
    }];
    [self.lastSearchTask resume];
}

/**
 * @brief Dumps the cache, use this if the device runs out of memory
 */
- (void)dumpCache
{
    self.cache = [NSMutableDictionary dictionary];
}

@end
