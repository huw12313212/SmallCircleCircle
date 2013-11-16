//
//  huwAppDelegate.h
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/15.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface huwAppDelegate : UIResponder <UIApplicationDelegate>

+ (bool) isURL;
+ (int) getOpenId;
+ (void) clearURL;


@property (strong, nonatomic) UIWindow *window;

@end
