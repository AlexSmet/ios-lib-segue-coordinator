//
//  NSExceptionCatch.m
//  Pods
//
//  Created by Евгений Сафронов on 25.01.17.
//
//

#import "NSExceptionCatch.h"

@implementation NSExceptionCatch

+ (BOOL)catchException:(void(^)())tryBlock error:(__autoreleasing NSError **)error {
    @try {
        tryBlock();
        return YES;
    }
    @catch (NSException *exception) {
        *error = [[NSError alloc] initWithDomain:exception.name code:0 userInfo:exception.userInfo];
    }
}

@end