//
//  JoinedBuyDetailViewController.h
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/19.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoinedBuyDetailViewController : UITableViewController

+(JoinedBuyDetailViewController*)GetInstance;

@property (nonatomic,weak) NSDictionary* activityDetail;
@property (nonatomic,weak) NSArray* buyList;

@end
