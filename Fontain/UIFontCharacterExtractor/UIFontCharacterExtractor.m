//
//  UIFontCharacterExtractor.m
//  Fontain
//
//  Created by James Womack on 4/12/15.
//  Copyright (c) 2015 James Womack. All rights reserved.
//

@import UIKit;
#import "UIFontCharacterExtractor.h"

@interface UIFontCharacterExtractor ()
@property (nonatomic, strong) UIFont *font;
@end


@implementation UIFontCharacterExtractor


- (instancetype)initWithFont:(UIFont *)font {
  if ((self = super.init)) {
    self.font = font;
  }
  return self;
}



- (NSCharacterSet *)availableCharacterSet; {
  return [self.font.fontDescriptor objectForKey:UIFontDescriptorCharacterSetAttribute];
}



/*
 From http://stackoverflow.com/a/15742659/230571
 */
- (NSArray *)availableCharacters {
  NSCharacterSet *charset = [self availableCharacterSet];
  NSMutableArray *array = [NSMutableArray array];
  for (int plane = 0; plane <= 16; plane++) {
    if ([charset hasMemberInPlane:plane]) {
      UTF32Char c;
      for (c = plane << 16; c < (plane+1) << 16; c++) {
        if ([charset longCharacterIsMember:c]) {
          UTF32Char c1 = OSSwapHostToLittleInt32(c); // To make it byte-order safe
          NSString *s = [[NSString alloc] initWithBytes:&c1 length:4 encoding:NSUTF32LittleEndianStringEncoding];
          [array addObject:s];
        }
      }
    }
  }
  return array;
}

@end
