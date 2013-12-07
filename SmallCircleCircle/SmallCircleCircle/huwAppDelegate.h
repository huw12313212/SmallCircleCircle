//
//  huwAppDelegate.h
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/15.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#define USER_PLIST @"fb_user_2.plist"
#define USER_ID @"fb_id"
#define USER_NAME @"fb_name"


#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface huwAppDelegate : UIResponder <UIApplicationDelegate>

+ (bool) isURL;
+ (NSString*) getOpenId;
+ (void) setOpenId:(NSString*)activityID;
+ (void) clearURL;
+ (NSString*)FB_ID;
+ (void)setFB_ID:(NSString*) userID;
+ (NSString*)FB_Name;
+ (void)setFB_Name:(NSString*) name;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FBSession *session;
@end
