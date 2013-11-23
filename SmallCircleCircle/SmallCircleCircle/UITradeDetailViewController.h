//
//  UITradeDetailViewController.h
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/17.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITradeDetailViewController : UITableViewController
@property (strong,nonatomic)NSMutableArray* EntryList;
@property (nonatomic,strong)NSMutableDictionary* dictionary;
@property bool Creating;
-(void)updateData;

@end
