//
//  UICreateActivityInfoViewController.h
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/16.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICreateActivityInfoViewController : UIViewController
- (IBAction)ButtonClicked:(UIBarButtonItem *)sender;
@property (nonatomic,strong)NSMutableDictionary* dictionary;
@end
