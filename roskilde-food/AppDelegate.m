//
//  AppDelegate.m
//  roskilde-food
//
//  Created by Karlo Kristensen on 20/03/14.
//  Copyright (c) 2014 floskel. All rights reserved.
//

#import "AppDelegate.h"
#import "RFFoodApi.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	RACSignal *importSignal = [RFFoodApi importFoodLocations];
    
	[importSignal subscribeNext:^(id x) {
		NSLog(@"%@", x);
	} completed:^{
		NSLog(@"done");
	}];

	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end