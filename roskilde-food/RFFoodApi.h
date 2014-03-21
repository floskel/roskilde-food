//
// Created by Karlo Kristensen on 20/03/14.
// Copyright (c) 2014 floskel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>


@interface RFFoodApi : NSObject

+ (RACSignal*)importFoodLocations;

@end