//
//  UICompleteViewController.h
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/17.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICompleteViewController : UIViewController

@property (nonatomic,strong) NSString* ActivityID;

@property (weak, nonatomic) IBOutlet UIButton *URLButton;
@property bool share;

@end
