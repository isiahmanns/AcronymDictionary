//
//  Acromine.h
//  AcronymDictionary
//
//  Created by Thomas Lextrait (Personal) on 1/24/17.
//  Copyright © 2017 Thomas Lextrait. All rights reserved.
//

@import Foundation;

#import "AcronymDefinitions.h"

@interface Acromine : NSObject

+ (void)definitionsFor:(NSString*)acronym
            completion:(void(^)(AcronymDefinitions*))completion;

@end
