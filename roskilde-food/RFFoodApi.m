//
// Created by Karlo Kristensen on 20/03/14.
// Copyright (c) 2014 floskel. All rights reserved.
//

#import "RFFoodApi.h"

@interface RFFoodApi ()

@end

@implementation RFFoodApi


+ (RACReplaySubject *)importFoodLocations {
	NSString *endpoint = @"categories/22/locations.json";

	RACSignal *importSignal = [RFFoodApi importEndpoint:endpoint];
	RACReplaySubject *result = [RACReplaySubject subject];
    
	[importSignal subscribeNext:^(id value) {
		NSData *data = value;
		id results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
		NSArray *locations = results[@"locations"];
		NSArray *titles = [[[locations rac_sequence] map:^id(NSDictionary *location) {
			return location[@"title"];
		}] array];

		[result sendNext:titles];
	}];

	[importSignal subscribeError:^(NSError *error) {
		[result sendError:error];
	} completed:^{
		[result sendCompleted];
	}];

	return result;
}

+ (RACReplaySubject *) importEndpoint:(NSString *)endpoint{
	RACReplaySubject *result = [RACReplaySubject subject];

	NSURL *baseURL = [NSURL URLWithString:@"http://locations.roskildelabs.com/"];
	NSURL *endpointURL = [NSURL URLWithString:endpoint relativeToURL:baseURL];

	NSURLRequest *request = [NSURLRequest requestWithURL:endpointURL];

	[[[NSURLSession sharedSession] dataTaskWithRequest:request
									 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
										 if (!error) {
											 [result sendNext:data];
											 [result sendCompleted];
										 } else {
											 [result sendError:error];
										 }
									 }]
			resume];

	return result;
}


@end