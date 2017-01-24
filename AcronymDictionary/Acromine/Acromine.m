//
//  Acromine.m
//  AcronymDictionary
//
//  Created by Thomas Lextrait (Personal) on 1/24/17.
//  Copyright © 2017 Thomas Lextrait. All rights reserved.
//

#import "Acromine.h"
#import "AFNetworking/AFNetworking.h"

@implementation Acromine

+ (void)definitionsFor:(NSString*)acronym
            completion:(void(^)(AcronymDefinitions*))completion
{
    if(!acronym){
        completion(nil);
        return;
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSDictionary<NSString*,NSString*> *parameters = @{@"sf": acronym};
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                                 URLString:AcromineEndpointURL
                                                                                parameters:parameters
                                                                                     error:nil];
    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    
    // The NACTEM endpoint returns plain text
    AFHTTPResponseSerializer* serializer = [AFHTTPResponseSerializer serializer];
    serializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", nil];
    manager.responseSerializer = serializer;
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if(error){
            NSLog(@"Error: %@", error);
            completion(nil);
            return;
        }
                                                    
        NSError *parseError = nil;
        id object = [NSJSONSerialization JSONObjectWithData:responseObject
                                                    options:0
                                                      error:&parseError];
        if(parseError){
            NSLog(@"Parse error: %@", parseError);
            completion(nil);
            return;
        }
        
        if(![object isKindOfClass:[NSArray class]]){
            NSLog(@"Unexpected response format, top level object not an array");
            completion(nil);
            return;
        }
                                                    
        if([(NSArray*)object count] == 0){
            completion([[AcronymDefinitions alloc] init]);
            return;
        }
                                                    
        NSDictionary* definitionsDict = [(NSArray<NSDictionary*>*)object firstObject];
        if(!definitionsDict){
            NSLog(@"Unexpected response format, first array object not a dictionary");
            completion(nil);
            return;
        }
                                                    
        completion([[AcronymDefinitions alloc] initWithResponse:definitionsDict]);
    }];
    [dataTask resume];
}

@end
