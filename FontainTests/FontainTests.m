//
//  FontainTests.m
//  FontainTests
//
//  Created by James Womack on 4/12/15.
//  Copyright (c) 2015 James Womack. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NGFunctionalArray.h"



typedef BOOL(^NGBooleanTestResult)(id object);



@interface FontainTests : XCTestCase {
  NSString *tyrion;
  NSString *sansa;
  NGBooleanTestResult containsLannister;
  NGBooleanTestResult isSansa;
  NSMutableArray *arrayOfThrones;
}
@end




@implementation FontainTests




- (void)setUp {
  [super setUp];
  
  tyrion = @"Tyrion Lannister";
  
  sansa = @"Sansa Stark";
  
  NSString *lannister = [tyrion componentsSeparatedByString:@" "][1];

  containsLannister = ^(id currentObject){
    return [currentObject containsString:lannister];
  };
  
  __weak NSString *_sansa = sansa;
  isSansa = ^(id currentObject){
    return [currentObject containsString:_sansa];
  };
  
  arrayOfThrones = @[tyrion,@"Ned Stark",sansa,@"Jon Snow",@"Khaleesi",@"Hodor"].mutableCopy;
}



- (void)tearDown {
  tyrion = nil;
  
  sansa = nil;
  
  containsLannister = nil;
  
  isSansa = nil;
  
  [arrayOfThrones removeAllObjects];
  arrayOfThrones = nil;
  
  [super tearDown];
}




- (void)testMapFilter {
  NSMutableArray *lannistersOnly = [arrayOfThrones map:^id(NSString *currentObject, NSUInteger idx, BOOL *stop) {
    return containsLannister(currentObject) ? currentObject : nil;
  }];
  
  XCTAssert([lannistersOnly count] == 1, @"The map contained only one element");
  XCTAssert([lannistersOnly isEqualToArray:@[tyrion]], @"The array mapped to only Lannisters");
}



- (void)testMapShortCircuit {
  NSMutableArray *lannistersOnly = [arrayOfThrones map:^id(NSString *currentObject, NSUInteger idx, BOOL *stop) {
    if(isSansa(currentObject)){
      *stop = YES;
    }
    return currentObject;
  }];
  
  
  NSArray *subsetFromShortCircuit = @[tyrion,@"Ned Stark",sansa]; // array literals fail inside these macros
  XCTAssert([lannistersOnly isEqualToArray:subsetFromShortCircuit], @"The array mapped to only Lannisters");
}



- (void)testReduceFilter {
  NSMutableDictionary *nameMap = [arrayOfThrones reduce:^id(NSMutableDictionary *context, NSString *currentName, NSUInteger idx, BOOL *stop) {
    context[currentName] = currentName;
    return context;
  } context:@{}.mutableCopy];
  
  [arrayOfThrones enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
    XCTAssert([[nameMap objectForKey:name] isEqualToString:name], @"%@ maps to %@", name, name);
  }];
}



- (void)testReduceShortCircuit {
  NSMutableDictionary *nameMap = [arrayOfThrones reduce:^id(NSMutableDictionary *context, NSString *currentName, NSUInteger idx, BOOL *stop) {
    context[currentName] = currentName;
    if ([currentName isEqualToString:sansa]) {
      *stop = YES;
    }
    return context;
  } context:@{}.mutableCopy];
  
  XCTAssert([[nameMap allKeys] count] == 3, @"The map contains 3 objects as it stopped after %@", sansa);
}



- (void)testFilter {
  NSMutableArray *lannistersOnly = [arrayOfThrones filter:^BOOL(NSString *currentObject, NSUInteger idx, BOOL *stop) {
    return containsLannister(currentObject);
  }];
  
  XCTAssert([lannistersOnly count] == 1, @"The map contained only one element");
  XCTAssert([lannistersOnly isEqualToArray:@[tyrion]], @"The array mapped to only Lannisters");
}



- (void)testFilterShortCircuit {
  NSMutableArray *lannistersOnly = [arrayOfThrones filter:^BOOL(NSString *currentObject, NSUInteger idx, BOOL *stop) {
    if(isSansa(currentObject)){
      *stop = YES;
    }
    return YES;
  }];
  
  
  NSArray *subsetFromShortCircuit = @[tyrion,@"Ned Stark",sansa]; // array literals fail inside these macros
  XCTAssert([lannistersOnly isEqualToArray:subsetFromShortCircuit], @"The array mapped to only Lannisters");
}


- (void)testEvery {
  __block NSUInteger iterations = 0;
  
  BOOL lannistersOnly = [arrayOfThrones every:^BOOL(NSString *currentObject, NSUInteger idx, BOOL *stop) {
    iterations++;
    return containsLannister(currentObject);
  }];
  
  XCTAssert(!lannistersOnly, @"The array was not only Lannisters");
  XCTAssert(iterations == 2, @"As Ned was second, only two iterations were needed");
}


- (void)testSome {
  __block NSUInteger iterations;
  
  BOOL lannistersOnly = [arrayOfThrones some:^BOOL(NSString *currentObject, NSUInteger idx, BOOL *stop) {
    iterations++;
    return containsLannister(currentObject);
  }];
  
  XCTAssert(lannistersOnly, @"The array did contain a Lannister");
  XCTAssert(iterations == 1, @"As Tyrion was first, only one iteration was needed");
}


@end
