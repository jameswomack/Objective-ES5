//
//  UIFontCharacterExtractor.h
//  Fontain
//
//  Created by James Womack on 4/12/15.
//  Copyright (c) 2015 James Womack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIFontCharacterExtractor : NSObject
- (instancetype)initWithFont:(UIFont *)font;
- (NSCharacterSet *)availableCharacterSet;
- (NSArray *)availableCharacters;
@end
