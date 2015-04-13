//
//  NGFunctionalArray.m
//  Fontain
//
//  Created by James Womack on 4/12/15.
//  Copyright (c) 2015 James Womack. All rights reserved.
//


#import "NGFunctionalArray.h"



@implementation NSArray(NGFunctionalArray)


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


- (void)forEach:(void (^)(id, NSUInteger, BOOL *))block {
  [self enumerateObjectsUsingBlock:block];
}

@end



@implementation NSMutableArray (NGFunctionalArray)


- (void)push:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION; {
  va_list args;
  va_start(args, firstObj);
  for (id arg = firstObj; arg != nil; arg = va_arg(args, id)){
    [self addObject:arg];
  }
  va_end(args);
}


- (void)pop {
  [self removeLastObject];
}


- (void)shift {
  [self removeObjectAtIndex:0];
}


- (void)unshift:(id)object {
  [self insertObject:object atIndex:0];
}


- (NSUInteger)lastIndexOf:(id)object {
  return [self indexOfObjectWithOptions:NSEnumerationReverse passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
    return [obj isEqual:object];
  }];
}


@end

