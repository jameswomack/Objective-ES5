//
//  ViewController.m
//  Fontain
//
//  Created by James Womack on 4/12/15.
//  Copyright (c) 2015 James Womack. All rights reserved.
//

#import "ViewController.h"
#import "NGFunctionalArray.h"
#import "UIFontCharacterExtractor.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) NSMutableArray *fonts;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSString *fontName = @"HelveticaNeue-Italic";
  UIFont *font = [UIFont fontWithName:fontName size:14.f];
  UIFontCharacterExtractor *extractor = [UIFontCharacterExtractor.alloc initWithFont:font];
  self.textView.font = font;
  self.textView.text = [extractor.availableCharacters componentsJoinedByString:@" "];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end
