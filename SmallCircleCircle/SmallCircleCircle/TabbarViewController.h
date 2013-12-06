//
//  TabbarViewController.h
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/18.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabbarViewController : UITabBarController

@property (nonatomic,strong) NSDictionary* activityDetail;
@property (nonatomic,strong) NSArray* buyList;

-(void)updateData;

@end
