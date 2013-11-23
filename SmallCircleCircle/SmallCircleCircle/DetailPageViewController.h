//
//  DetailPageViewController.h
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/23.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailPageViewController : UIPageViewController  <UIPageViewControllerDataSource>
@property (nonatomic,strong)NSDictionary* ActivityDetail;
@end
