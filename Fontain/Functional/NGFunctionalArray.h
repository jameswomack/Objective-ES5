//
//  NGFunctionalArray.h
//  Fontain
//
//  Created by James Womack on 4/12/15.
//  Copyright (c) 2015 James Womack. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id  (^NGFunctionalMapBlock)   (id currentObject, NSUInteger idx, BOOL *stop);
typedef id  (^NGFunctionalReduceBlock)(id context, id currentObject, NSUInteger idx, BOOL *stop);
typedef BOOL(^NGFunctionalFilterBlock)(id currentObject, NSUInteger idx, BOOL *stop);
typedef NGFunctionalFilterBlock NGFunctionalEveryBlock;
typedef NGFunctionalFilterBlock NGFunctionalSomeBlock;

@interface NSArray (NGFunctionalArray)

/*
 This effectively wraps `enumerateObjectsUsingBlock:` so that it embodies
 map- & filter-like behavior (returning a "mapped" object, but enabling
 "filtering" by returning `nil` from `mapBlock`.
 
 As with `enumerateObjectsUsingBlock:`, assigning `YES` to `*stop` will
 short-circuit the enumeration.
 */
- (NSMutableArray *)map:(NGFunctionalMapBlock)mapBlock;


/*
 This effectively wraps `enumerateObjectsUsingBlock:` so that it embodies
 reduce-like behavior (returning a "reduced" object that is simply the
 result of recursively accumulating the result of `reduceBlock`.
 
 As with `enumerateObjectsUsingBlock:`, assigning `YES` to `*stop` will
 short-circuit the enumeration.
 */
- (id)reduce:(NGFunctionalReduceBlock)reduceBlock context:(id)reduceToThis;

/*
 This effectively wraps `enumerateObjectsUsingBlock:` so that it embodies
 filter-like behavior (returning a "filtered" object that is the result 
 of adding objects that pass the test of `filterBlock`.
 
 Note that you may prefer to use `map:` in some cases as it contains
 this functionality in addition to map-like functionality.
 
 As with `enumerateObjectsUsingBlock:`, assigning `YES` to `*stop` will
 short-circuit the enumeration.
 */
- (NSMutableArray *)filter:(NGFunctionalFilterBlock)filterBlock;


/*
 This effectively wraps `enumerateObjectsUsingBlock:` so that it embodies
 every-like behavior (returning a boolean value that is the result
 of checking objects until one doesn't pass the test of `everyBlock`.
 
 As with `enumerateObjectsUsingBlock:`, assigning `YES` to `*stop` will
 short-circuit the enumeration.
 */
- (BOOL)every:(NGFunctionalEveryBlock)everyBlock;

/*
 This effectively wraps `enumerateObjectsUsingBlock:` so that it embodies
 some-like behavior (returning a boolean value that is the result
 of checking objects until one passes the test of `someBlock`.
 
 As with `enumerateObjectsUsingBlock:`, assigning `YES` to `*stop` will
 short-circuit the enumeration.
 */
- (BOOL)some:(NGFunctionalSomeBlock)someBlock;


/*
 This wraps `enumerateObjectsUsingBlock:`
 */
- (void)forEach:(void (^)(id, NSUInteger, BOOL *))block;

@end


@interface NSMutableArray(NGFunctionalArray)
- (void)push:(id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;
- (void)pop;
- (void)shift;
- (void)unshift:(id)object;
- (NSUInteger)lastIndexOf:(id)object;
@end
