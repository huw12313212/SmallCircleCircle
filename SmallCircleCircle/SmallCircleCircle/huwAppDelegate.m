//
//  huwAppDelegate.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/15.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "huwAppDelegate.h"

@implementation huwAppDelegate

@synthesize session = _session;
static bool _isURL = false;
static NSString* _openID = @"-1";
static NSString* _userID= @"0";
static NSString* _name = @"guest";

+ (NSString*)FB_ID
{
    return _userID;
}

+ (void)setFB_ID:(NSString*) userID
{
    _userID = userID;
}
+ (NSString*)FB_Name
{
    return _name;
}
+ (void)setFB_Name:(NSString*) name
{
    _name = name;
}

+ (bool) isURL
{
    return _isURL;
}

+ (void) setOpenId:(NSString*)activityID
{
    _isURL = true;
    _openID = activityID;
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
    
    return YES;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    // Handle url request.
    
    NSRange range = [[url absoluteString]rangeOfString:@"fb"];
    if(range.length>0&&range.location==0)
    {
        [FBAppCall handleOpenURL:url
               sourceApplication:sourceApplication
                     withSession:self.session];
    }
    else
    {
    NSString* activityID = [[url absoluteString]substringFromIndex:6];

    _isURL = YES;
   // int i =  [activityID integerValue];
    _openID = activityID;
    
    //NSLog(@"testss");
    
    //UIViewController* mainController = self.window;
    

    UINavigationController* nowController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    

    
    [nowController popToRootViewControllerAnimated:false];
    [nowController.topViewController performSegueWithIdentifier:@"OpenURL" sender:self];
    }

    
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

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBAppEvents activateApp];
    
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    // FBSample logic
    // We need to properly handle activation of the application with regards to SSO
    //  (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
    [FBAppCall handleDidBecomeActiveWithSession:self.session];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // FBSample logic
    // if the app is going away, we close the session if it is open
    // this is a good idea because things may be hanging off the session, that need
    // releasing (completion block, etc.) and other components in the app may be awaiting
    // close notification in order to do cleanup
    [self.session close];
}


@end
