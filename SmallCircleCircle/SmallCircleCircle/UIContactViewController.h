//
//  UIContactViewController.h
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/18.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIContactViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *PhoneNumber;

@property(nonatomic,weak)NSDictionary *ActivityDetail;
@property (weak,nonatomic)NSMutableArray* BuyAmountArray;
@property (strong,nonatomic)NSString* Location;
@property (strong,nonatomic)NSString* Date;

@end
