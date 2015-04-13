//
//  NSCharacterSetTests.m
//  Fontain
//
//  Created by James Womack on 4/12/15.
//  Copyright (c) 2015 James Womack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "UIFontCharacterExtractor.h"

@interface UIFontCharacterExtractorTests : XCTestCase {
  UIFont *font;
  UIFontCharacterExtractor *extractor;
}
@end

@implementation UIFontCharacterExtractorTests

- (void)setUp {
  [super setUp];
  font = [UIFont fontWithName:@"Helvetica Neue" size:14.f];
  extractor = [UIFontCharacterExtractor.alloc initWithFont:font];
}

- (void)tearDown {
  font = nil;
  extractor = nil;
  [super tearDown];
}

- (void)testExample {
  NSCharacterSet *capsSet = [NSCharacterSet capitalizedLetterCharacterSet];
  XCTAssert([extractor.availableCharacterSet isSupersetOfSet:capsSet], @"Pass");
}

@end
