//
//  huwAppDelegate.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/15.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "huwAppDelegate.h"
<<<<<<< HEAD
#import <Parse/Parse.h>
=======
>>>>>>> be54ca681ed663993d1d1a80c1501f8d84adc284

@implementation huwAppDelegate

static bool _isURL = false;
static NSString* _openID = @"-1";

+ (bool) isURL
{
    return _isURL;
}
+ (NSString*) getOpenId
{
    return _openID;
}

+ (void) clearURL
{
    _openID = @"-1";
    _isURL = false;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
<<<<<<< HEAD
    [Parse setApplicationId:@"jigcccFU23yCJWb51bJ7Htt70ipoprGeouMUJNBb"
                  clientKey:@"hmbyJNUBVfjqAWwfwDDTCxfRAOACPqjFrOGaInZB"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
=======
    
>>>>>>> be54ca681ed663993d1d1a80c1501f8d84adc284
    return YES;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    // Handle url request.
    
    NSString* activityID = [[url absoluteString]substringFromIndex:6];

    _isURL = YES;
   // int i =  [activityID integerValue];
    _openID = activityID;
    
    //NSLog(@"testss");
    
    //UIViewController* mainController = self.window;
    

    UINavigationController* nowController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    

    
    [nowController popToRootViewControllerAnimated:false];
    [nowController.topViewController performSegueWithIdentifier:@"OpenURL" sender:self];

    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
