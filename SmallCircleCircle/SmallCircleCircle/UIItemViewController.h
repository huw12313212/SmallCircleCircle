//
//  UIItemViewController.h
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/16.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIItemViewController : UITableViewController

-(void)updateData;
@property (strong,nonatomic)NSMutableArray* ItemList;
@property (nonatomic,strong)NSMutableDictionary* dictionary;
@property bool Creating;
- (IBAction)NextButton:(UIBarButtonItem *)sender;

@end
