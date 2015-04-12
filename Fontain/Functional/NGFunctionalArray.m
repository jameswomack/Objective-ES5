//
//  NGFunctionalArray.m
//  Fontain
//
//  Created by James Womack on 4/12/15.
//  Copyright (c) 2015 James Womack. All rights reserved.
//


#import "NGFunctionalArray.h"



@implementation NSMutableArray(NGFunctionalArray)


// typedef id(^NGFunctionalMapBlock)(id currentObject, NSUInteger idx, BOOL *stop);

- (NSMutableArray *)map:(NGFunctionalMapBlock)mapBlock; {
  NSMutableArray *mapToThis = @[].mutableCopy; // we will return this
  
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    id mapResult;
    
    if ((mapResult = mapBlock(obj, idx, stop))) { // ->
      [mapToThis addObject:mapResult];
    }
  }];
  
  return mapToThis;
}


// typedef id(^NGFunctionalReduceBlock)(id context, id currentObject, NSUInteger idx, BOOL *stop);

- (id)reduce:(NGFunctionalReduceBlock)reduceBlock context:(id)reduceToThis; {
  __block id reduceResult; // we will return this
  
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    reduceResult = reduceBlock(reduceToThis, obj, idx, stop);
  }];
  
  return reduceResult;
}


// typedef BOOL(^NGFunctionalFilterBlock)(id currentObject, NSUInteger idx, BOOL *stop);

- (NSMutableArray *)filter:(NGFunctionalFilterBlock)filterBlock; {
  NSIndexSet *indexSet = [self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
    return filterBlock(obj, idx, stop);
  }];
  
  return [[self objectsAtIndexes:indexSet] mutableCopy];
}


// typedef BOOL(^NGFunctionalEveryBlock)(id currentObject, NSUInteger idx, BOOL *stop);

- (BOOL)every:(NGFunctionalEveryBlock)everyBlock; {
  __block BOOL every = YES; // we will return this
  
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if (!everyBlock(obj, idx, stop)) { // ->
      *stop = YES;
      every = NO;
    }
  }];
  
  return every;
}


// typedef BOOL(^NGFunctionalSomeBlock)(id currentObject, NSUInteger idx, BOOL *stop);

- (BOOL)some:(NGFunctionalSomeBlock)someBlock; {
  __block BOOL some = NO; // we will return this
  
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if (someBlock(obj, idx, stop)) { // ->
      *stop = YES;
      some  = YES;
    }
  }];
  
  return some;
}


@end
