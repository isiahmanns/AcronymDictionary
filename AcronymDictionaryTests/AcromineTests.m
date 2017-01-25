//
//  AcromineTests.m
//  AcronymDictionary
//
//  Created by Thomas Lextrait (Personal) on 1/24/17.
//  Copyright © 2017 Thomas Lextrait. All rights reserved.
//

@import XCTest;

#import "Acromine.h"

@interface AcromineTests : XCTestCase

@end

// Timeout we expect for endpoints
NSTimeInterval expectedTimeout = 15.0;

@implementation AcromineTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRetrieveDefinitions {
    XCTestExpectation* expectation = [self expectationWithDescription:@"Request should work"];
    
    NSString* search = @"CPU";
    
    NSURLSessionDataTask* task = [Acromine definitionsFor:search completion:^(AcronymDefinitions* definitions) {
        
        // Response and its properties shouldn't be nil
        XCTAssertNotNil(definitions);
        XCTAssertNotNil(definitions.sf);
        XCTAssertNotNil(definitions.lfs);
        
        // Methods should return correct information
        XCTAssertTrue([definitions.sf isEqualToString:search]);
        XCTAssertGreaterThan([definitions definitionCount], 0);
        XCTAssertGreaterThan(definitions.lfs.count, 0);
        XCTAssertEqual(definitions.lfs.count, [definitions definitionCount]);
        
        AcronymDefinition* def1 = definitions.lfs.firstObject;
        XCTAssertNotNil(def1);
        XCTAssertGreaterThan([def1 age], 0);
        XCTAssertNotNil(def1.lf);
        XCTAssertGreaterThanOrEqual(def1.freq, 0);
        XCTAssertGreaterThanOrEqual(def1.since, 0);
        
        [expectation fulfill];
    }];
    [task resume];
    
    [self waitForExpectationsWithTimeout:expectedTimeout handler:^(NSError* error) {
        XCTAssertNil(error);
    }];
}

- (void)testRetrieveDefinitionsWithInvalidSearch {
    XCTestExpectation* expectation = [self expectationWithDescription:@"Request should work"];
    
    NSString* search = @"Apple Sauce";
    
    NSURLSessionDataTask* task = [Acromine definitionsFor:search completion:^(AcronymDefinitions* definitions) {
        
        // Response and its properties shouldn't be nil
        XCTAssertNotNil(definitions);
        XCTAssertNotNil(definitions.sf);
        XCTAssertNotNil(definitions.lfs);
        
        // Methods should return correct information
        XCTAssertEqual([definitions definitionCount], 0);
        XCTAssertEqual(definitions.lfs.count, 0);
        XCTAssertEqual(definitions.lfs.count, [definitions definitionCount]);
        
        [expectation fulfill];
    }];
    [task resume];
    
    [self waitForExpectationsWithTimeout:expectedTimeout handler:^(NSError* error) {
        XCTAssertNil(error);
    }];
}

@end
