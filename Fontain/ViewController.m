//
//  ViewController.m
//  Fontain
//
//  Created by James Womack on 4/12/15.
//  Copyright (c) 2015 James Womack. All rights reserved.
//

#import "ViewController.h"
#import "NGFunctionalArray.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *fonts;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  if (!self.fonts) {    
    self.fonts = [[UIFont fontNamesForFamilyName:@"Helvetica Neue"]
     map:^id(NSString *fontName, NSUInteger idx, BOOL *stop) {
      return [UIFont fontWithName:fontName size:14.f];
    }];
  }
  
  NSLog(@"%@", self.fonts);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
